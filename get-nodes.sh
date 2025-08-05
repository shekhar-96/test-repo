#!/bin/bash

# This script uses kubectl to retrieve information about all nodes in the EKS cluster

# Ensure kubectl is configured to use cluster
echo "Fetching EKS nodes..."

kubectl get nodes -o custom-columns="NAME:.metadata.name,INTERNAL-IP:.status.addresses[?(@.type=='InternalIP')].address"
