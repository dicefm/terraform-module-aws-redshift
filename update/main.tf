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
  cluster_identifier                   = var.cluster_identifier
  node_type                            = var.node_type
  number_of_nodes                      = var.number_of_nodes
  master_username                      = var.master_username
  master_password                      = random_password.password.result
  database_name                        = var.database_name
  port                                 = var.port
  allow_version_upgrade                = var.allow_version_upgrade
  vpc_security_group_ids               = [ var.security_group ]
  cluster_subnet_group_name            = aws_redshift_subnet_group.subnet_group.name
  skip_final_snapshot                  = var.skip_final_snapshot
  #snapshot_identifier                  = var.snapshot_identifier
  preferred_maintenance_window         = var.preferred_maintenance_window
  #availability_zone                    = var.availability_zone
  #availability_zone_relocation_enabled = var.availability_zone_relocation_enabled
  automated_snapshot_retention_period  = var.automated_snapshot_retention_period
  #cluster_parameter_group_name         = var.cluster_parameter_group_name
  publicly_accessible                  = var.publicly_accessible
  iam_roles                            = var.iam_roles
  #default_iam_role_arn                 = var.default_iam_role_arn
  #apply_immediately                     = var.apply_immediately
}

resource "aws_redshift_subnet_group" "subnet_group" {
  name       = var.name
  subnet_ids = var.private_subnets

  tags = {
    Name = format("%s Subnet Group", var.name)
  }


}

# resource "aws_redshift_cluster_iam_roles" "example_iam_roles" {
#   cluster_identifier = aws_redshift_cluster.edshift_cluster.id
#   iam_roles         = ["arn:aws:iam::521772772230:role/redshift-spectrum"]
# }


resource "aws_redshift_parameter_group" "bar" {
  name   = "omartest4"
  family = "redshift-1.0"

  parameter {
    name  = "require_ssl"
    value = "true"
  }

  parameter {
    name  = "query_group"
    value = "example"
  }

  parameter {
    name  = "enable_user_activity_logging"
    value = "true"
  }
}