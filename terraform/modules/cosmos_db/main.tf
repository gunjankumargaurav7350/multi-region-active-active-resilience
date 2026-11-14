resource "azurerm_cosmosdb_account" "this" {
  name                = var.account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = var.kind

  enable_multiple_write_locations = var.enable_multiple_write_locations
  enable_automatic_failover       = var.enable_automatic_failover

  consistency_policy {
    consistency_level       = var.consistency_level
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  dynamic "geo_location" {
    for_each = var.geo_locations
    content {
      location          = geo_location.value.location
      failover_priority = geo_location.value.failover_priority
    }
  }

  tags = var.tags
}
