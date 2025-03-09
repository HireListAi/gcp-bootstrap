variable "region" {
  default = "europe-west1"
}

variable "project_id" {
  default     = ""
  description = "The ID of the project where this VPC will be created"
}

variable "container-name" {
  default = ""
}

variable "container-image" {
  description = "Container image"
  default     = ""
}

variable "ports" {
  description = "container ports configuration"
  type        = map(any)
  default = {
    port     = "8080"
    protocol = "TCP"
  }
}

variable "env" {
  type = set(object({
    key   = string,
    value = string,
  }))

  default     = []
  description = "Environment variables to inject into container instances."

  validation {
    error_message = "Environment variables must have one of `value` or `secret` defined."
    condition = alltrue([
      length([for e in var.env : e if(e.key == null && e.value == null)]) < 1,
    ])
  }
}

variable "cpus" {
  type        = number
  default     = 1
  description = "Number of CPUs to allocate per container."
}

variable "memory" {
  type        = number
  default     = 256
  description = "Memory (in Mi) to allocate to containers."
}

variable "volumes" {
  type = set(object({
    path     = string,
    secret   = string,
    versions = map(string)
  }))

  default     = []
  description = "Volumes to be mounted & populated from secrets."

  validation {
    error_message = "Multiple volumes for the same path can't be defined."
    condition     = length(tolist(var.volumes.*.path)) == length(toset(var.volumes.*.path))
  }
}

variable "is_prod" {
  type    = bool
  default = false
}

variable "min_instances" {
  type    = number
  default = 1
}
variable "max_instances" {
  type    = number
  default = 5
}

variable "timeout_seconds" {
  type    = number
  default = 300
}
