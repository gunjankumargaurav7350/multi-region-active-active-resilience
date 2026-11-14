variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Primary Region"
}

variable "account_name" {
  type        = string
  description = "Cosmos DB Account Name"
}

variable "kind" {
  type        = string
  default     = "GlobalDocumentDB"
}

variable "enable_multiple_write_locations" {
  type        = bool
  default     = true
}

variable "enable_automatic_failover" {
  type        = bool
  default     = true
}

variable "consistency_level" {
  type        = string
  default     = "Session"
}

variable "geo_locations" {
  type = list(object({
    location          = string
    failover_priority = number
  }))
  default = []
}

variable "tags" {
  type        = map(string)
  default     = {}
}
