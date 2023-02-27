# PYTHON COUNTER APPLICATION WITH KLEIN

This is a Python Counter Application which was deployed using Helm Chart and ArgoCD. To run this application, follow the followung steps: <br>

* Ensure to install these tools: <br>
  1. Kubernetes (The Container Orchestrator used in this project). <br>
  2. Helm (Kubernetes Chart Templating Tool). <br>
  3. ArgoCD (A declarative continuous delivery tool for Kubernetes applications). <br>
  4. Docker (Container Tool). <br>
  5. Redis (An in-memory data structure store). <br><br>

* For the code file to execute properly in the CLI environment, ensure to login to ArgoCD CLI as follows: <br>
  -- `` argocd login localhost:8080 --username admin --password <ARGOCD_GENERATED_PASSWORD> ``<br>

* To run the application, execute the following command in the Project directory, thus: <br>
-- `` chmod +x codeRunnerFile.sh `` <br>
-- `` ./codeRunnerFile.sh ``


* Run `` "docker compose up --build -d" ``  to build the containers for the App and Redis.
* Expose Argocd Server and login, thus: <br>
  --- `` kubectl port-forward svc/argocd-server -n argocd 8080:443 & `` <br>
  --- `` argocd login `` <br> and inputting your Argocd Username and Password. <br>
* 
  

