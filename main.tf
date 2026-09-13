terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.0"
    }
  }
    backend "gcs" {
    bucket = "tfstate-maquinavirtual-507221"
    prefix = "practica-2"
  }

}

provider "google" {
  project = var.proyecto
  region  = "us-central1"
  zone    = var.zona
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

resource "google_compute_address" "ip_estatica" {
  name = "ip-estatica-web"
}

resource "google_compute_instance" "web" {
  name                      = "web-tf"
  machine_type              = var.tipo_maquina
  tags                      = ["servidor-web"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.ip_estatica.address
    }
  }

  metadata_startup_script = file("arranque.sh")
}