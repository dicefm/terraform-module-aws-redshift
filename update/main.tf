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
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
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
  cluster_subnet_group_name            = var.cluster_subnet_group_name
  skip_final_snapshot                  = var.skip_final_snapshot
  snapshot_identifier                  = var.snapshot_identifier
  preferred_maintenance_window         = var.preferred_maintenance_window
  automated_snapshot_retention_period  = var.automated_snapshot_retention_period
  publicly_accessible                  = var.publicly_accessible
  iam_roles                            = var.iam_roles
  final_snapshot_identifier            = var.final_snapshot_identifier
  owner_account                        = var.owner_account
  kms_key_id                           = var.kms_key_id
  encrypted                            = var.encrypted
  cluster_parameter_group_name         = var.cluster_parameter_group_name
  #maintenance_track_name               = var.maintenance_track_name
  
  # Can't do in version 3.31.0
  #apply_immediately                     = var.apply_immediately
  #availability_zone_relocation_enabled = var.availability_zone_relocation_enabled

   #dependency added so cluster will delete correctly
   depends_on = [
    aws_redshift_subnet_group.subnet_group,
    aws_redshift_parameter_group.default-redshift-parameter-group
                ]
}

resource "aws_redshift_subnet_group" "subnet_group" {
  name       = var.cluster_subnet_group_name
  #name       = "${aws_redshift_subnet_group.subnet_group.name}"
  subnet_ids = var.private_subnets
}



resource "aws_redshift_parameter_group" "default-redshift-parameter-group" {
  name       = var.cluster_parameter_group_name
  family = "redshift-1.0"

  dynamic "parameter" {
    for_each = var.custom_parameters

    content {
      name         = parameter.value.name
      value        = parameter.value.value
    }

  }

}