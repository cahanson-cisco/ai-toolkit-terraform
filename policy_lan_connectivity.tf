resource "intersight_vnic_lan_connectivity_policy" "ai-toolkit" {
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

  placement_mode  = "custom"
  target_platform = "FIAttached"
}

resource "intersight_vnic_eth_if" "eth-failover" {
  name = "eth-failover"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  order            = 0
  mac_address_type = "POOL"
  failover_enabled = "true"


  mac_pool {
    moid = intersight_macpool_pool.mac-failover.moid
  }

  placement {
    switch_id = "A"
    id        = "MLOM"
  }

  cdn {
    nr_source = "vnic"
  }

  fabric_eth_network_group_policy {
    moid = intersight_fabric_eth_network_group_policy.ai-toolkit.moid
  }

  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.ai-toolkit.moid
  }

  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.default["be"].moid
  }

  lifecycle {
    ignore_changes = [cdn]
  }

  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.ai-toolkit.moid
  }
}
