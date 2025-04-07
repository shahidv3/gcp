output "pubsub_topic_id" {
  value = google_pubsub_topic.log_sink_pubsub_topic.id
}

output "service_account_email" {
  value = google_service_account.log_sink_service_account.email
}
