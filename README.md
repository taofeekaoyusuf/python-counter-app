# PYTHON COUNTER APPLICATION DEPLOYMENT WITH HELM, KUBERNETES, AND ARGOCD.

This is a Python Counter Application which was deployed using Helm Chart and ArgoCD. To run this application, follow the followung steps: <br>

* Ensure to install these tools: <br>
  1. Kubernetes (The Container Orchestrator used in this project). <br>
  2. Helm (Kubernetes Chart Templating Tool). <br>
  3. ArgoCD (A declarative continuous delivery tool for Kubernetes applications). <br>
  4. Docker (Container Tool). <br>
  5. Redis (An in-memory data structure store). <br>
  6. cert-manager (X.509 certificate management for Kubernetes and OpenShift) <br> <br>

* For the code file to execute properly in the CLI environment, ensure to login to ArgoCD CLI as follows: <br>
  
  -- `` argocd login localhost:8080 --username admin --password <ARGOCD_GENERATED_PASSWORD> `` <br>

* The command to generate the ArgoCD password is given as follows: <br>
  -- `` kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo ``
  
* To run the application, execute the following command in the Project directory, thus: <br>
  -- `` chmod +x codeRunnerFile.sh `` <br>
  -- `` ./codeRunnerFile.sh ``

* Ensure to go to: <br>
  -- ``http://localhost:8080`` <br>
  to observe the deployed Application instance.
