#!/bin/bash

# Define your teleport clusters list
TELEPORT_CLUSTERS=("cluster1" "cluster2" "cluster3")

# Loop through each cluster
for CLUSTER in "${TELEPORT_CLUSTERS[@]}"; do
  echo "Logging into Teleport Cluster: $CLUSTER"

  # Login to teleport cluster (adjust your tsh login command)
  tsh login --proxy=your-teleport-proxy.example.com --cluster=$CLUSTER
  
  # Set correct Kubernetes context
  tsh kube login --cluster=$CLUSTER --kube-cluster=$CLUSTER-k8s

  CURRENT_CONTEXT=$(kubectl config current-context)
  echo "Using Kubernetes Context: $CURRENT_CONTEXT"

  echo "Scanning namespaces..."

  # Get all namespaces
  NAMESPACES=$(kubectl get ns --no-headers -o custom-columns=":metadata.name")

  for NAMESPACE in $NAMESPACES; do
    echo "Namespace: $NAMESPACE"

    # Find ingresses in the namespace that use nginx ingress class
    INGRESS_LIST=$(kubectl get ingress -n $NAMESPACE --no-headers 2>/dev/null | awk '{print $1}')
    
    for INGRESS in $INGRESS_LIST; do
      INGRESS_CLASS=$(kubectl get ingress "$INGRESS" -n "$NAMESPACE" -o jsonpath='{.spec.ingressClassName}' 2>/dev/null)

      if [[ "$INGRESS_CLASS" == "nginx" ]]; then
        echo "Found NGINX Ingress:"
        echo "  Ingress Name: $INGRESS"
        echo "  Namespace: $NAMESPACE"

        # Get NGINX Ingress Controller version
        VERSION=$(kubectl get deployment -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].spec.template.spec.containers[0].image}' 2>/dev/null)

        if [[ -z "$VERSION" ]]; then
          VERSION="Unknown"
        fi

        echo "  NGINX Version: $VERSION"
        echo "--------------------------------------"
      fi
    done

  done

done
