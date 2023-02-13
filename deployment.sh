#!/bin/bash

echo "\n*****### PYTHON COUNTER APPLICATION PROJECT: Deploying a Web Application ###*****\n"
sleep 2

# Create a shortcut alias for "kubectl"
alias k="kubectl"
sleep 2

# Apply/Create a Certificate Issuer
echo "\n***### Apply/Create a Certificate Issuer ###***"
k apply -f issuer.yaml
sleep 2

# Apply/Create Application Deployment
echo "\n***### Apply/Create Application Deployment ###***"
k apply -f deployment.yaml
# k create deployment python-counter-app --image=dhackbility/python-counter-app:v1.0.0
sleep 2

# Apply/Expose Deployment using the Service
echo "\n***### Apply/Expose a Deployment ###***"
k apply -f service.yaml
# k expose deployment python-counter-app --name=python-counter-app-service --port=80
sleep 2

# Apply/Create Ingress
echo "\n***### Apply/Create an Ingress ###***"
k apply -f ingress.yaml
# k create ingress python-counter-app-ingress --class nginx --rule "python-counter-app.local/*=python-counter-app-service:80,tls=python-counter-app-ingress"
sleep 2

# Annotate Ingress Object with the Cert Issuer
k apply -f certgen.yaml
# k annotate ingress python-counter-app-ingress cert-manager.io/cluster-issuer=letsencrypt
sleep 2

