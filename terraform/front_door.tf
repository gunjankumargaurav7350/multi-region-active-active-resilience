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
  name     = "rg-multiregion-resilience-prod"
  location = "eastus"
  tags = {
    Environment = "Production"
    Pillar      = "Active-Active-Resilience"
    Architect   = "Gunjan Kumar Gaurav"
  }
}

# -------------------------------------------------------------------------------------------------
# Azure Front Door Premium: Global Traffic Router & Anycast Failover
# -------------------------------------------------------------------------------------------------
resource "azurerm_cdn_frontdoor_profile" "afd_profile" {
  name                = "afd-global-resilience-prod"
  resource_group_name = azurerm_resource_group.resilience_rg.name
  sku_name            = "Premium_AzureFrontDoor"
  tags                = azurerm_resource_group.resilience_rg.tags
}

resource "azurerm_cdn_frontdoor_endpoint" "afd_endpoint" {
  name                     = "ep-global-resilience-prod"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd_profile.id
}

# -------------------------------------------------------------------------------------------------
# Cosmos DB Multi-Region Multi-Write Replication (Active-Active)
# -------------------------------------------------------------------------------------------------
resource "azurerm_cosmosdb_account" "cosmos_global" {
  name                = "cosmos-resilient-multiwrite-prod"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.resilience_rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_multiple_write_locations = true # Active-Active multi-master write
  enable_automatic_failover       = true

  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  geo_location {
    location          = "eastus"
    failover_priority = 0
  }

  geo_location {
    location          = "westeurope"
    failover_priority = 1
  }

  tags = azurerm_resource_group.resilience_rg.tags
}
