# NY-taxi
Pipeline and Analysys of the New York taxi drives public dataset.

The data is here https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page


## Terraform

Terraform is used to manage the Google Cloud infrastructure required by the data pipeline.

The current configuration manages:

* A Google Cloud Storage bucket
* A BigQuery dataset

### Prerequisites

* Terraform installed
* A Google Cloud project
* A Google Cloud service account with the required permissions
* GCP credentials configured locally

### Configuration

Create a local `terraform.tfvars` file from the example:

```bash
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
```

Then add the appropriate values for:

```hcl
project_id  = "your-gcp-project-id"
region      = "us-central1"
bucket_name = "your-bucket-name"
dataset_id  = "your-dataset-id"
```

The `terraform.tfvars` file and GCP credentials are excluded from Git.

### Initialize Terraform

From the project root:

```bash
cd terraform
terraform init
```

### Review the infrastructure

To preview the changes Terraform would make:

```bash
terraform plan
```

### Apply the configuration

To create or update the infrastructure:

```bash
terraform apply
```

Review the proposed changes and type `yes` to confirm.

### Project-specific note

The GCS bucket and BigQuery dataset used in this project were already created in Google Cloud and were imported into Terraform state. Therefore, running `terraform plan` against the current configuration should show no changes when the infrastructure is already synchronized with Terraform.


