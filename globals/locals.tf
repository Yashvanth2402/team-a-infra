locals {
  organization = "myorg"
  platform     = "ai-platform"

  common_tags = {
    organization = local.organization
    platform     = local.platform
    managed_by   = "terraform"
  }
}
