locals {
  env = toset([
    for e in var.env : {
      key   = e.key
      value = e.value
    }
  ])
}

resource "google_cloud_run_v2_job" "this" {
  name     = lower(var.container-name)
  location = var.region

  template {
    template {
      containers {
        image = lower(var.container-image)

        dynamic "env" {
          for_each = [for e in local.env : e if e.value != null]

          content {
            name  = env.value.key
            value = env.value.value
          }
        }
        resources {
          limits = {
            cpu    = "${var.cpus * 1000}m"
            memory = "${var.memory}Mi"
          }
        }
      }
      timeout = "0s"
    }
  }

  launch_stage = "GA"
}
