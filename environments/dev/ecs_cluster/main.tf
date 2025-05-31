# Create ECS Cluster
resource "aws_ecs_cluster" "student_management_ecs_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_cloudwatch_log_group" "frontend_log_group" {
  name = var.frontend_log_group_name
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "frontend_task_definition" {
  family                   = "frontend-task-definition"
  execution_role_arn       = data.terraform_remote_state.iam.outputs.task_execution_role_arn
  task_role_arn            = data.terraform_remote_state.iam.outputs.task_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "512"
  memory                = "1024"
  container_definitions = <<DEFINITION
  [
    {
      "name": "${var.frontend_container_name}",
      "image": "${var.frontend_ecr_image_url}",
      "environment": [
        {
          "name": "REACT_APP_API_URL",
          "value": "${data.terraform_remote_state.load_balancer.outputs.alb_dns_backend}" 
        }
      ],
      "cpu": 512,
      "memory": 1024,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80,
          "protocol": "tcp",
          "appProtocol": "http"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.frontend_log_group.name}",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "${var.frontend_container_name}"
        }
      }
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "frontend_service" {
  name            = var.frontend_container_name
  network_configuration {
    subnets = data.terraform_remote_state.networking.outputs.private_subnets
    security_groups = data.terraform_remote_state.security.outputs.private_sg_id
    assign_public_ip = true
  }
  cluster         = aws_ecs_cluster.student_management_ecs_cluster.id
  task_definition = aws_ecs_task_definition.frontend_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = data.terraform_remote_state.load_balancer.outputs.frontend_target_group_arn
    container_name   = var.frontend_container_name
    container_port   = 80
  }
}

# Backend
resource "aws_cloudwatch_log_group" "backend_log_group" {
  name = var.backend_log_group_name
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "backend_task_definition" {
  family                   = "backend-task-definition"
  execution_role_arn       = data.terraform_remote_state.iam.outputs.task_execution_role_arn
  task_role_arn            = data.terraform_remote_state.iam.outputs.task_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "512"
  memory                = "1024"
  container_definitions = <<DEFINITION
  [
    {
      "name": "${var.backend_container_name}",
      "image": "${var.backend_ecr_image_url}",
      "cpu": 512,
      "memory": 1024,
      "secrets": [
        {
          "name": "MONGO_URL",
          "valueFrom": "${data.terraform_remote_state.database.outputs.mongodb_connection_string_arn}"
        }
      ],
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080,
          "protocol": "tcp",
          "appProtocol": "http"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.backend_log_group.name}",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "${var.backend_container_name}"
        }
      }
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "backend_service" {
  name = var.backend_container_name
  network_configuration {
    subnets          = data.terraform_remote_state.networking.outputs.private_subnets
    security_groups  = data.terraform_remote_state.security.outputs.private_sg_id
    assign_public_ip = true
  }
  cluster         = aws_ecs_cluster.student_management_ecs_cluster.id
  task_definition = aws_ecs_task_definition.backend_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = data.terraform_remote_state.load_balancer.outputs.backend_target_group_arn
    container_name   = var.backend_container_name
    container_port   = 8080
  }
}

