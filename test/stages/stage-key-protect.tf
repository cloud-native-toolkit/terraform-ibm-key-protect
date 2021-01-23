module "dev_key_protect" {
  source = "./module"

  resource_group_name      = var.resource_group_name
  region                   = var.region
  name_prefix              = var.name_prefix
  provision                = true
  admin-access-group       = var.admin_access_group
  user-access-group        = var.user_access_group
  ibmcloud_api_key         = var.ibmcloud_api_key
}
