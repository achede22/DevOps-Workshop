  resource "azurerm_resource_group" "aks_rg" {
    name     = "Spacely_Sprockets_Inc"
    location = var.location
  }
  
  resource "azurerm_resource_group" "acr_rg" {
    name     = "containerregistryrg"
    location = var.location
  }

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  automatic_channel_upgrade = "patch"
  image_cleaner_enabled = false
  image_cleaner_interval_hours = 48

  default_node_pool {
    name                = "agentpool"
    node_count          = 2
    vm_size             = "Standard_D2s_v3"  # Change to a different VM size
    os_disk_size_gb     = 128
    max_pods            = 110
    type                = "VirtualMachineScaleSets"
    min_count           = 2
    max_count           = 5
    enable_auto_scaling = true

    upgrade_settings {
      max_surge = "10%"
    }
  }

  identity {
    type = "SystemAssigned"
  }
}
  
  resource "azurerm_log_analytics_workspace" "oms_workspace" {
    name                = var.workspace_name
    location            = var.workspace_region
    resource_group_name = azurerm_resource_group.aks_rg.name
    sku                 = var.oms_sku
  
    retention_in_days = 30
  }
  
  resource "azurerm_role_assignment" "acr_pull" {
    principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
    role_definition_name = "AcrPull"
    scope                = azurerm_container_registry.acr.id
  }
  
  resource "azurerm_container_registry" "acr" {
    name                = var.acr_name
    location            = azurerm_resource_group.acr_rg.location
    resource_group_name = azurerm_resource_group.acr_rg.name
    sku                 = "Basic"
    admin_enabled       = true
  }
