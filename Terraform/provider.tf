terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc07"
    }
  }
}

variable "PROXMOX_URL" {
  type = string
}

variable "PROXMOX_USER" {
  type      = string
  sensitive = true
}

variable "PROXMOX_TOKEN" {
  type      = string
  sensitive = true
}

variable "PUBLIC_SSH_KEY" {
  type      = list(string)
  sensitive = true
}

variable "CLOUD_PASS" {
  type      = string
  sensitive = true
}

provider "proxmox" {
  pm_api_url          = "${var.PROXMOX_URL}/api2/json"
  pm_api_token_id     = var.PROXMOX_USER
  pm_api_token_secret = var.PROXMOX_TOKEN
  pm_tls_insecure     = true
}
