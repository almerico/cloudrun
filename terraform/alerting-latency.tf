
locals {
  one_percent = 0.01
}

resource "google_monitoring_alert_policy" "service_responses" {
  display_name = "API responses tests"
  combiner     = "OR"
//  notification_channels = "Oleksandr Merkulov Email
  conditions {
    display_name = "Errors (%)"

    condition_threshold {
      filter             = "metric.type=\"run.googleapis.com/request_count\" resource.type=\"cloud_run_revision\" resource.label.\"service_name\"=\"cloudrun-srv\" metric.label.\"response_code_class\"!=\"2xx\" metric.label.\"response_code_class\"!=\"3xx\""
      denominator_filter = "metric.type=\"run.googleapis.com/request_count\" resource.type=\"cloud_run_revision\" resource.label.\"service_name\"=\"cloudrun-srv\""
      comparison         = "COMPARISON_GT"
      duration           = "600s"
      threshold_value    = local.one_percent

      trigger {
        count = 1
      }

      aggregations {
        alignment_period     = "300s"
        cross_series_reducer = "REDUCE_SUM"
        per_series_aligner   = "ALIGN_RATE"
      }

      denominator_aggregations {
        alignment_period     = "300s"
        cross_series_reducer = "REDUCE_SUM"
        per_series_aligner   = "ALIGN_RATE"
      }
    }
  }

  conditions {
    display_name = "Request latency (95th percentile)"

    condition_threshold {
      filter          = "metric.type=\"run.googleapis.com/request_latencies\" resource.type=\"cloud_run_revision\" resource.label.\"service_name\"=\"cloudrun-srv\""
      comparison      = "COMPARISON_GT"
      duration        = "600s"
      threshold_value = 500

      trigger {
        count = 1
      }

      aggregations {
        alignment_period = "60s"

        // These settings are based on the settings used by the Cloud Run monitoring tab.
        cross_series_reducer = "REDUCE_PERCENTILE_95"
        per_series_aligner   = "ALIGN_DELTA"
      }
    }
  }
}
