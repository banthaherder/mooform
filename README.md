# Generic Ansible playbook to plan, apply, and execute Terraform
This playbook enables the dynamic configuration and execution of Terraform to infrastructure up and down on demand.

# Setup
As-is the Terraform module in 2.5+ can be fickle. I've included a patched version of the module based off the version included in Ansible 2.7. This patch fixes plan stdout and command values as well as stabilizes plan file path checking. 

The base project configuration is defined within the `tf_config.yml`. This file can be used to set every value of the Terraform module. Overrides can be done during runtime by passing `--e var_to_override=test`, this would be useful within a Jenkins pipeline where a conditional could be met to decide which plan file to execute.

# Running the playbook
This playbook is intended to be highly dynamic and be executed from within a Jenkins pipeline. Actions are taken using ansible tags. The tags directly set the state of the Terraform module ("plan" => "planned, "apply" => "present", "destroy" => "absent"). They can be stacked to perform multiple actions within in single playbook run (e.g. `--tags=plan,apply`). 

A few examples:
- Plan: `ansible-playbook terraform-playbook.yml --tags=plan`
- Plan, apply, and destroy: `ansible-playbook terraform-playbook.yml --tags=plan,apply,destroy`
- Plan and override terraform variable: `ansible-playbook terraform-playbook.yml --tags=plan,apply,destroy --e 'terraform_vars={"test":"test"}'`

