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

## Docker: Kestra and dbts

Docker Compose is used to run Kestra and the dbt pipeline in a containerized environment.

The project includes:

* Kestra for workflow orchestration and scheduling
* dbt for data transformation in BigQuery
* A Kestra flow in flows/ for the GCP taxi pipeline

### How to run

Clone the repository:

```bash
git clone https://github.com/kj-data/nyc-taxi-end-to-end-pipeline.git
cd nyc-taxi-end-to-end-pipeline
```

Configure the required GCP credentials and dbt connection settings locally.

Start Kestra and dbt:



```bash
docker compose up --build
```

GCP credentials are excluded from Git and must be configured locally.

### Data Quality Testing

The dbt project includes **34 data quality tests**, covering uniqueness, null checks, accepted values, referential integrity, and custom business rules.

The custom test `trips_invalid_time_with_fare` identifies trips where:

* pickup time is equal to or later than dropoff time,
* fare amount is greater than 0, and
* trip distance is non-zero.

The test currently identifies **44 anomalous trips** requiring further investigation.

**Latest dbt test run:** 34 tests — **33 passed, 1 failed** (44 rows identified by the custom business-rule test).

