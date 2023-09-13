# Building and Deploying a Docker Application with Terraform and Amazon ECS

This guide provides step-by-step instructions on building a Docker application, pushing it to Amazon Elastic Container Registry (ECR), deploying it to Amazon Elastic Container Service (ECS) using Terraform, and handling common errors.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Docker Image Creation and Push](#docker-image-creation-and-push)
- [ECS Deployment Using Terraform](#ecs-deployment-using-terraform)
- [Resource Destruction](#resource-destruction)
- [Handling ECR Image Deletion Error](#handling-ecr-image-deletion-error)
- [Conclusion](#conclusion)

## Prerequisites

Before you begin, ensure you have:

- An AWS account with the necessary permissions.
- Docker installed on your local machine. You can download Docker from [Docker's official website](https://www.docker.com/get-started).
- Terraform installed on your local machine. You can download Terraform from [Terraform's official website](https://www.terraform.io/downloads.html).

## Docker Image Creation and Push

1. **Set Up the Docker Image:**

   - Create a directory for your Docker project and navigate to it in your terminal:

     ```sh
     mkdir staret-foods
     cd staret-foods
     ```

   - Inside this directory, create a `Dockerfile` with the content in the [example Dockerfile](./Dockerfile).

   - Build the Docker image locally:

     ```sh
     docker build -t staret-foods .
     ```

2. **Push Docker Image to Amazon ECR:**

   - Log in to Amazon ECR using the AWS CLI:

     ```sh
     aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 255945442255.dkr.ecr.ap-southeast-1.amazonaws.com
     ```

   - Tag the Docker image with your ECR repository URI:

     ```sh
     docker tag staret-foods:latest 255945442255.dkr.ecr.ap-southeast-1.amazonaws.com/priya-repo:latest
     ```

   - Push the tagged Docker image to Amazon ECR:

     ```sh
     docker push 255945442255.dkr.ecr.ap-southeast-1.amazonaws.com/priya-repo:latest
     ```

## ECS Deployment Using Terraform

1. **Set Up the Terraform Configuration:**

   - Create a `terraform.tf` file in your project directory and add the Terraform configuration from the [example Terraform configuration](./terraform.tf).

2. **Deploy ECS Service:**

   - Run the following Terraform commands to deploy the ECS service:

     ```sh
     terraform init
     terraform apply
     ```
https://ap-southeast-1.console.aws.amazon.com/ecr/repositories/private/255945442255/priya-devsecops8-application?region=ap-southeast-1
https://ap-southeast-1.console.aws.amazon.com/ecs/v2/clusters/priya-devsecops8-application-cluster/services/priya-devsecops8-application-service/health?region=ap-southeast-1
https://ap-southeast-1.console.aws.amazon.com/ecs/v2/clusters/priya-devsecops8-application-cluster/tasks/8db87130d4e446c4923b82dc156d0952/configuration?region=ap-southeast-1&selectedContainer=priya-devsecops8-application


## Resource Destruction

1. **Destroy Resources:**

   - If you no longer need the resources, navigate to the project directory and run:

     ```sh
     terraform destroy
     ```

## Handling ECR Image Deletion Error

1. **If You Encounter Deletion Error:**

   - If you encounter an error when trying to delete an ECR image with a specific tag, such as `latest`, you can use the following AWS CLI command to forcefully delete it:

     ```sh
     aws ecr batch-delete-image --repository-name priya-repo --image-ids imageTag=latest
     ```

## Conclusion

By following this guide, you've learned how to build a Docker image, push it to Amazon ECR, deploy an ECS service using Terraform, and manage resources effectively. This approach provides a streamlined way to manage your containerized applications on AWS.

Remember to replace placeholder values with your actual configuration details and paths. For more advanced scenarios, you can extend this configuration further.
