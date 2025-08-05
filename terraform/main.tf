terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}



provider "aws" {
  region = "us-east-1"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"  # Latest as of now

  cluster_name    = "super-service-cluster"
  cluster_version = "1.28"

  vpc_id     = "vpc-0e073ba56ad6b12eb"
  subnet_ids = ["subnet-09ea78ceb39a4a3eb", "subnet-053c27fc315a5eb72"]

  eks_managed_node_groups = {
    default = {
      instance_types = ["t2.micro"]
      desired_size   = 2
      min_size       = 1
      max_size       = 3
    }
  }

  enable_irsa = true
}

#resource "aws_ecr_repository" "super_service" {
  #name = "super-service"

  #image_scanning_configuration {
   # scan_on_push = true
 # }

  #encryption_configuration {
   # encryption_type = "AES256"
 # }

 # lifecycle {
   # prevent_destroy = true
  #  ignore_changes  = [name]
 # }
#}




