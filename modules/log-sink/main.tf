provider "google" {
  project = var.project_id
}

# Service Account
resource "google_service_account" "log_sink_service_account" {
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
}

# IAM Role Binding
resource "google_project_iam_member" "log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.log_sink_service_account.email}"
}

# Pub/Sub Topic
resource "google_pubsub_topic" "log_sink_pubsub_topic" {
  name = var.pubsub_topic_name
}

# Logging Sink
resource "google_logging_project_sink" "log_sink" {
  name        = var.log_sink_name
  destination = "pubsub://${google_pubsub_topic.log_sink_pubsub_topic.id}"
  filter      = var.log_filter

  unique_writer_identity = true
}

output "pubsub_topic_id" {
  value = google_pubsub_topic.log_sink_pubsub_topic.id
}

output "service_account_email" {
  value = google_service_account.log_sink_service_account.email
}
