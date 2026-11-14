terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resilience_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# -------------------------------------------------------------------------------------------------
# Modular Front Door Profiles using for_each
# -------------------------------------------------------------------------------------------------
module "front_door" {
  source   = "./modules/front_door"
  for_each = var.front_door_profiles

  resource_group_name = azurerm_resource_group.resilience_rg.name
  profile_name        = each.key
  sku_name            = each.value.sku_name
  endpoints           = each.value.endpoints
  tags                = merge(azurerm_resource_group.resilience_rg.tags, each.value.tags)
}

# -------------------------------------------------------------------------------------------------
# Modular Cosmos DB Multi-Region Replication using for_each
# -------------------------------------------------------------------------------------------------
module "cosmos_db" {
  source   = "./modules/cosmos_db"
  for_each = var.cosmos_db_accounts

  resource_group_name             = azurerm_resource_group.resilience_rg.name
  location                        = azurerm_resource_group.resilience_rg.location
  account_name                    = each.key
  kind                            = each.value.kind
  enable_multiple_write_locations = each.value.enable_multiple_write_locations
  enable_automatic_failover       = each.value.enable_automatic_failover
  consistency_level               = each.value.consistency_level
  geo_locations                   = each.value.geo_locations
  tags                            = merge(azurerm_resource_group.resilience_rg.tags, each.value.tags)
}
