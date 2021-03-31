module "dev_key_protect" {
  source = "./module"

  resource_group_name      = var.resource_group_name
  region                   = var.region
  name_prefix              = var.name_prefix
  provision                = true
  ibmcloud_api_key         = var.ibmcloud_api_key
}
