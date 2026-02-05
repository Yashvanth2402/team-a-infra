# Terraform Infrastructure Repository

This repository manages Azure infrastructure using Terraform
with a multi-environment, module-based architecture.

## Environments
- dev
- test
- stage
- prod

## Structure
- modules/      : reusable Terraform modules
- environments/ : environment-specific configuration
- globals/      : shared naming & tagging standards
- ci/           : CI pipelines

## Workflow
- feature/* → dev → main
- All PRs run:
  - terraform validate
  - terraform plan
  - AI risk analysis

## State
Remote state stored in Azure Storage Account.
