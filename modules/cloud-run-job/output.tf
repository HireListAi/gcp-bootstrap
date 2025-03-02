output "location" {
  value = google_cloud_run_v2_job.this.location
}

# Return Service name
output "name" {
  value = google_cloud_run_v2_job.this.name
}

output "service_account" {
  value = google_cloud_run_v2_job.this.template[0].template[0].service_account_name
}
