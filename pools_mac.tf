resource "intersight_macpool_pool" "mac-failover" {
  name = "mac-failover"
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

  mac_blocks {
    from = "00:25:b5:a1:ff:01"
    size = 255
  }
  lifecycle {
    ignore_changes = [mac_blocks]
  }
}
