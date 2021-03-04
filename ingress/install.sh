# Create a namespace for your ingress resources
kubectl create namespace ingress-basic

# Add the ingress-nginx repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# Install the nginx ingress controller
helm install ingress ingress-nginx/ingress-nginx \
    --namespace ingress-basic \
    --set controller.replicaCount=1 \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set controller.admissionWebhooks.patch.nodeSelector."beta\.kubernetes\.io/os"=linux

# Install the CustomResourceDefinition resources separately
#kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.11/deploy/manifests/00-crds.yaml

# Create the namespace for cert-manager
#kubectl create namespace cert-manager

# Label the cert-manager namespace to disable resource validation
#kubectl label namespace cert-manager cert-manager.io/disable-validation=true

# Add the Jetstack Helm repository
#helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
#helm repo update

# Install the cert-manager Helm chart
# helm install \
#   --namespace cert-manager \
#   --version v0.11.0 \
#   jetstack/cert-manager \
#   --generate-name
