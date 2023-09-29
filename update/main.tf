# ########
# Provider
# ########
provider "aws" {
  region = var.region
}

# #########
# terraform
# #########
# rest of the backend part will be filled by terragrunt

terraform {
  backend "s3" {}
}


# ###
# random pass generator
# ###
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


# ###
# Redshift
# ###
resource "aws_redshift_cluster" "redshift_cluster" {
  cluster_identifier        = var.cluster_identifier
  node_type                 = var.node_type
  number_of_nodes           = var.number_of_nodes
  master_username           = var.master_username
  master_password           = random_password.password.result
  database_name             = var.database_name
  port                      = var.port
  allow_version_upgrade     = var.allow_version_upgrade
  vpc_security_group_ids    = [ var.security_group ]
  cluster_subnet_group_name = aws_redshift_subnet_group.subnet_group.name
  skip_final_snapshot       = var.skip_final_snapshot
}

resource "aws_redshift_subnet_group" "subnet_group" {
  name       = var.name
  subnet_ids = var.private_subnets

  tags = {
    Name = format("%s Subnet Group", var.name)
  }
}