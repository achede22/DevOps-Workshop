# terraform {
#   backend "azurerm" {
#     resource_group_name   = "terraform-resource-group"
#     storage_account_name  = "spacelybackend"
#     container_name        = "tfstate"
#     key                   = "terraform.tfstate"
#   }
# }
# 

provider "azurerm" {
  features {}
}
