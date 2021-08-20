output "id" {
  value       = local.id
  description = "The id of the provisioned instance."
}

output "guid" {
  value       = local.guid
  description = "The id of the provisioned instance."
}

output "name" {
  value       = local.name
  depends_on  = [ibm_resource_instance.keyprotect_instance]
  description = "The name of the provisioned instance."
}

output "crn" {
  description = "The id of the provisioned instance"
  value       = local.id
}

output "location" {
  description = "The location of the provisioned instance"
  value       = var.region
  depends_on  = [data.ibm_resource_instance.keyprotect_instance]
}

output "service" {
  description = "The service name of the key provisioned for the instance"
  value       = local.service
  depends_on = [data.ibm_resource_instance.keyprotect_instance]
}

output "label" {
  description = "The label for the instance"
  value       = var.label
  depends_on = [data.ibm_resource_instance.keyprotect_instance]
}
