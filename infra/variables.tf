variable "location" {
  description = "The location of the AKS cluster."
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group containing the AKS cluster."
  type        = string
  default     = "Spacely_Sprockets_Inc"
}

variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "spacelycluster"
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster."
  type        = string
  default     = "spacelycluster-dns"
}

variable "kubernetes_version" {
  description = "The Kubernetes version for the AKS cluster."
  type        = string
  default     = "1.28.9"
}

variable "enable_rbac" {
  description = "Boolean flag to turn on and off of RBAC."
  type        = bool
  default     = true
}

variable "workspace_name" {
  description = "Specify the name of the OMS workspace."
  type        = string
  default     = "omsnamespace"
}

variable "workspace_region" {
  description = "Specify the region for your OMS workspace."
  type        = string
  default     = "East US"
}

variable "oms_sku" {
  description = "Select the SKU for your workspace."
  type        = string
  default     = "PerGB2018"
}

variable "acr_name" {
  description = "Specify the name of the Azure Container Registry."
  type        = string
  default     = "spacelysprockets"
}

variable "agent_count" {
  description = "The number of agent nodes for the cluster."
  type        = number
  default     = 2
}

variable "agent_vm_size" {
  description = "The size of the Virtual Machine."
  type        = string
  default     = "Standard_D2s_v3"
}

variable "os_disk_size_gb" {
  description = "Disk size (in GiB) to provision for each of the agent pool nodes."
  type        = number
  default     = 250
}

variable "enable_auto_scaling" {
  description = "Specifies whether to enable auto-scaling for the system node pool."
  type        = bool
  default     = true
}

variable "agent_min_count" {
  description = "Specifies the minimum number of nodes for auto-scaling for the system node pool."
  type        = number
  default     = 2
}

variable "agent_max_count" {
  description = "Specifies the maximum number of nodes for auto-scaling for the system node pool."
  type        = number
  default     = 5
}

variable "agent_os_type" {
  description = "The type of operating system for agent pool."
  type        = string
  default     = "Linux"
}

variable "agent_max_pods" {
  description = "Specifies the maximum number of pods that can run on a node in the agent node pool."
  type        = number
  default     = 110
}

variable "network_plugin" {
  description = "Network plugin used for building Kubernetes network."
  type        = string
  default     = "kubenet"
}

variable "load_balancer_sku" {
  description = "Specifies the sku of the load balancer used by the virtual machine scale sets used by node pools."
  type        = string
  default     = "standard"
}

variable "enable_oms_agent" {
  description = "Boolean flag to turn on and off omsagent addon."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Specifies the tags of the AKS cluster."
  type        = map(string)
  default     = {}
}