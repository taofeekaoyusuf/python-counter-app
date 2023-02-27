#!/bin/bash

echo "\n*****### PYTHON COUNTER APPLICATION PROJECT: Deploying a Web Application ###*****\n"
sleep 5

echo "\n***### Building the Containers (For Python App and Redis) ###***"
docker compose up --build -d
sleep 5
echo *** BUILD OPERATION COMPLETED!!! ***

echo "\n***### Tagging and pushing the Containers to Private DockerHub Repository ###***"
docker tag python-counter-app_app dhackbility/python-counter-app:1.0.0 && docker tag redis:alpine dhackbility/redis:alpine && \
docker push dhackbility/python-counter-app:1.0.0 && docker push dhackbility/redis:alpine
sleep 5
echo *** TAGGING AND PUSHING OPERATION COMPLETED!!! ***

echo "\n***### Exposing ARGOCD Port (Ensure to go to: http://localhost:8080)###***"
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
sleep 10
echo *** ARGODC PORT EXPOSITION OPERATION COMPLETED!!! ***











docker build -t dhackbility/python-counter-app:1.0.0 . && \
docker push dhackbility/python-counter-app:1.0.0 && \
docker tag dhackbility/python-counter-app:1.0.0 python-counter-app