# Upload function (object) in Cloud Storage
# https://www.terraform.io/docs/providers/google/r/storage_bucket_object.html
resource "google_storage_bucket_object" "archive_function" {
  name   = var.bucket_archive_name
  bucket = var.bucket_name
  source = var.local_path

  content_type = "application/zip"
}

# Create new CloudFunction
# https://www.terraform.io/docs/providers/google/r/cloudfunctions_function.html
resource "google_cloudfunctions2_function" "function" {
  name        = var.function_name
  location    = "us-central1"
  description = var.function_description
  labels      = var.labels

  build_config {
    runtime               = var.runtime
    entry_point           = var.function_entry_point
    environment_variables = var.environment
    source {
      storage_source {
        bucket = var.bucket_name
        object = google_storage_bucket_object.archive_function.name
      }
    }
  }

  service_config {
    max_instance_count               = var.function_max_instances
    min_instance_count               = 0
    available_memory                 = var.function_memory
    max_instance_request_concurrency = var.function_concurrency
    timeout_seconds                  = var.function_timeout
    environment_variables            = var.environment
  }

  event_trigger {
    trigger_region = "us-central1"
    event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic   = var.pubsub_trigger_topic
    retry_policy   = "RETRY_POLICY_RETRY"
  }
}
