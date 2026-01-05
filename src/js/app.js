// FitSphere Application JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Initialize Bootstrap components
    initBootstrapComponents();
    
    // Initialize charts if needed
    if (document.querySelector('.chart-container')) {
        initCharts();
    }
    
    // Initialize form validations
    initFormValidations();
    
    // Initialize workout calculator
    initWorkoutCalculator();
});

function initBootstrapComponents() {
    // Initialize tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
    
    // Initialize popovers
    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl);
    });
    
    // Auto-dismiss alerts
    setTimeout(function() {
        var alerts = document.querySelectorAll('.alert:not(.alert-permanent)');
        alerts.forEach(function(alert) {
            var bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
}

function initCharts() {
    // Activity Chart
    if (document.getElementById('activityChart')) {
        const activityCtx = document.getElementById('activityChart').getContext('2d');
        new Chart(activityCtx, {
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
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        });
    }
    
    // Workout Type Chart
    if (document.getElementById('workoutChart')) {
        const workoutCtx = document.getElementById('workoutChart').getContext('2d');
        new Chart(workoutCtx, {
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
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    }
}

function initFormValidations() {
    // Form validation
    var forms = document.querySelectorAll('.needs-validation');
    Array.prototype.slice.call(forms).forEach(function(form) {
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
    
    // Password strength checker
    var passwordInput = document.getElementById('password');
    if (passwordInput) {
        passwordInput.addEventListener('input', checkPasswordStrength);
    }
}

function initWorkoutCalculator() {
    // Calculate calories based on workout inputs
    var workoutType = document.getElementById('workout_type');
    var duration = document.getElementById('duration');
    var intensity = document.getElementById('intensity');
    var calories = document.getElementById('calories');
    
    if (workoutType && duration && intensity && calories) {
        var calculateCalories = function() {
            if (workoutType.value && duration.value && intensity.value) {
                var baseRates = {
                    'running': 10,
                    'cycling': 8,
                    'swimming': 7,
                    'weightlifting': 6,
                    'yoga': 3,
                    'pilates': 4,
                    'hiit': 12
                };
                
                var intensityMultipliers = {
                    'low': 0.7,
                    'medium': 1,
                    'high': 1.3
                };
                
                var baseRate = baseRates[workoutType.value] || 5;
                var multiplier = intensityMultipliers[intensity.value] || 1;
                var calculated = Math.round(baseRate * duration.value * multiplier);
                
                calories.value = calculated;
            }
        };
        
        workoutType.addEventListener('change', calculateCalories);
        duration.addEventListener('input', calculateCalories);
        intensity.addEventListener('change', calculateCalories);
    }
}

function checkPasswordStrength() {
    var password = this.value;
    var strength = 0;
    var feedback = '';
    
    if (password.length >= 8) strength++;
    if (password.match(/[a-z]/)) strength++;
    if (password.match(/[A-Z]/)) strength++;
    if (password.match(/[0-9]/)) strength++;
    if (password.match(/[^a-zA-Z0-9]/)) strength++;
    
    var strengthText = ['Very Weak', 'Weak', 'Fair', 'Good', 'Strong', 'Very Strong'][strength];
    var strengthClass = ['danger', 'danger', 'warning', 'info', 'success', 'success'][strength];
    
    // Update UI with strength indicator
    var indicator = document.getElementById('password-strength');
    if (indicator) {
        indicator.textContent = 'Strength: ' + strengthText;
        indicator.className = 'badge bg-' + strengthClass;
    }
}

// API Utility Functions
const FitSphereAPI = {
    async request(endpoint, method = 'GET', data = null) {
        const options = {
            method: method,
            headers: {
                'Content-Type': 'application/json'
            }
        };
        
        if (data && (method === 'POST' || method === 'PUT')) {
            options.body = JSON.stringify(data);
        }
        
        try {
            const response = await fetch(endpoint, options);
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return await response.json();
        } catch (error) {
            console.error('API request failed:', error);
            showNotification('An error occurred. Please try again.', 'danger');
            throw error;
        }
    }
};

// Notification System
function showNotification(message, type = 'success') {
    // Remove existing notifications
    var existing = document.querySelector('.notification-container');
    if (existing) {
        existing.remove();
    }
    
    // Create notification container
    var container = document.createElement('div');
    container.className = 'notification-container position-fixed top-0 end-0 p-3';
    container.style.zIndex = '9999';
    
    // Create notification
    var notification = document.createElement('div');
    notification.className = `toast show bg-${type} text-white`;
    notification.innerHTML = `
        <div class="toast-header bg-${type} text-white">
            <strong class="me-auto">FitSphere</strong>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
            ${message}
        </div>
    `;
    
    container.appendChild(notification);
    document.body.appendChild(container);
    
    // Auto remove after 5 seconds
    setTimeout(function() {
        if (container.parentNode) {
            container.remove();
        }
    }, 5000);
}

// Date formatting utility
function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric'
    });
}

// Export utilities to global scope
window.FitSphere = {
    API: FitSphereAPI,
    showNotification: showNotification,
    formatDate: formatDate
};