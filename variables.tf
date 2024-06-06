variable "rg_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "The azure location for resources to be created in"
}

variable "environment" {
  type        = string
  description = "The evironment for azure resources to be created in"
}