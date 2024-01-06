include "root" {
  path = find_in_parent_folders()
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env      = local.env_vars.locals.environment

  name = "zomato-lambda-predict"
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/ecr.hcl"
}

inputs = {
  name       = "ecr-${local.env}-${local.name}"
  mutability = "MUTABLE"
}