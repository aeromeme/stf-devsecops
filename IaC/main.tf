provider "google"{

    credentials = file("./stf-taller001-85d2bd6a56c4.json")
}

resource "google_container_cluster" "default" {
  name     = var.cluster_name
  location = var.location
  project = var.project
  description = "proyecto ecommerce mguerra"
  enable_legacy_abac = true
  remove_default_node_pool=true
  initial_node_count       = var.initial_node_count

  master_auth {
   // username = ""
   // password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "default" {
  name       = var.node_pool_name
  location   = var.location
  project = var.project
  cluster    = google_container_cluster.default.name
  node_count = var.initial_node_count

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}