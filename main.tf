provider "ibm" {
  version = ">= 1.9.0"
}

data "ibm_resource_group" "resource_group" {
  name = var.resource_group_name
}

locals {
  name_prefix = var.name_prefix != "" ? var.name_prefix : var.resource_group_name
  name        = var.name != "" ? var.name : "${replace(local.name_prefix, "/[^a-zA-Z0-9_\\-\\.]/", "")}-keyprotect"
  module_path = substr(path.module, 0, 1) == "/" ? path.module : "./${path.module}"
  service_endpoints = var.private_endpoint == "true" ? "private" : "public"
  service     = "kms"
}

resource "ibm_resource_instance" "keyprotect_instance" {
  count = var.provision ? 1 : 0

  name              = local.name
  service           = local.service
  plan              = var.plan
  location          = var.region
  resource_group_id = data.ibm_resource_group.resource_group.id
  tags              = var.tags

  parameters = {
    service-endpoints = local.service_endpoints
  }

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

data "ibm_resource_instance" "keyprotect_instance" {
  depends_on        = [ibm_resource_instance.keyprotect_instance]

  name              = local.name
  resource_group_id = data.ibm_resource_group.resource_group.id
  location          = var.region
  service           = local.service
}

data "ibm_iam_access_group" "admin" {
  count = var.admin-access-group != "" ? 1 : 0

  name  = var.admin-access-group
}

resource "ibm_iam_access_group_policy" "admin_policy" {
  count = var.admin-access-group != "" ? 1 : 0

  access_group_id = element(data.ibm_iam_access_group.admin.*.id, count.index)
  roles           = ["Administrator", "Manager", "ReaderPlus"]
  resources {
    service           = local.service
    resource_group_id = data.ibm_resource_group.resource_group.id
  }
}

data "ibm_iam_access_group" "user" {
  count = var.user-access-group != "" ? 1 : 0

  name  = var.user-access-group
}

resource "ibm_iam_access_group_policy" "user_policy" {
  count = var.user-access-group != "" ? 1 : 0

  access_group_id = element(data.ibm_iam_access_group.user.*.id, count.index)
  roles           = ["Operator", "Reader", "ReaderPlus"]
  resources {
    service           = local.service
    resource_group_id = data.ibm_resource_group.resource_group.id
  }
}
