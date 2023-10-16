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
  snapshot_identifier                  = var.snapshot_identifier
  preferred_maintenance_window         = var.preferred_maintenance_window
  automated_snapshot_retention_period  = var.automated_snapshot_retention_period
  publicly_accessible                  = var.publicly_accessible
  iam_roles                            = var.iam_roles

  # TODO Baked into terragrunt, should live in `terraformpds` to be dynamic
  cluster_parameter_group_name         = aws_redshift_parameter_group.default-redshift-parameter-group.name
  
  # Can't do in version 3.31.0
  #apply_immediately                     = var.apply_immediately
  #availability_zone_relocation_enabled = var.availability_zone_relocation_enabled
}

resource "aws_redshift_subnet_group" "subnet_group" {
  name       = "test"
  subnet_ids = var.private_subnets

  tags = {
    Name = format("%s Subnet Group","test")
  }
}



resource "aws_redshift_parameter_group" "default-redshift-parameter-group" {
  name   = "default-redshift-parameter-group"
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

  parameter {
    name  = "wlm_json_configuration"
    value = jsonencode(jsondecode(file("./wlm.json")))
  }

}