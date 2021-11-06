module "dev_key_protect" {
  source = "./module"

  resource_group_name      = module.resource_group.name
  region                   = var.region
  name_prefix              = var.name_prefix
  provision                = true
}
