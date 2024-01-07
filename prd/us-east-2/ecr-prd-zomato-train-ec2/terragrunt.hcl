include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/ecr.hcl"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  env      = local.env_vars.locals.environment

  name = "zomato-train-ec2"
}

inputs = {
  name         = "ecr-${local.env}-${local.name}"
  mutability   = "MUTABLE"
  force_delete = true
}