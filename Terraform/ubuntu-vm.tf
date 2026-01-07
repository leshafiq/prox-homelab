resource "proxmox_vm_qemu" "your-vm" {

  name        = "k3s-master-01"
  target_node = "pve"
  vmid        = "210"

  clone = "ubuntu-cloud"
  cpu {
    cores   = 2
    sockets = 1
    type    = "kvm64"
  }

  memory           = 2048
  os_type          = "cloud-init"
  full_clone       = true
  automatic_reboot = false
  balloon          = 2048

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
          size    = "20G"
        }
      }
    }
  }

  serial {
    id   = 0
    type = "socket"
  }

  vga {
    type = "qxl"
  }

  # Cloud-init settings
  ipconfig0  = "ip=10.10.10.21/24,gw=10.10.10.1"
  nameserver = "1.1.1.1"
  ciuser     = "user"
  cipassword = var.CLOUD_PASS
  sshkeys    = var.PUBLIC_SSH_KEY

  lifecycle {
    ignore_changes = [
      network,
    ]
  }
}
