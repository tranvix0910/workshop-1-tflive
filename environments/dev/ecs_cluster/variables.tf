variable "region" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "frontend_log_group_name" {
  type = string
}

variable "backend_log_group_name" {
  type = string
}

variable "frontend_container_name" {
  type = string
}

variable "backend_container_name" {
  type = string
}

variable "frontend_ecr_image_url" {
  type = string
}

variable "backend_ecr_image_url" {
  type = string
}

