# Smart Home System

A modular, full-stack Smart Home Automation System designed for ease of use, expandability, and real-time control. Built with Kotlin (Spring Boot), TypeScript (React), ESP32 (Arduino), and PostgreSQL, this system enables seamless integration of IoT devices into a modern smart home ecosystem.

## 🧠 Overview

This project consists of four main components:

1. **Backend** – Spring Boot server for business logic and API
2. **Frontend** – Modern React UI with Tailwind, Framer Motion, Vite
3. **ESP32 Integration** – Arduino-based control and communication with smart devices
4. **Custom Kotlin Library** – Shared utilities for reusability and clean architecture

---

## 📂 Repositories

| Component       | Description                                       | Link                                                                 |
|----------------|---------------------------------------------------|----------------------------------------------------------------------|
| Backend         | Kotlin + Spring Boot REST API with PostgreSQL    | [smart_home](https://github.com/L0rdL0ther/smart_home)               |
| Frontend        | TypeScript + React frontend with modern tooling  | [SmartHome](https://github.com/L0rdL0ther/SmartHome)                 |
| ESP32 Firmware  | Arduino/C++ code for ESP32 IoT device logic      | [home_managment](https://github.com/L0rdL0ther/home_managment)       |
| Kotlin Library  | Custom Kotlin library shared across projects     | [wanim-library](https://github.com/WatchAnime-com/wanim-library)     |

---

## ⚙️ Backend

- **Language:** Kotlin
- **Framework:** Spring Boot
- **Database:** PostgreSQL
- **Security:** JWT-based authentication
- **Features:**
  - Device registration & management
  - User roles & permissions
  - Real-time device state control via REST APIs
  - Integration with ESP32 microcontrollers

🔗 Repo: [smart_home](https://github.com/L0rdL0ther/smart_home)

---

## 🌐 Frontend

- **Framework:** React (Vite)
- **Language:** TypeScript
- **Styling:** TailwindCSS
- **Animations:** Framer Motion
- **Design:** Lucid, responsive, and mobile-friendly

🔗 Repo: [SmartHome](https://github.com/L0rdL0ther/SmartHome)

---

## 📡 ESP32 Firmware

- **Board:** ESP32
- **Language:** Arduino (C++)
- **Functions:**
  - Connects to backend via WiFi
  - Sends and receives JSON data
  - Controls physical devices (e.g. lights, sensors)

🔗 Repo: [home_managment](https://github.com/L0rdL0ther/home_managment)

---

## 📚 Kotlin Library

- Reusable utilities for DTOs, HTTP handling, and more
- Shared across multiple Kotlin-based services
- Built to keep backend code clean and DRY

🔗 Repo: [wanim-library](https://github.com/WatchAnime-com/wanim-library)

---

## 🚀 Getting Started

### Prerequisites

- Java 17+
- Node.js (LTS)
- PostgreSQL
- Arduino IDE (for ESP32)
- Docker (optional)

### Run Locally

#### Backend

```bash
cd smart_home
./gradlew bootRun
