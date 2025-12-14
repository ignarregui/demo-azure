variable "location" { default = "westeurope" }
variable "environment_name" { default = "openwebui-env" }
variable "container_app_name" { default = "openwebui-app" }
variable "image" { default = "ghcr.io/open-webui/open-webui:main" }
variable "db_connection_string" { sensitive = true }
variable "storage_key" { sensitive = true }
variable "openai_endpoint" { sensitive = true }
variable "openai_key" { sensitive = true }