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