resource "intersight_server_profile" "gpu-node-01" {
  name = "gpu-node-01"

  lifecycle { ignore_changes = [
    server_assignment_mode
  ] }

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

  target_platform = "FIAttached"

  policy_bucket { # BIOS
    moid        = intersight_bios_policy.ai-toolkit.moid
    object_type = intersight_bios_policy.ai-toolkit.object_type
  }

  policy_bucket { # Boot Order
    moid        = intersight_boot_precision_policy.m2-boot.moid
    object_type = intersight_boot_precision_policy.m2-boot.object_type
  }

  policy_bucket { # Virtual Media
    moid        = intersight_vmedia_policy.enabled.moid
    object_type = intersight_vmedia_policy.enabled.object_type
  }

  policy_bucket { # Storage
    moid        = intersight_storage_storage_policy.m2_raid.moid
    object_type = intersight_storage_storage_policy.m2_raid.object_type
  }

  policy_bucket { # LAN Connectivity
    moid        = intersight_vnic_lan_connectivity_policy.ai-toolkit.moid
    object_type = intersight_vnic_lan_connectivity_policy.ai-toolkit.object_type
  }
}
