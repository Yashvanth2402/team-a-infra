resource "azurerm_resource_group" "tfstate" {
  name     = "rg-tfstate"
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstateplatform"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version           = "TLS1_2"
  allow_blob_public_access = false

  blob_properties {
    versioning_enabled = true
  }

  tags = {
    purpose = "terraform-state"
  }
}

resource "azurerm_storage_container" "env" {
  for_each              = toset(var.environment_names)
  name                  = each.value
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}
