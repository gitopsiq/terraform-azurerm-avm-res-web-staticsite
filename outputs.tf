output "basic_auth" {
  description = "Basic authentication output"
  sensitive   = true
  value       = var.basic_auth == null ? azurerm_static_web_app.this[0].basic_auth : azurerm_static_web_app.this_basic_auth[0].basic_auth
}

output "name" {
  description = "The name of the static site."
  value       = var.basic_auth == null ? azurerm_static_web_app.this[0].name : azurerm_static_web_app.this_basic_auth[0].name
}

output "resource" {
  description = "This is the full output for the resource."
  sensitive   = true
  value       = var.basic_auth == null ? azurerm_static_web_app.this[0] : azurerm_static_web_app.this_basic_auth[0]
}

output "resource_id" {
  description = "The ID of the static site."
  sensitive   = true
  value       = var.basic_auth == null ? azurerm_static_web_app.this[0].id : azurerm_static_web_app.this_basic_auth[0].id
}

output "resource_private_endpoints" {
  description = "A map of private endpoints. The map key is the supplied input to var.private_endpoints. The map value is the entire azurerm_private_endpoint resource."
  value       = var.basic_auth == null ? azurerm_private_endpoint.this : azurerm_private_endpoint.this_unmanaged_dns_zone_groups
}

output "resource_uri" {
  description = "The default hostname of the static web app."
  value       = var.basic_auth == null ? azurerm_static_web_app.this[0].default_host_name : azurerm_static_web_app.this_basic_auth[0].default_host_name
}
