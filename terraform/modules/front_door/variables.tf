variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "profile_name" {
  type        = string
  description = "Front Door Profile Name"
}

variable "sku_name" {
  type        = string
  default     = "Premium_AzureFrontDoor"
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "endpoints" {
  type = map(object({
    tags = optional(map(string), {})
  }))
  default = {}
}
