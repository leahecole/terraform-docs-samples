# [START cloudrun_service_pubsub_service]
resource "google_cloud_run_service" "default" {
    name     = "cloud_run_service_name"
    location = "us-central1"
    template {
      spec {
            containers {
                image = "gcr.io/cloudrun/hello"
            }
      }
    }
    traffic {
      percent         = 100
      latest_revision = true
    }
}
# [END cloudrun_service_pubsub_service]

# [START cloudrun_service_pubsub_sa]
resource "google_service_account" "sa" {
  account_id   = "cloud-run-pubsub-invoker"
  display_name = "Cloud Run Pub/Sub Invoker"
}
# [END cloudrun_service_pubsub_sa]

# [START cloudrun_service_pubsub_run_invoke_permissions]
resource "google_cloud_run_service_iam_binding" "binding" {
  location = google_cloud_run_service.default.location
  service = google_cloud_run_service.default.name
  role = "roles/run.invoker"
  members = ["serviceAccount:${google_service_account.sa.email}"]
}
# [END cloudrun_service_pubsub_run_invoke_permissions]

# [START cloudrun_service_pubsub_token_permissions]
resource "google_project_iam_binding" "project" {
  role    = "roles/iam.serviceAccountTokenCreator"
  members = ["serviceAccount:${google_service_account.sa.email}"]
}
# [END cloudrun_service_pubsub_token_permissions]

# [START cloudrun_service_pubsub_topic]
resource "google_pubsub_topic" "topic" {
  name = "pubsub_topic"
}
# [END cloudrun_service_pubsub_topic]

# [START cloudrun_service_pubsub_sub]
resource "google_pubsub_subscription" "subscription" {
  name  = "pubsub_subscription"
  topic = google_pubsub_topic.topic.name
  push_config {
    push_endpoint = google_cloud_run_service.default.status[0].url
    oidc_token {
      service_account_email = google_service_account.sa.email
    }
    attributes = {
      x-goog-version = "v1"
    }
  }
}
# [END cloudrun_service_pubsub_sub]
