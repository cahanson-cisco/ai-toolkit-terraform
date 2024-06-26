resource "intersight_vmedia_policy" "enabled" {
  name = "enabled"
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

  enabled       = true
  encryption    = true
  low_power_usb = true
}
