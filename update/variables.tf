variable "cluster_identifier" {
  description = "The identifier for the Redshift cluster."
}

variable "node_type" {
  description = "The node type for the Redshift cluster."
  default     = "dc2.large"
}

variable "number_of_nodes" {
  description = "The number of nodes in the Redshift cluster."
  default     = 2
}

variable "master_username" {
  description = "The master username for the Redshift cluster."
}

variable "database_name" {
  description = "The name of the default database created in the Redshift cluster."
  default     = "mydb"
}

variable "region" {
  description = "AWS Region to be used (it effects all resources)"
  type        = string
}

variable "port"{
  description = "(Optional) The port number on which the cluster accepts incoming connections. Valid values are between 1115 and 65535. The cluster is accessible only via the JDBC and ODBC connection strings. Part of the connection string requires the port on which the cluster will listen for incoming connections. Default port is 5439."
  default = 5439
}

variable "cluster_type"{
  description = "(Optional) The cluster type to use. Either single-node or multi-node."
  default = "single-node"
}

variable "allow_version_upgrade"{
  description = "(Optional) If true , major version upgrades can be applied during the maintenance window to the Amazon Redshift engine that is running on the cluster. Default is true"
  default = "true"
}

variable "security_group" {
  description = "The ID of the security group"
  type        = string
}

variable "name" {
  description = "Name of subnet group"
  type        = string
}

variable "private_subnets" {
  description = "List of IDs of the subnet"
  type        = list(string)
}

variable "skip_final_snapshot"{
  description = "(Optional) Determines whether a final snapshot of the cluster is created before Amazon Redshift deletes the cluster. If true , a final cluster snapshot is not created. If false , a final cluster snapshot is created before the cluster is deleted. Default is false."
}

variable "snapshot_identifier"{
  description = "(Optional) The name of the snapshot from which to create the new cluster."
}

variable "preferred_maintenance_window"{
  description = "(Optional) The weekly time range (in UTC) during which automated cluster maintenance can occur. Format: ddd:hh24:mi-ddd:hh24:mi."
}

 variable "availability_zone_relocation_enabled" {
   description = "Optional) If true, the cluster can be relocated to another availabity zone, either automatically by AWS or when requested. Default is false. Available for use on clusters from the RA3 instance family."
 }

variable "automated_snapshot_retention_period"{
  description = "(Optional) The number of days that automated snapshots are retained. If the value is 0, automated snapshots are disabled. Even if automated snapshots are disabled, you can still create manual snapshots when you want with create-cluster-snapshot. Default is 1."
}

variable "availability_zone"{
  description = "(Optional) The EC2 Availability Zone (AZ) in which you want Amazon Redshift to provision the cluster. For example, if you have several EC2 instances running in a specific Availability Zone, then you might want the cluster to be provisioned in the same zone in order to decrease network latency. Can only be changed if availability_zone_relocation_enabled is true."
}

# variable "iam_roles" {
#   description = "(Optional) A list of IAM Role ARNs to associate with the cluster. A Maximum of 10 can be associated to the cluster at any time."
# }

# variable "cluster_parameter_group_name"{
#   description = "The name of the parameter group to be associated with this cluster"
# }

 variable "publicly_accessible"{
   description = "(Optional) If true, the cluster can be accessed from a public network. Default is true"
 }
