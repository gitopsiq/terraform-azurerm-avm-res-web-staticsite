resource "azurerm_static_web_app_custom_domain" "this" {
  for_each = var.custom_domains

  domain_name       = coalesce(each.value.domain_name, "${each.value.cname_name}.${each.value.cname_zone_name}")
  static_web_app_id = var.basic_auth == null ? azurerm_static_web_app.this[0].id : azurerm_static_web_app.this_basic_auth[0].id
  validation_type   = each.value.validation_type

  depends_on = [
    azurerm_static_web_app.this[0],
    azurerm_static_web_app.this_basic_auth[0],
    azurerm_dns_cname_record.this,
    azurerm_dns_txt_record.this
  ]
}

resource "azurerm_dns_cname_record" "this" {
  for_each = { for cname, cname_values in var.custom_domains : cname => cname_values if cname_values.create_cname_records }

  name                = each.value.cname_name
  resource_group_name = coalesce(each.value.resource_group_name, var.resource_group_name)
  ttl                 = each.value.ttl
  zone_name           = each.value.cname_zone_name
  record              = var.basic_auth == null ? coalesce(each.value.cname_record, azurerm_static_web_app.this[0].default_host_name) : coalesce(each.value.cname_record, azurerm_static_web_app.this_basic_auth[0].default_host_name)
  tags                = var.tags
  target_resource_id  = each.value.cname_target_resource_id

  depends_on = [
    azurerm_static_web_app.this[0],
    azurerm_static_web_app.this_basic_auth[0]
  ]
}

resource "azurerm_dns_txt_record" "this" {
  for_each = { for txt, txt_values in var.custom_domains : txt => txt_values if txt_values.create_txt_records }

  name                = each.value.txt_name
  resource_group_name = coalesce(each.value.resource_group_name, var.resource_group_name)
  ttl                 = each.value.ttl
  zone_name           = each.value.txt_zone_name
  tags                = var.tags

  dynamic "record" {
    for_each = each.value.txt_records

    content {
      value = record.value.value
    }
  }

  depends_on = [
    azurerm_static_web_app.this[0],
    azurerm_static_web_app.this_basic_auth[0]
  ]
}