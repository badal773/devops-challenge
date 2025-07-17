# EKS cluster name
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "simpletimeservice-eks"
}

# EKS cluster version
variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.32"
}

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

