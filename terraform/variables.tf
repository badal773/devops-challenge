
# AWS region to deploy resources
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

# VPC CIDR block
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# (Optional) Docker image for the app, for reference in Kubernetes manifests
variable "app_image" {
  description = "Docker image for the app (used in Kubernetes deployment YAML, not Terraform)"
  type        = string
  default     = "<your-dockerhub-username>/simpletimeservice:latest"
}
