terraform {
  required_version = ">= 1.7.0"
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = ">=2.1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.12.0"
    }
    modtm = {
      source  = "azure/modtm"
      version = ">= 0.3.2"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.3"
    }
  }
}
