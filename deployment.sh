#!/bin/bash

echo "\n*****### PYTHON COUNTER APPLICATION PROJECT: Deploying a Web Application ###*****\n"
sleep 2

# Create a shortcut alias for "kubectl"
alias k="kubectl"
sleep 2

# Apply/Create a Certificate Issuer
echo "\n***### Apply/Create a Certificate Issuer ###***"
k apply -f ./helm/templates/issuer.yaml
sleep 2

# Apply/Create Application Deployment
echo "\n***### Apply/Create Application Deployment ###***"
k apply -f ./helm/templates/deployment.yaml
# k create deployment python-counter-app --namespace python-counter-app --image=dhackbility/python-counter-app:v1.0.0
sleep 2

# Apply/Expose Deployment using the Service
echo "\n***### Apply/Expose a Deployment ###***"
k apply -f ./helm/templates/service.yaml
# k expose deployment python-counter-app --name=python-counter-app-service --port=80
sleep 2

# Apply/Create Ingress
echo "\n***### Apply/Create an Ingress ###***"
k apply -f ./helm/templates/ingress.yaml
# k create ingress python-counter-app-ingress --class nginx --rule "python-counter-app.local/*=python-counter-app-service:80,tls=python-counter-app-ingress"
sleep 2

# Annotate Ingress Object with the Cert Issuer
echo "\n***### Annotate an Ingress Object with Cert Issuer ###***"
k apply -f ./helm/templates/certgen.yaml
# k annotate ingress python-counter-app-ingress cert-manager.io/cluster-issuer=letsencrypt
sleep 2

# ARGOCD DEPLOYMENT

# Exposing ARGOCD Port
kubectl port-forward svc/argocd-server -n argocd 8085:443

# Logging into ARGOCD in the Linux CLI environment
argocd login localhost:8085

# Creating Application from GitHub Repository on ARGOCD
# k apply -f ./argocd/argocd-test-app.yaml
argocd app create python-counter-app \ 
--repo https://github.com/taofeekaoyusuf/python-counter-app.git \
--path "./helm/templates/" \
--dest-server https://kubernetes.default.svc \
--dest-namespace default # python-counter-app

# Checking the Status of the Application
argocd app get python-counter-app

# Syncing the App on ARGOCD
argocd app sync python-counter-app

# Accessing the Deployed Application using Port-Forwarding operation
kubectl port-forward svc/helm-guestbook 9090:80
