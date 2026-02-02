terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstateplatform01"
    container_name       = "dev"
    key                  = "infra.tfstate"

    use_azuread_auth = true
  }
}
