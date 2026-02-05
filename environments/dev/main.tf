locals {
  env_tags = merge(
    var.tags,
    {
      environment = var.environment
    }
  )

  resource_group_name = "rg-myorg-ai-platform-${var.environment}-network"
}

resource "azurerm_resource_group" "network" {
  name     = local.resource_group_name
  location = var.location
  tags     = local.env_tags
}

module "vnet" {
  source              = "../../modules/network/vnet"
  name                = "myorg-ai-${var.environment}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = ["10.10.0.0/16"]
  tags                = local.env_tags
}

module "nsg" {
  source              = "../../modules/network/nsg"
  name                = "myorg-ai-${var.environment}-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name
  tags                = local.env_tags
}

module "subnet_app" {
  source               = "../../modules/network/subnet"
  name                 = "app-subnet"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = module.vnet.name
  address_prefixes     = ["10.10.1.0/24"]
  nsg_id               = module.nsg.id
}
