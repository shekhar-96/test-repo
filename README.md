# EKS cluster using Terraform 

## Files Structure
- `main.tf` - Main Terraform configuration
- `variables.tf` - Variable define
- `terraform.tfvars` - input variables
- `outputs.tf` - Output values
- `README.md` - This documentation

## Architecture

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

- terraform init

- terraform plan

- terraform apply

### 4. Step-by-step explanation

### 4.1 VPC and Networking creation
- Created a custom VPC with `10.0.0.0/16` to isolate EKS resources.
- Attached an Internet Gateway for internet access to public subnets.
- Used two Availability Zones for high availability.

### 4.2 Subnet Configuration
- Created two public subnets with internet access for NAT Gateways.
- Created two private subnets for EKS cluster and nodes with no direct internet access.
- Tagged private subnets for EKS integration.

### 4.3 NAT Gateway Setup
- Allocated Elastic IPs for each NAT Gateway.
- Deployed NAT Gateways in public subnets to enable private subnet internet access.
- Allowed worker nodes to get the internet access

### 4.4 Route Table Configuration
- Public route table routes traffic to the internet via IGW.
- Private route tables use NAT Gateways for outbound internet access.
- Ensured redundancy by using separate route tables per subnet.

### 4.5 IAM Roles and Policies
- EKS Cluster Role created with `AmazonEKSClusterPolicy`.
- Node Group Role created with required policies for EC2 and EKS networking.

### 4.6 Security Groups
- Created security groups for cluster and node groups.
- Allowed communication between control plane, worker nodes, and internally.

### 4.7 EKS Cluster Creation
- EKS control plane created in private subnets with no public access.
- Kubernetes version is 1.31 and spans across AZs for HA.

### 4.8 EKS Node Group Deployment
- Node group uses `t3.medium` instances with auto scaling (1–3 nodes).
- Nodes spread across private subnets in different AZs for reliability.


### 5. Update Kubeconfig to access cluster 

aws eks update-kubeconfig --region us-west-2 --name private-eks-cluster

#### Note: Cluster will be accisible only with the private network, using vpn or jumphost


## Shell Script – get-nodes

- get-nodes.sh

This script retrieves the EKS nodes with private IP addresses

#### Note: To run this script, you need access to the EKS cluster for authentication. 
#### You can either use a jump host server located within the same VPC, or connect to the cluster from your local machine using a VPN.

## Region and Terraform version used

AWS Region
- **Region**: `us-west-2` (Oregon)
- The EKS cluster and all associated resources are deployed in this region.

Terraform Version
- **Terraform Version**: `1.5.6`
- To run the Terraform configurations.