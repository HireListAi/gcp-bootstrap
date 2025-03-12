variable "project_id" {
  type        = string
  description = "The ID of the project"
}

variable "service_name" {
  type        = string
  description = "The name of the service"
}

variable "service_dns_prefix" {
  type        = string
  description = "The name of the service"

  validation {
    condition     = var.service_dns_prefix == "" || can(regex("^[0-9A-Za-z+=,.@_-]+$", var.service_dns_prefix))
    error_message = "Must be valid DNS names is the var.service_name is not source."
  }
}

variable "region" {
  type        = string
  description = "The region where to deploy resources"
  default     = "us-central1"
}

variable "ports" {
  description = "container ports configuration"
  type        = map(any)
  default = {
    port     = "8080"
    protocol = "TCP"
  }
}

variable "container_image" {
  description = "Container image"
  default     = "us-docker.pkg.dev/cloudrun/container/hello"
}

variable "container_cpu" {
  type    = number
  default = 1
}

variable "container_memory" {
  type    = number
  default = 512
}

variable "max_instances" {
  type    = number
  default = 5
}

variable "apps_env" {
  description = "Environment variables to inject into container instances."
  default = [
    {
      key   = "ENV_KEY",
      value = "env_value"
    },
    {
      key   = "ANOTHER_ENV_KEY",
      value = "another_env_value"
    }
  ]
}

variable "labels" {
  description = "The labels to attach to resources created by this module"
  type        = map(string)
  default     = {}
}

variable "dns_zone_name" {
  type    = string
  default = "public-dns"
}

variable "is_prod" {
  type    = bool
  default = false
}
