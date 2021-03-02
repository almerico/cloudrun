###* Cloud Run Latency  | Alerting Policy *###

resource "google_monitoring_alert_policy" "cr_time_rate_cloudrun-srv" {
  display_name          = "CR | Latency | cloudrun-srv"
 # notification_channels = google_monitoring_notification_channel.opsgenie_channel[*].id
  combiner              = "OR"
  conditions {
    display_name = "Latency > 500 for 300s"
   condition_threshold {
			filter = <<EOF
        resource.type="cloud_run_revision" AND
        resource.label.service_name="cloudrun-srv" AND
        metric.type="run.googleapis.com/request_latencies"
      EOF
      comparison      = "COMPARISON_GT"
      duration        = "300s"
      threshold_value = 500

      trigger {
        count = 1
      }
      aggregations {
        alignment_period = "60s"
        // These settings are based on the settings used by the Cloud Run monitoring tab.
        cross_series_reducer = "REDUCE_PERCENTILE_99"
        per_series_aligner   = "ALIGN_DELTA"
      }
    }
  }
  user_labels = { managed_by = "terraform" }
}
