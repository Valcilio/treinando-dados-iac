terraform {
  source = "git::git@github.com:Valcilio/terraform_blueprints.git//lambda_with_docker_and_url?ref=1.0"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  env      = local.env_vars.locals.environment

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region      = local.region_vars.locals.region

  account_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account      = local.region_vars.locals.region
}

inputs = {
  aws_region = local.region
  aws_account_id = local.account
}