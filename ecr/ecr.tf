provider "aws" {
  region = "ap-southeast-1"
}

locals {
  application_name = "priya-devsecops4-application"
}

# Create Amazon ECR repository
resource "aws_ecr_repository" "priya-repo" {
  name = local.application_name
}
