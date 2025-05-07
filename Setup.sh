#!/bin/bash

set -e

echo "🔍 Checking Docker installation..."
if ! command -v docker &> /dev/null; then
  echo "❌ Docker is not installed. Please install Docker and try again."
  exit 1
fi

echo "✅ Docker found."

read -p "🌐 Enter backend address (domain/ip): " SITE_METHOD

IS_DOMAIN=false
if [[ "$SITE_METHOD" =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
  IS_DOMAIN=true
  read -p "🔐 Is your domain using HTTPS? (y/n): " USE_HTTPS
  if [[ "$USE_HTTPS" == "y" || "$USE_HTTPS" == "Y" ]]; then
    PROTOCOL="https"
  else
    PROTOCOL="http"
  fi
else
  PROTOCOL="http"
fi

read -p "🔧 Enter backend port (default 8237): " BACKEND_PORT
BACKEND_PORT=${BACKEND_PORT:-8237}

if $IS_DOMAIN; then
  read -p "🌐 Is your domain behind a proxy like Cloudflare? (y/n): " BEHIND_PROXY
  if [[ "$BEHIND_PROXY" == "y" || "$BEHIND_PROXY" == "Y" ]]; then
    API_URL="${PROTOCOL}://${SITE_METHOD}"
  else
    API_URL="${PROTOCOL}://${SITE_METHOD}:${BACKEND_PORT}"
  fi
else
  API_URL="${PROTOCOL}://${SITE_METHOD}:${BACKEND_PORT}"
fi

read -p "🌐 Enter frontend port (default 80): " FRONTEND_PORT
FRONTEND_PORT=${FRONTEND_PORT:-80}

USERNAME="user_$(openssl rand -hex 4)"
PASSWORD="pass_$(openssl rand -hex 4)"
JWT_SECRET=$(openssl rand -base64 64 | tr -d '\n' | head -c 128)
DB_PORT=5432

BACKEND_IMAGE="criy/ws-home:backend-latest"
FRONTEND_IMAGE="criy/ws-home:frontend-latest"

echo "🛠 Creating Docker network..."
docker network create smart-home-net || echo "⚠️ Network already exists."

echo "📁 Creating config directory..."
mkdir -p config

cat > config/application.yml <<EOF
spring:
  datasource:
    url: jdbc:postgresql://ws-pg-db:${DB_PORT}/smart-home
    username: ${USERNAME}
    password: ${PASSWORD}
  jpa:
    hibernate:
      ddl-auto: update
  application:
    name: smart_home

jwt:
  secret: ${JWT_SECRET}
  expiration: 86400000
EOF

echo "✅ application.yml created in ./config"

echo "📦 Creating volume for PostgreSQL..."
docker volume create smart-home-pgdata

echo "🐘 Starting PostgreSQL container..."
docker run -d \
  --name ws-pg-db \
  --network smart-home-net \
  -e POSTGRES_USER=${USERNAME} \
  -e POSTGRES_PASSWORD=${PASSWORD} \
  -e POSTGRES_DB=smart-home \
  -v smart-home-pgdata:/var/lib/postgresql/data \
  postgres:15

echo "🚀 Starting backend container..."
docker run -d \
  --name ws-home-backend \
  --network smart-home-net \
  -v $(pwd)/config:/app/config \
  -e SPRING_CONFIG_LOCATION=file:/app/config/application.yml \
  -p ${BACKEND_PORT}:8080 \
  ${BACKEND_IMAGE}

echo "🎨 Starting frontend container..."
docker run -d \
  --name ws-home-frontend \
  -e API_URL=${API_URL} \
  -p ${FRONTEND_PORT}:80 \
  ${FRONTEND_IMAGE}

echo "✅ All containers are up and running!"
echo "🌐 Access your frontend via ${PROTOCOL}://${SITE_METHOD}:${FRONTEND_PORT}"
