locals {
  tags = {
    Automation = "Terraform"
    Project    = "AI-TOOLKIT"
    Repo       = "https://github.com/cahanson-cisco/ai-toolkit-terraform"
  }
  organization = data.intersight_organization_organization.default.results[0].moid
}
