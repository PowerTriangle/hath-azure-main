variable "rg_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
    type = string
    description = "UK Azure location"

    validation {
    condition     = contains(["uksouth", "ukwest"], var.location)
    error_message = "The location must be either uksouth or ukwest azure region"
  }
    
}

variable "environment" {
  type        = string
  description = "The evironment for azure resources to be created in"
}

variable "vnet" {
  type = map(object({
    vnet_name = string
    location = string
    rg_name  = string
    address_space = list(string)
    subnet = optional(map(object({
      subnet_name        = string
      subnet_address_prefix = string
      security_group = optional(string)
    })), {})
  }))
}

variable "nsg" {
  type = map(object({
    nsg_name = string
    nsg_location = string
    nsg_rg_name  = string
    address_space = list(string)
    security_rule = optional(map(object({
      name        = string
      priority = number
      direction = string
      access    = string
      protocol  = string
      source_port_range       = string
      destination_port_range  = string
      source_address_prefix   = string
      destination_address_prefix = string
    })), {})
  }))
}

variable "routes" {
  type = map(object({
    name           = string
    address_prefix = string
    next_hop_type  = string
    
  }))
}

variable "peerings" {
  type = map(object({
    name           = string
    resource_group_name       = azurerm_resource_group.example.name
    virtual_network_name      = azurerm_virtual_network.example-1.name
    remote_virtual_network_id = azurerm_virtual_network.example-2.id
    
  }))
}

variable "vnet_name" {
    type = string
    description = "Name for existing Vnet"
    default = ""
}

variable "vnet_address" {
    type = list(string)
    description = "address prefix for vnet"
}

variable "environment" {
    type = string
    description = "environment"
}


variable "route_table_name" {
    type = string
    description = "Name of Route table"

}

variable "add_route_table" {
    type = bool
    description = "boolean to determine whether to create a route table or not"
    default = false
}

variable "disable_bgp_route_propagation" {
    type = string
    description = "boolean to determine whether to disable bgp route table propagation feature"
    default = false
}

variable "route_names" {
  type      = list(string)
  description = "name of route"
}

variable "route_address_prefixes" {
  type      = list(string)
  description = "name of address prefix for route"
}

variable "route_next_hop_types" {
  type      = list(string)
  description = "name of next hop type for route"
}