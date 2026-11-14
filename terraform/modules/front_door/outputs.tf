output "profile_id" {
  value = azurerm_cdn_frontdoor_profile.this.id
}

output "endpoint_ids" {
  value = { for k, v in azurerm_cdn_frontdoor_endpoint.endpoints : k => v.id }
}

output "endpoint_hostnames" {
  value = { for k, v in azurerm_cdn_frontdoor_endpoint.endpoints : k => v.host_name }
}
