terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.0"
    }
  }
}

provider "google" {
  project = "maquinavirtual-507221"
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_compute_firewall" "permitir_http" {
  name    = "permitir-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["servidor-web"]
}

resource "google_compute_instance" "web" {
  name         = "web-tf"
  machine_type = "e2-micro"
  tags         = ["servidor-web"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = file("arranque.sh")
}