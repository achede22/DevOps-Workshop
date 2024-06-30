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
    resource_group_name = var.resource_group_name
    dns_prefix          = var.dns_prefix
    kubernetes_version  = var.kubernetes_version
    automatic_channel_upgrade           = "patch"
    image_cleaner_enabled               = false
    image_cleaner_interval_hours        = 48

    default_node_pool {
      name                = "agentpool"
      node_count          = 2
      vm_size             = "Standard_D2plds_v5"
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
  
    network_profile {
      network_plugin              = "azure"
      load_balancer_sku           = var.load_balancer_sku
      service_cidr                = "10.0.0.0/16"
      dns_service_ip              = "10.0.0.10"
      outbound_type               = "loadBalancer"
    }


    maintenance_window_auto_upgrade {
        day_of_month = 0
        day_of_week  = "Sunday"
        duration     = 4
        frequency    = "Weekly"
        interval     = 1
        start_date   = "2024-06-27T00:00:00Z"
        start_time   = "00:00"
        utc_offset   = "+00:00"
      }

    maintenance_window_node_os {
        day_of_month = 0
        day_of_week  = "Sunday"
        duration     = 4
        frequency    = "Weekly"
        interval     = 1
        start_date   = "2024-06-27T00:00:00Z"
        start_time   = "00:00"
        utc_offset   = "+00:00"
      }
  
    tags = {
      environment = "development"
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
