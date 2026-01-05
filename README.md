
# 🏋️‍♂️ FitSphere – Online Fitness Tracking Platform

FitSphere is a modern, role-based online fitness tracking application developed using **Java and JavaFX**. It helps users log workouts, track progress, and manage fitness activities through a centralized and user-friendly system.

---

## 🚀 Project Overview

FitSphere is a comprehensive online fitness tracking application that allows users to log workouts, track progress, and manage fitness activities. The system supports multiple roles such as **Admin, Trainer, and User**, each with dedicated dashboards. Administrators can manage users and system settings, trainers can manage workout plans, and users can track their fitness journey.

---

## ✨ Features

### 👤 User Features

* Workout logging with type, duration, and intensity
* Progress tracking with historical records
* Personal dashboard for fitness overview
* Profile management
* Secure authentication

### 🧑‍🏫 Trainer Features

* Manage workout plans
* Monitor user performance
* Assign workouts to users

### 👑 Admin Features

* User and trainer management
* System monitoring
* Database management
* Dashboard access for system overview

---

## 🏗️ Technology Stack

### Frontend

* **JavaFX** – UI development
* **FXML** – UI layout design
* **CSS** – Styling and responsiveness

### Backend

* **Java** – Core logic
* **MVC Architecture** – Clean code structure

### Database

* **SQLite** – Lightweight embedded database
* **JDBC** – Database connectivity

### Tools

* **Eclipse / IntelliJ IDEA**
* **Scene Builder**
* **Git & GitHub**

---

## 📁 Project Folder Structure

```
FitSphere/
│
├── src/
│   ├── application/
│   │   └── Main.java
│   │
│   ├── controllers/
│   │   ├── AdminController.java
│   │   ├── TrainerController.java
│   │   └── UserController.java
│   │
│   ├── models/
│   │   ├── User.java
│   │   ├── Workout.java
│   │   └── Progress.java
│   │
│   ├── services/
│   │   ├── AuthService.java
│   │   ├── WorkoutService.java
│   │   └── ProgressService.java
│   │
│   └── utils/
│       └── DBConnection.java
│
├── resources/
│   ├── fxml/
│   │   ├── login.fxml
│   │   ├── admin_dashboard.fxml
│   │   ├── trainer_dashboard.fxml
│   │   └── user_dashboard.fxml
│   │
│   └── styles/
│       └── style.css
│
├── database/
│   └── fitsphere.db
│
└── README.md
```

---

## 🚀 Installation & Setup

### Prerequisites

* Java JDK 11 or higher
* Eclipse or IntelliJ IDEA
* JavaFX SDK
* SQLite Database
* Scene Builder

---

### Step 1: Clone the Repository

```bash
git clone https://github.com/your-username/FitSphere.git
```

---

### Step 2: Configure JavaFX

* Download JavaFX SDK
* Add VM options:

```
--module-path /path/to/javafx/lib --add-modules javafx.controls,javafx.fxml
```

---

### Step 3: Database Setup

* SQLite database file is located in:

```
database/fitsphere.db
```

* Database connection is handled in:

```
utils/DBConnection.java
```

---

### Step 4: Run the Application

* Open `Main.java`
* Run as Java Application

---

## 🔐 Default Credentials

### Admin

* **Username:** admin
* **Password:** admin123

### User

* **Username:** user
* **Password:** user123

---

## 📊 Database Tables

* **User** – Stores user credentials and role
* **Workout** – Stores workout details
* **Progress** – Tracks fitness progress

---

## 🎨 User Interface

### Login Screen

* Secure authentication
* Role-based redirection

### User Dashboard

* Workout history
* Progress tracking

### Trainer Dashboard

* Workout assignment
* User monitoring

### Admin Dashboard

* User management
* System overview

---

## 🛠️ Development Guidelines

### MVC Architecture

* **Model** – Data handling
* **View** – FXML files
* **Controller** – Business logic

### Adding New Features

1. Create model class
2. Add service logic
3. Update controller
4. Design FXML
5. Update database

---

## 🎯 Conclusion

FitSphere successfully converts traditional fitness tracking into a **structured, digital, and efficient system**. It improves workout management, enhances progress visibility, and provides a scalable foundation for future development.

**Track Smarter • Train Better • Transform Your Health** 🏋️‍♂️💪

---

**FitSphere – Track Your Fitness, Transform Your Life!**
