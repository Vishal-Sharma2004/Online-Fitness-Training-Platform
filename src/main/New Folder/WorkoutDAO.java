package com.fitsphere.dao;

import com.fitsphere.model.Workout;
import com.fitsphere.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WorkoutDAO {
    
    public boolean addWorkout(Workout workout) throws SQLException {
        String sql = "INSERT INTO workouts (user_id, workout_type, duration, intensity, calories_burned, date, notes) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, workout.getUserId());
            stmt.setString(2, workout.getWorkoutType());
            stmt.setInt(3, workout.getDuration());
            stmt.setString(4, workout.getIntensity());
            stmt.setObject(5, workout.getCaloriesBurned(), Types.INTEGER);
            stmt.setDate(6, workout.getDate());
            stmt.setString(7, workout.getNotes());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public List<Workout> getUserWorkouts(int userId) throws SQLException {
        List<Workout> workouts = new ArrayList<>();
        String sql = "SELECT w.*, u.name as user_name FROM workouts w " +
                    "JOIN users u ON w.user_id = u.user_id " +
                    "WHERE w.user_id = ? ORDER BY w.date DESC, w.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                workouts.add(extractWorkoutFromResultSet(rs));
            }
        }
        return workouts;
    }
    
    public Workout getWorkoutById(int workoutId) throws SQLException {
        String sql = "SELECT w.*, u.name as user_name FROM workouts w " +
                    "JOIN users u ON w.user_id = u.user_id " +
                    "WHERE w.workout_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, workoutId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractWorkoutFromResultSet(rs);
            }
        }
        return null;
    }
    
    public boolean updateWorkout(Workout workout) throws SQLException {
        String sql = "UPDATE workouts SET workout_type = ?, duration = ?, intensity = ?, " +
                    "calories_burned = ?, date = ?, notes = ? WHERE workout_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, workout.getWorkoutType());
            stmt.setInt(2, workout.getDuration());
            stmt.setString(3, workout.getIntensity());
            stmt.setObject(4, workout.getCaloriesBurned(), Types.INTEGER);
            stmt.setDate(5, workout.getDate());
            stmt.setString(6, workout.getNotes());
            stmt.setInt(7, workout.getWorkoutId());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean deleteWorkout(int workoutId) throws SQLException {
        String sql = "DELETE FROM workouts WHERE workout_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, workoutId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public List<Workout> getAllWorkouts() throws SQLException {
        List<Workout> workouts = new ArrayList<>();
        String sql = "SELECT w.*, u.name as user_name FROM workouts w " +
                    "JOIN users u ON w.user_id = u.user_id " +
                    "ORDER BY w.date DESC, w.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                workouts.add(extractWorkoutFromResultSet(rs));
            }
        }
        return workouts;
    }
    
    public List<Workout> getWorkoutsByDateRange(int userId, Date startDate, Date endDate) throws SQLException {
        List<Workout> workouts = new ArrayList<>();
        String sql = "SELECT w.*, u.name as user_name FROM workouts w " +
                    "JOIN users u ON w.user_id = u.user_id " +
                    "WHERE w.user_id = ? AND w.date BETWEEN ? AND ? " +
                    "ORDER BY w.date ASC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setDate(2, startDate);
            stmt.setDate(3, endDate);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                workouts.add(extractWorkoutFromResultSet(rs));
            }
        }
        return workouts;
    }
    
    public List<Object[]> getWorkoutStatistics(int userId) throws SQLException {
        List<Object[]> statistics = new ArrayList<>();
        String sql = "SELECT " +
                    "COUNT(*) as total_workouts, " +
                    "SUM(duration) as total_duration, " +
                    "SUM(calories_burned) as total_calories, " +
                    "AVG(duration) as avg_duration, " +
                    "workout_type, " +
                    "intensity " +
                    "FROM workouts " +
                    "WHERE user_id = ? " +
                    "GROUP BY workout_type, intensity";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Object[] stat = new Object[6];
                stat[0] = rs.getInt("total_workouts");
                stat[1] = rs.getInt("total_duration");
                stat[2] = rs.getInt("total_calories");
                stat[3] = rs.getDouble("avg_duration");
                stat[4] = rs.getString("workout_type");
                stat[5] = rs.getString("intensity");
                statistics.add(stat);
            }
        }
        return statistics;
    }
    
    private Workout extractWorkoutFromResultSet(ResultSet rs) throws SQLException {
        Workout workout = new Workout();
        workout.setWorkoutId(rs.getInt("workout_id"));
        workout.setUserId(rs.getInt("user_id"));
        workout.setWorkoutType(rs.getString("workout_type"));
        workout.setDuration(rs.getInt("duration"));
        workout.setIntensity(rs.getString("intensity"));
        workout.setCaloriesBurned(rs.getInt("calories_burned"));
        workout.setDate(rs.getDate("date"));
        workout.setNotes(rs.getString("notes"));
        workout.setCreatedAt(rs.getTimestamp("created_at"));
        workout.setUserName(rs.getString("user_name"));
        return workout;
    }
}