resource "intersight_boot_precision_policy" "m2-boot" {
  name = "m2-boot"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }
  organization {
    moid = local.organization
  }

  configured_boot_mode     = "Uefi"
  enforce_uefi_secure_boot = false

  boot_devices {
    enabled     = true
    name        = "KVMDVD"
    object_type = "boot.VirtualMedia"
    additional_properties = jsonencode({
      Subtype = "kvm-mapped-dvd"
    })
  }

  boot_devices {
    enabled     = true
    name        = "CIMCDVD"
    object_type = "boot.VirtualMedia"
    additional_properties = jsonencode({
      Subtype = "cimc-mapped-dvd"
    })
  }

  boot_devices {
    enabled     = true
    name        = "m2raid"
    object_type = "boot.LocalDisk"
    additional_properties = jsonencode({
      Slot = "MSTOR-RAID"
      Bootloader = {
        Name       = "BOOTX64.EFI"
        Path       = "\\EFI\\BOOT"
        ObjectType = "boot.Bootloader"
      }
    })
  }

}
