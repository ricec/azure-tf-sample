# Create random ID for App Service Name
resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}

# Create App Service Plan
resource "azurerm_app_service_plan" "test" {
  name                = "chrrice-sample-plan"
  location            = "${azurerm_resource_group.sample_app.location}"
  resource_group_name = "${azurerm_resource_group.sample_app.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

# Create Web App
resource "azurerm_app_service" "test" {
  name                = "${random_id.server.hex}"
  location            = "${azurerm_resource_group.sample_app.location}"
  resource_group_name = "${azurerm_resource_group.sample_app.name}"
  app_service_plan_id = "${azurerm_app_service_plan.test.id}"

  site_config {
    java_version           = "1.7"
    java_container         = "JETTY"
    java_container_version = "9.3"
  }
}
