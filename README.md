# Smart Home System

🌐 **Demo**: [https://wsdemo.cr-i.tr/](https://wsdemo.cr-i.tr/) – Create an account and explore the live Smart Home Dashboard.

A modular, full-stack Smart Home Automation System designed for expandability, real-time control, and clean architecture. Built using Kotlin (Spring Boot), TypeScript (React), ESP-IDF (C), and PostgreSQL — this system supports seamless IoT integration for modern smart homes.

A modular, full-stack Smart Home Automation System designed for expandability, real-time control, and clean architecture. Built using Kotlin (Spring Boot), TypeScript (React), ESP-IDF (C), and PostgreSQL — this system supports seamless IoT integration for modern smart homes.

## 🚀 Install the System (Quick Setup)

You can launch the entire Smart Home system (PostgreSQL, Backend, Frontend) with a single script.

#### ✅ Prerequisites

- Docker installed on your system

#### 📦 One-Line Installation

Use one of the following commands to run the setup script directly from the repository:

**Using `curl`:**

```bash
bash <(curl -s https://raw.githubusercontent.com/L0rdL0ther/WSHome/refs/heads/main/Setup.sh)
````

**Using `wget`:**

```bash
bash <(wget -qO- https://raw.githubusercontent.com/L0rdL0ther/WSHome/refs/heads/main/Setup.sh)
```

#### 🔧 What it does:

* Prompts you for:

  * Site access method (IP/domain)
  * Custom frontend and backend ports (defaults: 80 and 8237)
* Automatically generates:

  * Secure database credentials
  * JWT secret
* Creates:

  * Docker network `smart-home-net`
  * Containers for PostgreSQL, Backend, and Frontend
* Sets proper environment variables for container communication

Once completed, your frontend will be accessible at:

```
http://<your-domain-or-ip>:<chosen-frontend-port>
```

---

## 🧠 Overview

This project consists of four main components:

1. **Backend** – Spring Boot server with REST/WebSocket APIs
2. **Frontend** – Responsive React interface with modern UI libraries
3. **Device Firmware** – ESP-IDF-based firmware for ESP32 (or any WebSocket-enabled device)
4. **Shared Kotlin Library** – Reusable utilities and abstractions

---

## 📂 Repositories

| Component       | Description                                     | Link                                                             |
| --------------- | ----------------------------------------------- | ---------------------------------------------------------------- |
| Backend         | Kotlin + Spring Boot REST API with PostgreSQL   | [smart\_home](https://github.com/L0rdL0ther/smart_home)          |
| Frontend        | TypeScript + React frontend with modern tooling | [SmartHome](https://github.com/L0rdL0ther/SmartHome)             |
| Device Firmware | ESP-IDF C project for smart devices             | [home\_managment](https://github.com/L0rdL0ther/home_managment)  |
| Kotlin Library  | Custom Kotlin library for backend services      | [wanim-library](https://github.com/WatchAnime-com/wanim-library) |

---

## ⚙️ Backend

* **Language:** Kotlin
* **Framework:** Spring Boot
* **Database:** PostgreSQL
* **Authentication:** JWT
* **Real-Time:** WebSocket support for two-way device communication
* **Features:**

  * User/device authentication & control
  * RESTful & WebSocket APIs
  * Role-based access management

🔗 Repo: [smart\_home](https://github.com/L0rdL0ther/smart_home)

---

## 🌐 Frontend

* **Framework:** React (Vite)
* **Language:** TypeScript
* **Styling:** TailwindCSS
* **Animation:** Framer Motion
* **Design:** Clean, modern, and mobile-ready

🔗 Repo: [SmartHome](https://github.com/L0rdL0ther/SmartHome)

---

## 🔌 Device Integration

* **Primary Platform:** ESP32 using **ESP-IDF** (C)
* **Communication:** WebSocket-based bidirectional messaging
* **Compatibility:**
  This system is **not limited to ESP32**. Any device capable of:

  * Connecting to the internet
  * Communicating via WebSocket
    ...can be integrated into this platform.
* **Functions:**

  * Real-time command reception
  * Device state reporting
  * Custom protocol over WebSocket

🔗 Repo: [home\_managment](https://github.com/L0rdL0ther/home_managment)

---

## 📚 Kotlin Shared Library

* Common utilities, DTOs, and backend abstractions
* Designed for modularity and DRY principles across microservices

🔗 Repo: [wanim-library](https://github.com/WatchAnime-com/wanim-library)

---

## 💬 License

This project is licensed under the MIT License.
