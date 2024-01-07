# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
  account_name   = "production"
  aws_account_id = "959455567195" # TODO: replace me with your AWS account ID!
  aws_profile    = "prd"
  environment    = "prd"
}