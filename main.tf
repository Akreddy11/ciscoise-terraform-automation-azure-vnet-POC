

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Single-file friendly: set your values here (or switch back to var.* if you prefer)
locals {
  vnet_cfg = {
    location             = "eastus"
    vnet_name            = "prod-vnet"
    ise_resource_group   = "rg-ise-prod"
    vnet_address         = "10.40.0.0/16"
    private_subnet_cidrs = ["10.40.1.0/24", "10.40.2.0/24"]
    public_subnet_cidrs  = ["10.40.10.0/24"]
    ise_func_subnet_cidr = "10.40.20.0/24"
    ise_func_subnet      = "ise-func-subnet"
  }
}

module "vnet" {
  source               = "./modules/vnet"
  location             = local.vnet_cfg.location
  vnet_name            = local.vnet_cfg.vnet_name
  ise_resource_group   = local.vnet_cfg.ise_resource_group
  vnet_address         = local.vnet_cfg.vnet_address
  private_subnet_cidrs = local.vnet_cfg.private_subnet_cidrs
  public_subnet_cidrs  = local.vnet_cfg.public_subnet_cidrs
  ise_func_subnet_cidr = local.vnet_cfg.ise_func_subnet_cidr
  ise_func_subnet      = local.vnet_cfg.ise_func_subnet
}
