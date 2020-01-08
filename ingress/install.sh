# Create the namespace for the ingress controller
kubectl create namespace ingress

# Add the repository to helm
helm repo add stable https://kubernetes-charts.storage.googleapis.com/

# Install the nginx ingress controller
helm install stable/nginx-ingress \
    --namespace ingress \
    --set controller.replicaCount=1 \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set controller.service.loadBalancerIP="YOUR CLUSTER IPADDRESS" \
    --generate-name

# Install the CustomResourceDefinition resources separately
kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.11/deploy/manifests/00-crds.yaml

# Create the namespace for cert-manager
kubectl create namespace cert-manager

# Label the cert-manager namespace to disable resource validation
kubectl label namespace cert-manager cert-manager.io/disable-validation=true

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

# Install the cert-manager Helm chart
helm install \
  --namespace cert-manager \
  --version v0.11.0 \
  jetstack/cert-manager \
  --generate-name
