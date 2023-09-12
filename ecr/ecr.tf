provider "aws" {
  region = "ap-southeast-1"
}

locals {
  application_name = "priya-devsecops7-application"
}

# Create Amazon ECR repository
resource "aws_ecr_repository" "priya-repo" {
  name = local.application_name
}
