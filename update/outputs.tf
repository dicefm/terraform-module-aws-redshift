output "redshift_cluster_id" {
  description = "The ID of the Redshift cluster."
  value       = aws_redshift_cluster.redshift_cluster.id
}

output "redshift_cluster_endpoint" {
  description = "The endpoint of the Redshift cluster."
  value       = aws_redshift_cluster.redshift_cluster.endpoint
}

output "redshift_master_password" {
  description = "db master pass"
  value       = aws_redshift_cluster.redshift_cluster.master_password
  sensitive   = true
}

output "loadbalancer_address" {
  description = "The loadbalancer address"
  value       = aws_lb.nlb_redshift.dns_name
}


