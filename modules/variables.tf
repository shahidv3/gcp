variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "service_account_id" {
  description = "ID for the service account"
  type        = string
}

variable "service_account_display_name" {
  description = "Display name for the service account"
  type        = string
}

variable "pubsub_topic_name" {
  description = "The name of the Pub/Sub topic"
  type        = string
}

variable "log_sink_name" {
  description = "The name of the log sink"
  type        = string
}

variable "log_filter" {
  description = "The filter to capture logs"
  type        = string
}
