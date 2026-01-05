🏋️‍♂️ FitSphere – Online Fitness Tracking Platform

FitSphere is a modern, role-based online fitness tracking application developed using Java and JavaFX. It helps users log workouts, track progress, and manage fitness activities through a centralized and user-friendly system.

🚀 Project Overview

FitSphere is a comprehensive online fitness tracking web application that allows users to log workouts, track progress, and participate in fitness challenges. Administrators can manage users, fitness content, and system settings.

## ✨ Features

### 👤 User Features
- **Workout Logging**: Log workouts with type, duration, intensity, and calories
- **Progress Tracking**: Visualize fitness progress with charts and statistics
- **Fitness Challenges**: Join and participate in fitness challenges
- **Profile Management**: Update personal information and fitness goals
- **Dashboard**: Overview of fitness statistics and recent activities

### 👑 Admin Features
- **User Management**: Create, update, delete, and manage user accounts
- **Content Management**: Approve or reject fitness content submissions
- **System Settings**: Configure application-wide settings
- **Statistics Dashboard**: View platform analytics and user engagement
- **Activity Monitoring**: Track system changes and user activities

## 🏗️ Technology Stack

### Frontend
- **HTML5** - Markup structure
- **CSS3** - Styling with custom styles and Bootstrap
- **JavaScript** - Client-side functionality
- **Bootstrap 5** - Responsive UI framework
- **Chart.js** - Data visualization for progress tracking
- **Font Awesome** - Icon library

### Backend
- **Java Servlets** - Request handling
- **JSP (JavaServer Pages)** - Dynamic page rendering
- **JSTL** - JSP Standard Tag Library

### Database
- **MySQL 8.0** - Relational database management
- **JDBC** - Database connectivity

### Tools & Libraries
- **Apache Tomcat 9.x** - Application server
- **Maven** - Dependency management (optional)
- **BCrypt** - Password hashing
- **Eclipse/IntelliJ IDEA** - Development IDE

## 📁 Project Structure

```
FitSphere/
├── src/
│   └── com/fitsphere/
│       ├── controller/     # Servlet controllers
│       ├── dao/           # Data Access Objects
│       ├── model/         # Java Beans
│       └── util/          # Utility classes
├── WebContent/
│   ├── WEB-INF/
│   │   ├── lib/           # Library JAR files
│   │   └── web.xml        # Deployment descriptor
│   ├── admin/             # Admin JSP pages
│   ├── user/              # User JSP pages
│   ├── css/               # Stylesheets
│   ├── js/                # JavaScript files
│   └── assets/            # Images and static files
├── database/              # SQL scripts
└── README.md             # This file
```

## 🚀 Installation & Setup

### Prerequisites
- Java JDK 11 or higher
- Apache Tomcat 9.x
- MySQL 8.0
- Eclipse IDE or IntelliJ IDEA
- MySQL Workbench (optional)

### Step 1: Database Setup

1. Install MySQL and start the MySQL service
2. Open MySQL Workbench or command line
3. Create the database:
```sql
CREATE DATABASE fitsphere;
USE fitsphere;
```

4. Run the SQL script from `database/fitsphere_schema.sql`

### Step 2: IDE Configuration

#### For Eclipse:
1. Open Eclipse IDE
2. Create a new **Dynamic Web Project** named "FitSphere"
3. Configure project structure as shown above
4. Set Target Runtime to Apache Tomcat 9.x

#### For IntelliJ IDEA:
1. Open IntelliJ IDEA
2. Create new project → Java Enterprise → Web Application
3. Name the project "FitSphere"
4. Configure Application Server as Tomcat 9.x

### Step 3: Add Required Libraries

Add the following JAR files to `WEB-INF/lib/` folder:

1. **MySQL Connector**: `mysql-connector-java-8.0.33.jar`
2. **BCrypt**: `jbcrypt-0.4.jar`
3. **Servlet API**: `javax.servlet-api-4.0.1.jar`
4. **JSTL**: `jstl-1.2.jar`

### Step 4: Database Configuration

Update database credentials in `src/com/fitsphere/util/DatabaseConnection.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/fitsphere";
private static final String USERNAME = "your_username";
private static final String PASSWORD = "your_password";
```

### Step 5: Deploy and Run

1. Build the project
2. Deploy to Tomcat server
3. Start Tomcat server
4. Access the application at:
   ```
   http://localhost:8080/FitSphere
   ```

## 🔐 Default Credentials

### Admin Account
- **Email**: `admin@fitsphere.com`
- **Password**: `admin123`

### User Account
- **Email**: `john@example.com`
- **Password**: `user123`

## 📊 Database Schema

The application uses the following main tables:

### Users Table
Stores user information including name, email, password, role, and fitness details.

### Workouts Table
Tracks workout sessions with type, duration, intensity, calories burned, and date.

### Challenges Table
Manages fitness challenges with title, description, type, target value, and duration.

### Challenge Participants Table
Tracks user participation in challenges with progress status.

### Fitness Content Table
Stores user-submitted fitness content for admin approval.

### System Settings Table
Manages application configuration settings.

## 🎨 User Interface

### Login Page
- Clean, modern login interface
- Form validation
- Remember me functionality (optional)

### User Dashboard
- Overview of fitness statistics
- Recent workout history
- Active challenges
- Progress charts

### Admin Dashboard
- User management interface
- Content approval system
- System statistics
- Activity logs

## 🛠️ Development

### Adding New Features

1. **Create Model Class**: Add new Java bean in `model/` package
2. **Create DAO Class**: Implement data access logic in `dao/` package
3. **Create Controller**: Add new Servlet in `controller/` package
4. **Create JSP Page**: Design frontend interface in appropriate folder
5. **Update Database**: Add new tables/columns in SQL script

### Code Structure

```java
// Model Example
public class Workout {
    private int workoutId;
    private String workoutType;
    // ... other fields, getters, setters
}

// DAO Example
public class WorkoutDAO {
    public boolean addWorkout(Workout workout) {
        // JDBC code with prepared statements
    }
}

// Controller Example
@WebServlet("/workout/*")
public class WorkoutController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        // Handle form submissions
    }
}
```
---
🎯 Conclusion

FitSphere successfully converts traditional fitness tracking into a structured, digital, and efficient system. It improves workout management, enhances progress visibility, and provides a scalable foundation for future development.

Track Smarter • Train Better • Transform Your Health 🏋️‍♂️💪

---

**FitSphere** - Track Your Fitness, Transform Your Life! 🏃‍♀️💪

---
*Last Updated: December 2024*
*Version: 1.0.0*
