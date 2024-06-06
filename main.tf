resource "azurerm_virtual_network" "example" {
  for_each = var.vnet

  name                = each.value.vnet_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.vnet_address

  dynamic "subnet" {
    for_each = each.value.subnet
    content {
        name           = subnet.value.subnet_name
        address_prefix = subnet.value.subet_address_prefix
        security_group = subnet.value.security_group
    }
  }

  tags = local.common_tags
}

resource "azurerm_route_table" "test" {
  count =  var.add_route_table ? 1 : 0
  name                          = var.route_table_name
  location                      = var.location
  resource_group_name           = var.rg_name
  disable_bgp_route_propagation = var.disable_bgp_route_propagation

  dynamic "route" {
    for_each = var.routes
    content {
        name           = route.value.name
        address_prefix = route.value.address_prefix
        next_hop_type  = route.value.next_hop_type
    }
  }

  tags = local.common_tags
}

resource "azurerm_network_security_group" "example" {
  for_each = var.nsg

  name                = each.value.nsg_name
  location            = each.value.nsg_location
  resource_group_name = each.value.nsg_rg_name

  dynamic "security_rule" {
    for_each = each.value.security_rule
    content {
    name                       = security_rule.value.name
    priority                   = security_rule.value.priority
    direction                  = security_rule.value.direction
    access                     = security_rule.value.access
    protocol                   = security_rule.value.protocol
    source_port_range          = security_rule.value.source_port_range
    destination_port_range     = security_rule.value.destination_port_range
    source_address_prefix      = security_rule.value.source_address_prefix
    destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  tags = local.common_tags
}

resource "azurerm_virtual_network_peering" "example-1" {
  for_each = var.peerings
  name                      = "peer1to2"
  resource_group_name       = azurerm_resource_group.example.name
  virtual_network_name      = azurerm_virtual_network.example-1.name
  remote_virtual_network_id = azurerm_virtual_network.example-2.id
}