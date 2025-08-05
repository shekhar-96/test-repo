# EKS Cluster Configuration
cluster_name    = "private-eks-cluster"
cluster_version = "1.31"
region          = "us-west-2"

# VPC Configuration
vpc_cidr             = "10.0.0.0/16"
private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]

# Node Group Configuration
node_group_instance_type = "t3.medium"
node_group_min_size      = 1
node_group_max_size      = 3
node_group_desired_size  = 2

# Tags
tags = {
  Environment = "test"
  Project     = "private-eks"
  Owner       = "devops-team"
}