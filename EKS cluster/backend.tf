# when we are using S3 as the backend for storing Terraform state file


# terraform {
#   backend "s3" {
#     bucket         = "my-eks-tfstate-bucket"     
#     key            = "eks-cluster/terraform.tfstate"
#     region         = "us-west-2"
#     dynamodb_table = "terraform-locks"
#   }
# }