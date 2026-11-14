output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.resilience_rg.name
}

output "front_door_profiles" {
  description = "Front Door Profiles and Endpoints provisioned via modular for_each"
  value = {
    for k, v in module.front_door : k => {
      profile_id = v.profile_id
      endpoints  = v.endpoints
    }
  }
}

output "cosmos_db_accounts" {
  description = "Cosmos DB accounts provisioned via modular for_each"
  value = {
    for k, v in module.cosmos_db : k => {
      id                  = v.id
      endpoint            = v.endpoint
      read_endpoints      = v.read_endpoints
      write_endpoints     = v.write_endpoints
    }
  }
}
