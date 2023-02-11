docker build -t dhackbility/python-counter-app:v1.0.0 .
docker run -dp 8080:80 6379:6379 -n python-counter-app dhackbility/python-counter-app:v1.0.0

# Installing ARGOCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Port forwarding to connect to the Argocd API server
kubectl port-forward svc/argocd-server -n argocd 8089:443

# Login to the Argocd UI API server
Username: admin
Password: 

## COMAND TO GET MY ARGOCD UI PASSWORD:
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

# Creates cert-manager and intalls CRD and set nameservers to 8.8.8.8:53\,1.1.1.1:53 for DNS01 validation
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set installCRDs=true \
  --set 'extraArgs={--dns01-recursive-nameservers-only,--dns01-recursive-nameservers=8.8.8.8:53\,1.1.1.1:53}'

# Installing Kong Ingress Controller
helm upgrade -i my-kong kong/kong -n kong \
--set image.tag=2.8 \
--set admin.enabled=true \
--set admin.http.enabled=true \
--set ingressController.installCRDs=false \
--create-namespace


# ALTERNATIVE INSTALLATION OF CERT_MANAGER
# Add the Jetstack Helm Repository
helm repo add jetstack https://charts.jetstack.io

#Update Local Helm Chart Repository
helm repo update

# Installing CRDs with Kubectl
kubectl apply -f https://github.com/cert-manager/cert-manager/release//download/v1.7.1/cert-manager.yaml



# OTHER WAYS TO SECURE THE SECRETS
# Generate the Private Key
openssl genra -des3 -out secretkeys.key 2048

# Generate CSR (Certificate to Sign)
openssl req -key secretkeys.key -new -out secretkeys.csr

# Generate Self signed certificate
openssl x509 -signkey secretkeys.key -in -secretkeys.csr -req -days 365 -out secretkeys.crt

# Certificate Authority (CA)
openssl req -x509 -sha256 -days 1825 -newkey rsa:2048 -keyout rootCA.key -out rootCA.crt

# Sign the CSR with Root CA
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
subjectAltName = @alt_names

# Generating Secret Manifest
kubectl create secret tls my-tls-secret --key="secretkeys.key" --cert="secretkeys.crt"
