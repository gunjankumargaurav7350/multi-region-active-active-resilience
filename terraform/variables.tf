variable "resource_group_name" {
  type        = string
  description = "Resource Group Name for multi-region resilience deployment"
  default     = "rg-multiregion-resilience-prod"
}

variable "location" {
  type        = string
  description = "Primary Azure region"
  default     = "eastus"
}

variable "tags" {
  type        = map(string)
  description = "Global tags for all resources"
  default = {
    Environment = "Production"
    Pillar      = "Active-Active-Resilience"
    Architect   = "Gunjan Kumar Gaurav"
  }
}

variable "front_door_profiles" {
  type = map(object({
    sku_name  = optional(string, "Premium_AzureFrontDoor")
    tags      = optional(map(string), {})
    endpoints = optional(map(object({
      tags = optional(map(string), {})
    })), {})
  }))
  description = "Map of Front Door profiles with endpoints configured using for_each"
  default = {
    "afd-global-resilience-prod" = {
      sku_name = "Premium_AzureFrontDoor"
      endpoints = {
        "ep-global-resilience-prod" = {}
      }
    }
  }
}

variable "cosmos_db_accounts" {
  type = map(object({
    kind                            = optional(string, "GlobalDocumentDB")
    enable_multiple_write_locations = optional(bool, true)
    enable_automatic_failover       = optional(bool, true)
    consistency_level               = optional(string, "Session")
    tags                            = optional(map(string), {})
    geo_locations = optional(list(object({
      location          = string
      failover_priority = number
    })), [
      {
        location          = "eastus"
        failover_priority = 0
      },
      {
        location          = "westeurope"
        failover_priority = 1
      }
    ])
  }))
  description = "Map of Cosmos DB accounts with active-active multi-region replication using for_each"
  default = {
    "cosmos-resilient-multiwrite-prod" = {
      kind                            = "GlobalDocumentDB"
      enable_multiple_write_locations = true
      enable_automatic_failover       = true
      consistency_level               = "Session"
      geo_locations = [
        {
          location          = "eastus"
          failover_priority = 0
        },
        {
          location          = "westeurope"
          failover_priority = 1
        }
      ]
    }
  }
}
