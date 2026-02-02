variable "location" {
  type        = string
  description = "Azure region"
}

variable "environment_names" {
  type        = list(string)
  description = "List of environments"
}
