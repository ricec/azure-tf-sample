# Configure the Azure Provider
provider "azurerm" { }

# Create a resource group
resource "azurerm_resource_group" "sample_app" {
  name     = "sample-app-rg"
  location = "East US"
}

# Grant "devops" access to the resource group
data "azurerm_subscription" "primary" {}
resource "azurerm_role_assignment" "devops" {
  scope              = "${data.azurerm_subscription.primary.id}"
  role_definition_id = "${data.azurerm_subscription.primary.id}/providers/Microsoft.Authorization/roleDefinitions/${var.devops_role_id}"
  principal_id       = "${var.bill_halls_id}"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "sample_app" {
  name                = "production-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.sample_app.location}"
  resource_group_name = "${azurerm_resource_group.sample_app.name}"

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.0.3.0/24"
  }
}
