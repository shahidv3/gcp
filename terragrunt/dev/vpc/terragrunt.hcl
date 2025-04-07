terraform {
  source = "../../modules/google-log-sync"
}

inputs = {
  project_id                 = "your-project-id"
  service_account_id         = "vpc-log-sink-service-account"
  service_account_display_name = "VPC Log Sink Service Account"
  pubsub_topic_name          = "vpc-log-sink-topic"
  log_sink_name              = "vpc-log-sink"
  log_filter                 = "resource.type=\"gce_instance\" OR resource.type=\"gce_disk\" OR resource.type=\"gce_network\""
}
