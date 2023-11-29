terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
variable "client_secret" {
 3zf8Q~R9q4uPA9t2p.u2bxUNr5ygVC5oVcpnacoo
}
  backend "azurerm" {
    resource_group_name  = "Harshini-Training"
    storage_account_name = "harshinistorageaccount"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  client_id       = "9f853451-c0f9-4f88-be1d-2e578bbb76be"
  client_secret   = var.client_secret
  tenant_id       = "4284bc2c-7bea-4e03-b48a-128cd2886ddb"
  subscription_id = "fb1c9914-31d0-4fa1-a772-739012419bda"
}
