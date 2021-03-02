###* Cloud Run 5XX Error Rate | Alerting Policy *###

resource "google_monitoring_alert_policy" "cr_error_rate_5xx_cloudrun-srv" {
  display_name          = "CR | Error Rate 5xx | cloudrun-srv"
#  notification_channels = google_monitoring_notification_channel.opsgenie_channel[*].id
  combiner              = "OR"
  conditions {
    display_name = "Execution 5xx Rate < 0.001 for 300s"

    condition_threshold {
      comparison      = "COMPARISON_GT"
      duration        = "300s"
      threshold_value = 0.001

      filter = <<EOF
        resource.type="cloud_run_revision" AND
        resource.label.service_name="cloudrun-srv" AND
        metric.type="run.googleapis.com/request_count" AND
        metric.label.response_code_class="5xx"
      EOF
      aggregations {
        alignment_period     = "60s"
        per_series_aligner   = "ALIGN_DELTA"
        cross_series_reducer = "REDUCE_SUM"
      }

      denominator_filter = <<EOF
        resource.type="cloud_run_revision" AND
        resource.label.service_name="cloudrun-srv" AND
        metric.type="run.googleapis.com/request_count"
      EOF
      denominator_aggregations {
        alignment_period     = "60s"
        per_series_aligner   = "ALIGN_DELTA"
        cross_series_reducer = "REDUCE_SUM"
      }
    }
  }
  user_labels = { managed_by = "terraform" }
}
