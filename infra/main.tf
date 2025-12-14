provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-openwebui"
  location = var.location
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "openwebui-law"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "env" {
  name                = var.environment_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  logs {
    destination = "log-analytics"
    log_analytics {
      customer_id = azurerm_log_analytics_workspace.law.workspace_id
      shared_key  = azurerm_log_analytics_workspace.law.primary_shared_key
    }
  }
}

resource "azurerm_container_app" "app" {
  name                         = var.container_app_name
  resource_group_name          = azurerm_resource_group.rg.name
  container_app_environment_id = azurerm_container_app_environment.env.id
  revision_mode                = "Single"

  template {
    container {
      name   = "openwebui"
      image  = var.image
      cpu    = 1
      memory = "2Gi"
      env {
        name        = "DB_CONNECTION_STRING"
        secret_name = "dbconn"
      }
      env {
        name        = "STORAGE_KEY"
        secret_name = "storagekey"
      }
      env {
        name        = "OPENAI_ENDPOINT"
        secret_name = "openaiendpoint"
      }
      env {
        name        = "OPENAI_KEY"
        secret_name = "openaikey"
      }
    }
  }

  ingress {
    external_enabled = true
    target_port      = 8080
  }

  secret { name = "dbconn" value = var.db_connection_string }
  secret { name = "storagekey" value = var.storage_key }
  secret { name = "openaiendpoint" value = var.openai_endpoint }
  secret { name = "openaikey" value = var.openai_key }
}