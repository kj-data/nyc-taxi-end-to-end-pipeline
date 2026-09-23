terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

provider "google" {
  credentials = file("${path.module}/credentials/terraform_nytaxi.json")
  project     = var.project_id
  region      = var.region
}

resource "google_storage_bucket" "taxi_data" {
  name          = var.bucket_name
  location      = var.region
  storage_class = "REGIONAL"

  force_destroy = false
}

resource "google_bigquery_dataset" "taxi_dataset" {
  dataset_id = var.dataset_id
  location   = var.region
}