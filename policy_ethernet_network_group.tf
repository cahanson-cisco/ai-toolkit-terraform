resource "intersight_fabric_eth_network_group_policy" "ai-toolkit" {
  name = "ai-toolkit"
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

  vlan_settings {
    native_vlan   = var.os_vlan
    allowed_vlans = var.os_vlan
  }
}
