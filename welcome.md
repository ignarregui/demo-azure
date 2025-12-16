# OpenWebUI Infra con Terraform

Este repositorio despliega la infraestructura y aplicación OpenWebUI en Azure usando Terraform.

## Pasos
1. Crear service connection en Azure DevOps llamada `AZURE_SUBSCRIPTION`.
2. Añadir variables secretas en Library: `DB_CONNECTION_STRING`, `STORAGE_KEY`, `OPENAI_ENDPOINT`, `OPENAI_KEY`.
3. Crear pipeline en DevOps seleccionando `azure-pipelines.yml`.
4. Ejecutar pipeline → Terraform crea RG, entorno y Container App con la imagen oficial.

## Resultado
- RG: `rg-openwebui`
- Container App: `openwebui-app`
- Imagen: `ghcr.io/open-webui/open-webui:main`

## Test