# Terraform and AWS provider setup
# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "< 6.0.0"

    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.aws_region
}

# VPC with 2 public and 2 private subnets
# Official docs: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
  name = "simpletimeservice-vpc"
  cidr = var.vpc_cidr

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Name = "simpletimeservice-vpc"
  }
}

# Minimal EKS cluster in private subnets
# Official docs: https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.2"
  
  cluster_name    = "simpletimeservice-eks"
  cluster_version = "1.32"
  
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  
  enable_cluster_creator_admin_permissions = true

  # Managed node group for EKS
  # Docs: https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest/submodules/eks-managed-node-group
  eks_managed_node_groups = {
    sts-pool = {
      desired_size   = 1
      max_size       = 1
      min_size       = 1
      instance_types = ["t3.small"]
      subnet_ids     = module.vpc.private_subnets
    }
  }
}

# Output cluster name for kubectl usage
output "cluster_name" {
  value       = module.eks.cluster_name
  description = "EKS cluster name for kubectl configuration"
}

# ALB Ingress Controller IAM policy (for Kubernetes ALB ingress)
# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "alb_ingress" {
  statement {
    actions   = ["ec2:Describe*", "ec2:Get*", "ec2:List*", "elasticloadbalancing:*", "iam:ListRoles", "iam:ListInstanceProfiles", "iam:Get*", "cognito-idp:DescribeUserPoolClient"]
    resources = ["*"]
  }
}

# ALB Ingress Controller IAM policy resource
# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "alb_ingress" {
  name   = "ALBIngressControllerIAMPolicy"
  policy = data.aws_iam_policy_document.alb_ingress.json
}

# Attach ALBIngressControllerIAMPolicy to the EKS node group role
# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "alb_ingress_ng" {
  policy_arn = aws_iam_policy.alb_ingress.arn
  role       = module.eks.eks_managed_node_groups["sts-pool"].iam_role_name
}