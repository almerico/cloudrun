terraform {
  required_version = ">= 0.14"
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
    random = {
      source = "hashicorp/random"
    }
    archive = {
      source = "hashicorp/archive"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  # backend "gcs" {
  #   credentials = "./sa-terraform.json"
  #   bucket      = "terraform-cludrun-state"
  #   prefix      = "terraform/cloudrun-gcp"
  # }
}

###* Main Providers *###
provider "google" {
  #credentials = "sa-terraform.json"
  project     = var.gcp_project_id
  region      = var.gcp_region_default
}
provider "google-beta" {
  #credentials = "sa-terraform.json"
  project     = var.gcp_project_id
  region      = var.gcp_region_default
}

###* Common data resources *###
data "google_compute_default_service_account" "default" {}
