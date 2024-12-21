terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.18.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "jenkinsstatemichael"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_virtual_network" "main" {
  name                = "example-vnet"
  location            = "East US"
  resource_group_name = "RG1"
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "lab"
  }
}
