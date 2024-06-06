terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "eisworkshop"
    container_name       = "${var.environment}-state"
    subscription_id      = "652a7ae0-ba5c-44a3-aa80-69e61171f84c"
    key                  = "dylan-${var.environment}.tfstate"
  }

}

provider "azurerm" {
  features {}
}