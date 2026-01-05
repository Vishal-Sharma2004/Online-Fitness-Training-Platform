<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fitsphere.model.User, com.fitsphere.dao.*, java.util.*, java.text.*" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    WorkoutDAO workoutDAO = new WorkoutDAO();
    ChallengeDAO challengeDAO = new ChallengeDAO();
    UserDAO userDAO = new UserDAO();
    
    // Get user statistics
    List<Object[]> workouts = workoutDAO.getUserWorkouts(user.getUserId());
    List<Object[]> challenges = challengeDAO.getUserChallenges(user.getUserId());
    List<Object[]> statistics = workoutDAO.getWorkoutStatistics(user.getUserId());
    
    int totalWorkouts = workouts.size();
    int totalCalories = 0;
    int totalDuration = 0;
    int activeChallenges = 0;
    
    for (Object[] workout : workouts) {
        totalCalories += ((Integer) workout[5] != null ? (Integer) workout[5] : 0);
        totalDuration += (Integer) workout[3];
    }
    
    for (Object[] challenge : challenges) {
        if ((Boolean) challenge[5]) { // is_active
            activeChallenges++;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - FitSphere</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow">
        <div class="container-fluid">
            <a class="navbar-brand" href="dashboard.jsp">
                <i class="fas fa-dumbbell me-2"></i>FitSphere
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="dashboard.jsp">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="workouts.jsp">
                            <i class="fas fa-running me-1"></i>Workouts
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="challenges.jsp">
                            <i class="fas fa-trophy me-1"></i>Challenges
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="progress.jsp">
                            <i class="fas fa-chart-line me-1"></i>Progress
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="profile.jsp">
                            <i class="fas fa-user me-1"></i>Profile
                        </a>
                    </li>
                </ul>
                <div class="navbar-nav">
                    <div class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" 
                           data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle me-1"></i><%= user.getName() %>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end">
                            <a class="dropdown-item" href="profile.jsp">
                                <i class="fas fa-cog me-2"></i>Settings
                            </a>
                            <% if (user.isAdmin()) { %>
                                <a class="dropdown-item" href="../admin/dashboard.jsp">
                                    <i class="fas fa-shield-alt me-2"></i>Admin Panel
                                </a>
                            <% } %>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item text-danger" href="../logout">
                                <i class="fas fa-sign-out-alt me-2"></i>Logout
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container-fluid mt-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-lg-3 col-md-4 mb-4">
                <div class="card shadow">
                    <div class="card-body text-center">
                        <div class="mb-3">
                            <div class="rounded-circle bg-primary d-flex align-items-center 
                                      justify-content-center mx-auto" 
                                 style="width: 100px; height: 100px;">
                                <i class="fas fa-user text-white" style="font-size: 3rem;"></i>
                            </div>
                        </div>
                        <h5 class="card-title"><%= user.getName() %></h5>
                        <p class="text-muted mb-2"><%= user.getEmail() %></p>
                        <span class="badge bg-<%= user.isAdmin() ? "danger" : "success" %>">
                            <%= user.getRole().toUpperCase() %>
                        </span>
                        
                        <hr>
                        
                        <div class="text-start">
                            <p><strong>Age:</strong> <%= user.getAge() != null ? user.getAge() : "Not set" %></p>
                            <p><strong>Weight:</strong> <%= user.getWeight() != null ? user.getWeight() + " kg" : "Not set" %></p>
                            <p><strong>Height:</strong> <%= user.getHeight() != null ? user.getHeight() + " cm" : "Not set" %></p>
                            <% if (user.getFitnessGoals() != null) { %>
                                <p><strong>Goals:</strong> <%= user.getFitnessGoals() %></p>
                            <% } %>
                        </div>
                        
                        <a href="profile.jsp" class="btn btn-outline-primary btn-sm w-100 mt-3">
                            <i class="fas fa-edit me-1"></i>Edit Profile
                        </a>
                    </div>
                </div>
                
                <!-- Quick Stats -->
                <div class="card shadow mt-3">
                    <div class="card-header bg-light">
                        <h6 class="mb-0"><i class="fas fa-chart-bar me-2"></i>This Week</h6>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Workouts:</span>
                            <strong>3</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Calories:</span>
                            <strong>1,250</strong>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span>Active Days:</span>
                            <strong>5/7</strong>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Dashboard -->
            <div class="col-lg-9 col-md-8">
                <!-- Welcome Message -->
                <div class="card shadow mb-4">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="card-title mb-1">Welcome back, <%= user.getName() %>!</h4>
                                <p class="text-muted mb-0">Track your fitness journey and achieve your goals</p>
                            </div>
                            <a href="workouts.jsp?action=new" class="btn btn-primary">
                                <i class="fas fa-plus me-1"></i>Log Workout
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="row mb-4">
                    <div class="col-md-3 mb-3">
                        <div class="card bg-primary text-white shadow">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-subtitle mb-2">Total Workouts</h6>
                                        <h2 class="card-title mb-0"><%= totalWorkouts %></h2>
                                    </div>
                                    <i class="fas fa-running fa-2x opacity-50"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card bg-success text-white shadow">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-subtitle mb-2">Calories Burned</h6>
                                        <h2 class="card-title mb-0"><%= totalCalories %></h2>
                                    </div>
                                    <i class="fas fa-fire fa-2x opacity-50"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card bg-warning text-white shadow">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-subtitle mb-2">Active Challenges</h6>
                                        <h2 class="card-title mb-0"><%= activeChallenges %></h2>
                                    </div>
                                    <i class="fas fa-trophy fa-2x opacity-50"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card bg-info text-white shadow">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-subtitle mb-2">Total Duration</h6>
                                        <h2 class="card-title mb-0"><%= totalDuration %> min</h2>
                                    </div>
                                    <i class="fas fa-clock fa-2x opacity-50"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts -->
                <div class="row mb-4">
                    <div class="col-md-8 mb-3">
                        <div class="card shadow">
                            <div class="card-header">
                                <h6 class="mb-0"><i class="fas fa-chart-line me-2"></i>Weekly Activity</h6>
                            </div>
                            <div class="card-body">
                                <canvas id="activityChart" height="250"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card shadow">
                            <div class="card-header">
                                <h6 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Workout Types</h6>
                            </div>
                            <div class="card-body">
                                <canvas id="workoutChart" height="250"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Workouts -->
                <div class="card shadow">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h6 class="mb-0"><i class="fas fa-history me-2"></i>Recent Workouts</h6>
                        <a href="workouts.jsp" class="btn btn-sm btn-outline-primary">
                            View All <i class="fas fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                    <div class="card-body">
                        <% if (workouts.isEmpty()) { %>
                            <div class="text-center py-4">
                                <i class="fas fa-running fa-3x text-muted mb-3"></i>
                                <p class="text-muted">No workouts logged yet.</p>
                                <a href="workouts.jsp?action=new" class="btn btn-primary">
                                    <i class="fas fa-plus me-1"></i>Add Your First Workout
                                </a>
                            </div>
                        <% } else { %>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Type</th>
                                            <th>Duration</th>
                                            <th>Intensity</th>
                                            <th>Calories</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% 
                                            int count = 0;
                                            for (Object[] workout : workouts) {
                                                if (count >= 5) break;
                                        %>
                                        <tr>
                                            <td><%= workout[6] %></td>
                                            <td>
                                                <span class="badge bg-primary"><%= workout[2] %></span>
                                            </td>
                                            <td><%= workout[3] %> min</td>
                                            <td>
                                                <% 
                                                    String intensityClass = "bg-secondary";
                                                    if ("high".equals(workout[4])) {
                                                        intensityClass = "bg-danger";
                                                    } else if ("medium".equals(workout[4])) {
                                                        intensityClass = "bg-warning";
                                                    } else if ("low".equals(workout[4])) {
                                                        intensityClass = "bg-success";
                                                    }
                                                %>
                                                <span class="badge <%= intensityClass %>"><%= workout[4] %></span>
                                            </td>
                                            <td>
                                                <span class="badge bg-danger">
                                                    <%= workout[5] != null ? workout[5] : 0 %>
                                                </span>
                                            </td>
                                            <td>
                                                <a href="workouts.jsp?action=edit&id=<%= workout[0] %>" 
                                                   class="btn btn-sm btn-outline-primary">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                            </td>
                                        </tr>
                                        <% 
                                                count++;
                                            } 
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-light mt-5 py-3">
        <div class="container text-center">
            <p class="mb-0 text-muted">
                &copy; 2024 FitSphere. All rights reserved.
            </p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Activity Chart
        const activityCtx = document.getElementById('activityChart').getContext('2d');
        const activityChart = new Chart(activityCtx, {
            type: 'line',
            data: {
                labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                datasets: [{
                    label: 'Workouts',
                    data: [3, 5, 2, 4, 6, 3, 4],
                    borderColor: '#4e73df',
                    backgroundColor: 'rgba(78, 115, 223, 0.1)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });

        // Workout Type Chart
        const workoutCtx = document.getElementById('workoutChart').getContext('2d');
        const workoutChart = new Chart(workoutCtx, {
            type: 'doughnut',
            data: {
                labels: ['Cardio', 'Strength', 'Yoga', 'HIIT', 'Other'],
                datasets: [{
                    data: [30, 25, 20, 15, 10],
                    backgroundColor: [
                        '#4e73df',
                        '#1cc88a',
                        '#36b9cc',
                        '#f6c23e',
                        '#e74a3b'
                    ]
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    </script>
</body>
</html>