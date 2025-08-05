# EKS cluster using Terraform 

## Files Structure
- `main.tf` - Main Terraform configuration
- `variables.tf` - Variable define
- `terraform.tfvars` - input variables
- `outputs.tf` - Output values
- `README.md` - This documentation

## 🏗️ Architecture

The infrastructure creates:

- Custom VPC 
- 2 private subnets in different AZs (10.0.1.0/24, 10.0.2.0/24)
- 2 public subnets for NAT Gateways only
- NAT Gateways per AZ for outbound internet access from private subnets
- Internet Gateway For public subnet internet access

- Security Groups: configured for cluster and node communication
- IAM Roles: Least privilege access for cluster and worker nodes


## Infra Creation

### Prerequisites

- AWS CLI
- Terraform installed (v1.5.6)
- kubectl installed
- Access to AWS account

### 1. Clone the repo

git clone <repository-url>

### 2. Configure AWS Credentials

aws configure

### 3. Initialize and Apply Terraform

terraform init
terraform plan
terraform apply


### 4. Update Kubeconfig to access cluster 

aws eks update-kubeconfig --region us-west-2 --name private-eks-cluster

#### Note: Cluster will be accisible only with the private network, using vpn or jumphost


## Shell Script – get-nodes

- get-nodes.sh

This script retrieves the EKS nodes with private IP addresses

Note: To run this script, you need access to the EKS cluster. You can either use a jump host server located within the same VPC, or connect to the cluster from your local machine using a VPN.