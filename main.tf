terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>3.0"
    }
  }
}

variable "gcp_region" {
  type        = string
  description = "Region used for hadoop migration"
  default     = "us-central1"
}

variable "gcp_project" {
  type        = string
  description = "Project to use for this config"
}

provider "google" {
  region  = var.gcp_region
  project = var.gcp_project
}

resource "google_service_account" "service_account" {
  account_id   = "sa-dataproc"
  display_name = "Hadoop Migration Service Account"
}

data "google_iam_policy" "owner" {
  binding {
    role = "roles/iam.owner"

    members = [
      "serviceAccount:${google_service_account.service_account.email}"
    ]
  }
}

resource "google_service_account_iam_policy" "admin-account-iam" {
  service_account_id = google_service_account.service_account.name
  policy_data        = data.google_iam_policy.owner.policy_data
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/iam.serviceAccountAdmin"

    members = [
      "user:projectgcp2022@gmail.com",
      "user:leocyriac@gmail.com",
      "user:lintocyriac@gmail.com",
      "user:scaria.grg@gmail.com",
      "user:timcj029@gmail.com"
    ]
  }
}

resource "google_service_account_iam_policy" "admin-account-iam" {
  service_account_id = google_service_account.service_account.name
  policy_data        = data.google_iam_policy.admin.policy_data
}