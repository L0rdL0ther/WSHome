#!/bin/bash

set -e

echo "🔍 Checking Docker installation..."
if ! command -v docker &> /dev/null; then
  echo "❌ Docker is not installed. Please install Docker and try again."
  exit 1
fi

echo "✅ Docker found."

read -p "🌐 Enter site access method (domain/ip): " SITE_METHOD
read -p "🌐 Enter frontend port (default 80): " FRONTEND_PORT
FRONTEND_PORT=${FRONTEND_PORT:-80}

read -p "🔧 Enter backend port (default 8237): " BACKEND_PORT
BACKEND_PORT=${BACKEND_PORT:-8237}

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

echo "🐘 Starting PostgreSQL container..."
docker run -d \
  --name ws-pg-db \
  --network smart-home-net \
  -e POSTGRES_USER=${USERNAME} \
  -e POSTGRES_PASSWORD=${PASSWORD} \
  -e POSTGRES_DB=smart-home \
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
  --network smart-home-net \
  -e API_URL=http://${SITE_METHOD}:${BACKEND_PORT} \
  -p ${FRONTEND_PORT}:80 \
  ${FRONTEND_IMAGE}

echo "✅ All containers are up and running!"
echo "🌐 Access your frontend via http://${SITE_METHOD}:${FRONTEND_PORT}"
