variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "bucket_name" {
  description = "GCS bucket name"
  type        = string
}

variable "dataset_id" {
  description = "BigQuery dataset ID"
  type        = string
}