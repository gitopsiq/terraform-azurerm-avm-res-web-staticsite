output "name" {
  description = "The name of the static site."
  value       = azurerm_static_site.this.name
}

output "resource" {
  description = "This is the full output for the resource."
  value       = azurerm_static_site.this
}

output "resource_id" {
  description = "The ID of the static site."
  value       = azurerm_static_site.this.id
}

output "resource_private_endpoints" {
  description = "A map of private endpoints. The map key is the supplied input to var.private_endpoints. The map value is the entire azurerm_private_endpoint resource."
  value       = azurerm_private_endpoint.this
}

output "resource_uri" {
  description = "The default hostname of the static site."
  value       = azurerm_static_site.this.default_host_name
}
