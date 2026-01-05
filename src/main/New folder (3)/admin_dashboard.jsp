<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fitsphere.model.User, com.fitsphere.dao.*, java.util.*" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.isAdmin()) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    UserDAO userDAO = new UserDAO();
    WorkoutDAO workoutDAO = new WorkoutDAO();
    ChallengeDAO challengeDAO = new ChallengeDAO();
    
    List<User> allUsers = userDAO.getAllUsers();
    List<Object[]> allWorkouts = workoutDAO.getAllWorkouts();
    List<Object[]> allChallenges = challengeDAO.getAllChallenges();
    
    int totalUsers = allUsers.size();
    int totalWorkouts = allWorkouts.size();
    int totalChallenges = allChallenges.size();
    int pendingContent = 0; // Would come from ContentDAO
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - FitSphere</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-dark bg-dark shadow">
        <div class="container-fluid">
            <a class="navbar-brand" href="dashboard.jsp">
                <i class="fas fa-dumbbell me-2"></i>FitSphere Admin
            </a>
            <div class="d-flex">
                <a href="../user/dashboard.jsp" class="btn btn-outline-light btn-sm me-2">
                    <i class="fas fa-user me-1"></i>User View
                </a>
                <a href="../logout" class="btn btn-outline-danger btn-sm">
                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="dashboard.jsp">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="users.jsp">
                                <i class="fas fa-users me-2"></i>User Management
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="content.jsp">
                                <i class="fas fa-file-alt me-2"></i>Content Management
                                <% if (pendingContent > 0) { %>
                                    <span class="badge bg-danger float-end"><%= pendingContent %></span>
                                <% } %>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="challenges-admin.jsp">
                                <i class="fas fa-trophy me-2"></i>Challenges
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="settings.jsp">
                                <i class="fas fa-cog me-2"></i>System Settings
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="statistics.jsp">
                                <i class="fas fa-chart-bar me-2"></i>Statistics
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="activity.jsp">
                                <i class="fas fa-history me-2"></i>Activity Log
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                <!-- Welcome Card -->
                <div class="card shadow mb-4">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="card-title mb-1">
                                    <i class="fas fa-shield-alt me-2"></i>Admin Dashboard
                                </h4>
                                <p class="text-muted mb-0">Welcome, <%= user.getName() %>! Manage your fitness platform.</p>
                            </div>
                            <div class="text-end">
                                <small class="text-muted">Last login: Today</small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Total Users</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalUsers %></div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-users fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-success shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                            Total Workouts</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalWorkouts %></div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-running fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-info shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                            Active Challenges</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalChallenges %></div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-trophy fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-warning shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                            Pending Content</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= pendingContent %></div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-file-alt fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts Row -->
                <div class="row mb-4">
                    <div class="col-xl-8 col-lg-7">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">
                                    <i class="fas fa-chart-line me-2"></i>User Growth
                                </h6>
                            </div>
                            <div class="card-body">
                                <canvas id="userGrowthChart" height="320"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-4 col-lg-5">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">
                                    <i class="fas fa-chart-pie me-2"></i>User Roles
                                </h6>
                            </div>
                            <div class="card-body">
                                <canvas id="roleDistributionChart" height="320"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity -->
                <div class="row">
                    <div class="col-lg-6 mb-4">
                        <div class="card shadow">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">
                                    <i class="fas fa-history me-2"></i>Recent Users
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-sm">
                                        <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Email</th>
                                                <th>Role</th>
                                                <th>Joined</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% 
                                                int userCount = 0;
                                                for (User u : allUsers) {
                                                    if (userCount >= 5) break;
                                            %>
                                            <tr>
                                                <td><%= u.getName() %></td>
                                                <td><%= u.getEmail() %></td>
                                                <td>
                                                    <span class="badge bg-<%= u.isAdmin() ? "danger" : "success" %>">
                                                        <%= u.getRole() %>
                                                    </span>
                                                </td>
                                                <td><%= u.getCreatedAt() %></td>
                                            </tr>
                                            <% 
                                                    userCount++;
                                                } 
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                                <a href="users.jsp" class="btn btn-sm btn-outline-primary w-100">
                                    View All Users <i class="fas fa-arrow-right ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 mb-4">
                        <div class="card shadow">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">
                                    <i class="fas fa-running me-2"></i>Recent Workouts
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-sm">
                                        <thead>
                                            <tr>
                                                <th>User</th>
                                                <th>Type</th>
                                                <th>Duration</th>
                                                <th>Calories</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% 
                                                int workoutCount = 0;
                                                for (Object[] workout : allWorkouts) {
                                                    if (workoutCount >= 5) break;
                                            %>
                                            <tr>
                                                <td><%= workout[8] %></td>
                                                <td><span class="badge bg-primary"><%= workout[2] %></span></td>
                                                <td><%= workout[3] %> min</td>
                                                <td><%= workout[5] != null ? workout[5] : 0 %></td>
                                                <td><%= workout[6] %></td>
                                            </tr>
                                            <% 
                                                    workoutCount++;
                                                } 
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                                <a href="workouts-admin.jsp" class="btn btn-sm btn-outline-primary w-100">
                                    View All Workouts <i class="fas fa-arrow-right ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // User Growth Chart
        const growthCtx = document.getElementById('userGrowthChart').getContext('2d');
        const growthChart = new Chart(growthCtx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
                datasets: [{
                    label: 'Users',
                    data: [10, 25, 35, 50, 65, 80, <%= totalUsers %>],
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
                        beginAtZero: true
                    }
                }
            }
        });

        // Role Distribution Chart
        const roleCtx = document.getElementById('roleDistributionChart').getContext('2d');
        const roleChart = new Chart(roleCtx, {
            type: 'doughnut',
            data: {
                labels: ['Admins', 'Users'],
                datasets: [{
                    data: [1, <%= totalUsers - 1 %>],
                    backgroundColor: ['#e74a3b', '#1cc88a']
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