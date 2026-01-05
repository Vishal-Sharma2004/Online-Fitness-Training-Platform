-- Create Database
CREATE DATABASE IF NOT EXISTS fitsphere;
USE fitsphere;

-- Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    age INT,
    weight DECIMAL(5,2),
    height DECIMAL(5,2),
    fitness_goals TEXT,
    profile_image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Workouts Table
CREATE TABLE workouts (
    workout_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    workout_type VARCHAR(50) NOT NULL,
    duration INT NOT NULL COMMENT 'in minutes',
    intensity ENUM('low', 'medium', 'high') NOT NULL,
    calories_burned INT,
    date DATE NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_date (user_id, date)
);

-- Fitness Goals Table
CREATE TABLE fitness_goals (
    goal_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    goal_type VARCHAR(50) NOT NULL,
    target_value DECIMAL(10,2) NOT NULL,
    current_value DECIMAL(10,2) DEFAULT 0,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('active', 'completed', 'failed') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Challenges Table
CREATE TABLE challenges (
    challenge_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    challenge_type VARCHAR(50) NOT NULL,
    target_value INT NOT NULL,
    duration_days INT NOT NULL,
    created_by INT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Challenge Participants Table
CREATE TABLE challenge_participants (
    participant_id INT PRIMARY KEY AUTO_INCREMENT,
    challenge_id INT NOT NULL,
    user_id INT NOT NULL,
    progress INT DEFAULT 0,
    completed BOOLEAN DEFAULT false,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (challenge_id) REFERENCES challenges(challenge_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_participation (challenge_id, user_id),
    INDEX idx_user_challenge (user_id, challenge_id)
);

-- Fitness Content Table (for admin management)
CREATE TABLE fitness_content (
    content_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    content_type ENUM('article', 'video', 'workout_plan') NOT NULL,
    description TEXT,
    content_url VARCHAR(500),
    submitted_by INT,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    reviewed_by INT,
    review_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (submitted_by) REFERENCES users(user_id) ON DELETE SET NULL,
    FOREIGN KEY (reviewed_by) REFERENCES users(user_id) ON DELETE SET NULL
);

-- System Settings Table
CREATE TABLE system_settings (
    setting_id INT PRIMARY KEY AUTO_INCREMENT,
    setting_key VARCHAR(100) UNIQUE NOT NULL,
    setting_value TEXT,
    description TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Activity Log Table
CREATE TABLE activity_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    activity_type VARCHAR(50) NOT NULL,
    description TEXT,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_user_activity (user_id, created_at)
);

-- Insert Default Admin User (password: admin123)
INSERT INTO users (name, email, password, role) 
VALUES ('Admin', 'admin@fitsphere.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBoS8L8KJZS', 'admin');

-- Insert Sample User (password: user123)
INSERT INTO users (name, email, password, age, weight, height, fitness_goals) 
VALUES ('John Doe', 'john@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBoS8L8KJZS', 30, 75.5, 180.0, 'Weight loss, Muscle gain');

-- Insert Sample Challenges
INSERT INTO challenges (title, description, challenge_type, target_value, duration_days, created_by, start_date, end_date) 
VALUES 
('30-Day Fitness Challenge', 'Complete 30 workouts in 30 days', 'workout_count', 30, 30, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 30 DAY)),
('10K Steps Daily', 'Walk 10,000 steps every day for a week', 'step_count', 70000, 7, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY)),
('Burn 5000 Calories', 'Burn 5000 calories through workouts this month', 'calories_burned', 5000, 30, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 30 DAY));

-- Insert Default System Settings
INSERT INTO system_settings (setting_key, setting_value, description) 
VALUES 
('site_name', 'FitSphere', 'Application Name'),
('site_description', 'Online Fitness Tracking Application', 'Site Description'),
('max_login_attempts', '3', 'Maximum allowed login attempts'),
('session_timeout', '30', 'Session timeout in minutes'),
('challenge_creation', 'admin_only', 'Who can create challenges'),
('registration_enabled', 'true', 'Allow new user registration'),
('maintenance_mode', 'false', 'Maintenance mode status');

-- Insert Sample Fitness Content
INSERT INTO fitness_content (title, content_type, description, content_url, submitted_by, status) 
VALUES 
('Beginner Workout Plan', 'workout_plan', 'Perfect for fitness beginners', '/content/workouts/beginner.pdf', 1, 'approved'),
('Nutrition Guide', 'article', 'Healthy eating habits for athletes', '/content/articles/nutrition.html', 1, 'approved'),
('Yoga for Flexibility', 'video', 'Improve flexibility with yoga', 'https://youtube.com/watch?v=xyz', 2, 'pending');