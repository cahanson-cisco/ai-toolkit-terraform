resource "intersight_bios_policy" "ai-toolkit" {
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

  intel_vt_for_directed_io    = "disabled"
  cpu_perf_enhancement        = "Auto"
  processor_c1e               = "enabled"
  processor_c6report          = "enabled"
  energy_efficient_turbo      = "enabled"
  work_load_config            = "Balanced"
  cisco_adaptive_mem_training = "enabled"
  lom_ports_all_state         = "disabled"
}
