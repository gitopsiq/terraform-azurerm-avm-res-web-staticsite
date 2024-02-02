terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0, < 4.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0, < 4.0.0"
    }
    prevent_deletion_if_contains_resources = false
  }
}

provider "azurerm" {
  features {}
}

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.0"
}

# Helps pick a random region from the list of regions.
resource "random_integer" "region_index" {
  max = length(local.azure_regions) - 1
  min = 0
}

# This is required for resource modules
resource "azurerm_resource_group" "example" {
  location = local.azure_regions[random_integer.region_index.result]
  name     = module.naming.resource_group.name_unique
}

# This is the module call
module "staticsite" {
  source = "../../"

  # source             = "Azure/avm-res-web-staticsite/azurerm"
  # version = "0.1.0"

  enable_telemetry = var.enable_telemetry

  name                = "${module.naming.static_web_app.name_unique}-free"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  repository_url = ""
  branch         = ""

  identities = {
    # Identities can only be used with the Standard SKU
  }

  app_settings = {
    # Example
  }

}
