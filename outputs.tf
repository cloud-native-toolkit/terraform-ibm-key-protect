output "id" {
  value       = data.ibm_resource_instance.keyprotect_instance.id
  description = "The id of the provisioned HPCS instance."
}

output "name" {
  value       = local.name
  depends_on  = [ibm_resource_instance.keyprotect_instance]
  description = "The name of the provisioned HPCS instance."
}
