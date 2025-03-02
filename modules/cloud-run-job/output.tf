output "location" {
  value = google_cloud_run_v2_job.this.location
}

# Return Service name
output "name" {
  value = google_cloud_run_v2_job.this.name
}
