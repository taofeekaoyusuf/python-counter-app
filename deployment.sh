# Create a shortcut alias for "kubectl"
alias k="kubectl"

# Create Application Deployment
k create deployment python-counter-app --image=dhackbility/python-counter-app:v1.0.0

# Expose Deployment using the Service
k expose deployment python-counter-app --name=python-counter-app-service --port=80

# Create Ingress