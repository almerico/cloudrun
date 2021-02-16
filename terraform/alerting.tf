###* Cloud Functions Execution Error Rate | Alerting Policy *###

resource "google_monitoring_alert_policy" "exec_error_rate_item_Monitoring-POC" {
  display_name          = "CR | Execution Error Rate | Cloud Run"
  #notification_channels = google_monitoring_notification_channel.opsgenie_channel[*].id
  combiner              = "OR"
  conditions {
    display_name = "Execution Error Rate > 0.5 for 60s"

    condition_threshold {
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      threshold_value = 0.5

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
        # group_by_fields = [ "value" ]
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
        # group_by_fields = [ "value" ]
      }

    }
  }

  user_labels = { managed_by = "terraform" }
}
