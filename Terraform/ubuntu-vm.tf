resource "proxmox_vm_qemu" "docker-01" {

  name        = "docker-01"
  target_node = "pve-01"
  vmid        = "201"

  clone = "ubuntu-cloud"
  cpu {
    cores   = 2
    sockets = 2
    type    = "host"
  }

  memory           = 16384
  os_type          = "cloud-init"
  full_clone       = true
  automatic_reboot = false
  balloon          = 16384

  network {
    id     = 0
    bridge = "vmbr0"
    model  = "virtio"
    tag    = 10
  }

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"
  boot     = "c"

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = "64G"
        }
      }
    }
  }

  serial {
    id   = 0
    type = "socket"
  }

  vga {
    type = "std"
  }

  # Cloud-init settings
  ipconfig0  = "ip=1.1.1.1/24,gw=10.10.10.1"
  nameserver = "1.1.1.1"
  ciuser     = "user"
  cipassword = var.CLOUD_PASS
  sshkeys    = join("\n", var.PUBLIC_SSH_KEY)

  lifecycle {
    ignore_changes = [
      network,
    ]
  }
}

resource "proxmox_vm_qemu" "docker-02" {

  name        = "docker-02"
  target_node = "pve-01"
  vmid        = "202"

  clone = "ubuntu-cloud"
  cpu {
    cores   = 2
    sockets = 2
    type    = "host"
  }

  memory           = 8192
  os_type          = "cloud-init"
  full_clone       = true
  automatic_reboot = false
  balloon          = 8192

  network {
    id     = 0
    bridge = "vmbr0"
    model  = "virtio"
    tag    = 10
  }

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"
  boot     = "c"

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = "64G"
        }
      }
    }
  }

  serial {
    id   = 0
    type = "socket"
  }

  vga {
    type = "std"
  }

  # Cloud-init settings
  ipconfig0  = "ip=11.1.1.1/24,gw=10.10.10.1"
  nameserver = "1.1.1.1"
  ciuser     = "user"
  cipassword = var.CLOUD_PASS
  sshkeys    = join("\n", var.PUBLIC_SSH_KEY)

  lifecycle {
    ignore_changes = [
      network,
    ]
  }
}
