provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

module "project" {
  source = "../../modules/project"

  project_id      = "prod-source-atlas"
  project_name    = "prod-source-atlas"
  billing_account = "017DBF-6EA665-FE7990"
  org_id          = "366827031981"
}
