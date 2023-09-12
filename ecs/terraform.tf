provider "aws" {
  region = "ap-southeast-1"
}

locals {
  application_name = "priya-devsecops4-application"
}

resource "aws_ecs_task_definition" "priya-ecs2-task" {
  family                   = local.application_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn      = "arn:aws:iam::255945442255:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name  = local.application_name
      image = "255945442255.dkr.ecr.ap-southeast-1.amazonaws.com/${local.application_name}:latest"
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
      essential = true
    }
  ])

  cpu    = "512"
  memory = "1024"
}

resource "aws_ecs_cluster" "priya-ecs2-cluster" {
  name = "${local.application_name}-cluster"
}

resource "aws_ecs_service" "priya-ecs2-service" {
  name            = "${local.application_name}-service"
  cluster         = aws_ecs_cluster.priya-ecs2-cluster.id
  task_definition = aws_ecs_task_definition.priya-ecs2-task.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets        = ["subnet-04056e91a09a5b4bf", "subnet-bea677f6", "subnet-29ed7170"]
    assign_public_ip = true
    security_groups = ["sg-b4db57fc"]
  }
  scheduling_strategy = "REPLICA"
  desired_count       = 1
  platform_version    = "LATEST"
  deployment_controller {
    type = "ECS"
  }
  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  enable_ecs_managed_tags = true
}
