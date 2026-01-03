

# 🏋️‍♂️ FitSphere – Online Fitness Tracker System

*A role-based digital platform to track workouts, monitor progress, and manage fitness programs efficiently.*

---

## 🚀 Project Overview

Traditional fitness tracking often depends on manual logs, scattered apps, or in-person sessions. **FitSphere** digitizes fitness management by allowing:

* **Users** to track workouts & progress
* **Trainers** to assign workout plans
* **Admins** to manage users and data

This system improves consistency, accountability, and accessibility in fitness tracking.

---

## ❗ Problems in Traditional Fitness Tracking

* Manual workout logs
* No centralized progress tracking
* Poor trainer–trainee communication
* No real-time performance monitoring
* Limited personalization

---

## 💡 FitSphere Digital Solution

✔ Online workout & diet tracking
✔ Trainer-assigned fitness plans
✔ Real-time progress monitoring
✔ Role-based dashboards
✔ Secure centralized data

---

## 🧑‍💻 User Roles & Dashboards

### 🔹 Admin Dashboard

* Manage users & trainers
* View overall platform activity
* System monitoring

### 🔹 Trainer Dashboard

* Create workout plans
* Assign workouts to users
* Monitor user progress

### 🔹 User Dashboard

* Log daily workouts
* View assigned plans
* Track calories, BMI & progress

---

## 🏗 System Architecture

* Role-based authentication
* MVC architecture
* Relational database
* Modular OOP-based design

---

## 🛠 Technology Stack

| Component | Technology     |
| --------- | -------------- |
| Language  | Java           |
| UI        | JavaFX         |
| Database  | SQLite / MySQL |
| Design    | OOP, MVC       |

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

## 🗄 Database Design (SQLite)

### 📌 Tables

```sql
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT UNIQUE,
    password TEXT,
    role TEXT
);

CREATE TABLE workouts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    duration INTEGER,
    calories INTEGER,
    trainer_id INTEGER
);

CREATE TABLE progress (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    workout_id INTEGER,
    date TEXT,
    status TEXT
);
```

---

## 🔑 Sample Login Data

```sql
INSERT INTO users VALUES
(1,'Admin','admin@fit.com','admin123','ADMIN'),
(2,'Trainer','trainer@fit.com','trainer123','TRAINER'),
(3,'User','user@fit.com','user123','USER');
```

---

## 🔌 DB Connection

```java
package utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static final String URL = "jdbc:sqlite:database/fitsphere.db";

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
```

---

## 🔐 Authentication Service

```java
package services;

import models.User;
import utils.DBConnection;
import java.sql.*;

public class AuthService {

    public static User login(String email, String password) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE email=? AND password=?"
            );
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("role")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
```

---

## 📊 Model Example

```java
package models;

public class Workout {
    private int id;
    private String title;
    private int duration;
    private int calories;

    public Workout(int id, String title, int duration, int calories) {
        this.id = id;
        this.title = title;
        this.duration = duration;
        this.calories = calories;
    }
}
```

---

## ▶ How to Run

1. Open project in **IntelliJ / Eclipse**
2. Add **JavaFX SDK**
3. Set `Main.java` as startup
4. Run the project

---

## 🔮 Future Enhancements

* BMI & calorie calculator
* Wearable device integration
* Mobile app (Android)
* Cloud deployment
* AI-based workout recommendations

---






👉 Just tell me **what you want next** (UI / report / full code).
