# terraform-digitalocean-vault

# 🚀 Terraform module for Vault deployment on Digitalocean 🚀

https://github.com/coding-to-music/terraform-digitalocean-vault

From / By https://github.com/brucellino/terraform-digitalocean-vault

## Digitalocean Droplet Prices

https://github.com/andrewsomething/do-api-slugs

https://slugs.do-api.dev

```
# https://slugs.do-api.dev/

# s-1vcpu-512mb-10gb  $4    10GB
# s-1vcpu-1gb         $6    25GB
# s-1vcpu-2gb         $12   50GB
# s-2vcpu-2gb         $18   60GB
# s-2vcpu-4gb         $24   80GB
# s-4vcpu-8gb         $48   160GB
```

## Environment variables:

```java

```

## user interfaces:

## GitHub

```java
git init
git add .
git remote remove origin
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:coding-to-music/terraform-digitalocean-vault.git
git push -u origin main
```

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit) [![pre-commit.ci status](https://results.pre-commit.ci/badge/github/brucellino/tfmod-template/main.svg)](https://results.pre-commit.ci/latest/github/brucellino/tfmod-template/main) [![semantic-release: conventional](https://img.shields.io/badge/semantic--release-conventional-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

# tfmod-template

<!-- Delete this section when using the template repository -->

This is the template repository for my terraform modules.
It attempts to follow the [default structure](https://www.terraform.io/language/modules/develop/structure) for terraform modules.

It is designed to speed up development of new terraform modules by providing:

1. basic terraform setup for backend, providers, _etc_.
1. the default required version for terraform is `>1.2.0`
1. common pre-commit hooks configuration
1. semantic release configuration
1. examples directory for testing and demonstration
1. default github actions workflows for testing and releasing

## How to use

<!-- Delete this section when using the template repository -->

If you want to make a new terraform module from scratch:

1. create a new repository using this one as template
1. delete the sections commented with `<!-- Delete this section when using the template repository -->`
1. update `terraform.tf` to declare the module's required providers
1. add the examples you need in `examples/<your example>`
1. update the test workflow in `.github/workflows/test.yml` to reflect your examples

## Pre-commit hooks

<!-- Edit this section or delete if you make no change  -->

The [pre-commit](https://pre-commit.com) framework is used to manage pre-commit hooks for this repository.
A few well-known hooks are provided to cover correctness, security and safety in terraform.

## Examples

The `examples/` directory contains the example usage of this module.
These examples show how to use the module in your project, and are also use for testing in CI/CD.

<!--

Modify this section according to the kinds of examples you want
You may want to change the names of the examples or the kinds of
examples themselves

-->

# How to Install and Configure doctl

https://docs.digitalocean.com/reference/doctl/how-to/install/

Validated on 15 Apr 2020 • Posted on 15 Apr 2020

Step 1: Install doctl

Install doctl following the directions for your package manager or operating system:

- Homebrew (macOS)
- Snap Package (Ubuntu)
- GitHub Download (Linux, macOS)
- GitHub Download (Windows)

To install the latest version of doctl using Snap on Ubuntu or other supported operating systems, run:

```
sudo snap install doctl
```

For security purposes, Snaps run in complete isolation and need to be granted permission to interact with your system’s resources. Some doctl commands require additional permissions:

Using doctl’s integration with kubectl requires the kube-config personal-files interface. To enable it, run:

```
sudo snap connect doctl:kube-config
```

Using doctl compute ssh requires the core ssh-keys interface. To enable it, run:

```
sudo snap connect doctl:ssh-keys :ssh-keys
```

Using doctl registry login requires the dot-docker personal-files interface. To enable it, run:

```
sudo snap connect doctl:dot-docker
```

Step 2: Create an API token
Create a DigitalOcean API token for your account with read and write access from the Applications & API page in the control panel. The token string is only displayed once, so save it in a safe place.

Step 3: Use the API token to grant account access to doctl

Note

- If you installed doctl using the Ubuntu Snap package, you may need to first create the user configuration directory if it does not exist yet by running mkdir ~/.config.
  Use the API token to grant doctl access to your DigitalOcean account. Pass in the token string when prompted by doctl auth init, and give this authentication context a name.

https://docs.digitalocean.com/reference/doctl/reference/auth/

```
doctl auth init --context <NAME>

# I used:

doctl auth init --access-token <goes here>
```

Output

```
Using token [dop_v1_here]

Validating token... OK
```

Authentication contexts let you switch between multiple authenticated accounts. You can repeat steps 2 and 3 to add other DigitalOcean accounts, then list and switch between authentication contexts:

```
doctl auth list
doctl auth switch --context <NAME>
```

Step 4: Validate that doctl is working
Now that doctl is authorized to use your account, try some test commands.

To confirm that you have successfully authorized doctl, review your account details by running:

```
doctl account get
```

If successful, the output will look like:

```
Email                      Droplet Limit    Email Verified    UUID                                        Status
sammy@example.org          10               true              3a56c5e109736b50e823eaebca85708ca0e5087c    active
```

To confirm that you have successfully granted write access to doctl, create an Ubuntu 18.04 Droplet in the SFO2 region by running:

```
doctl compute droplet create --region tor1 --image ubuntu-18-04-x64 --size s-1vcpu-1gb <DROPLET-NAME>
```

The output of that command will include an ID column with the new Droplet’s ID. For example:

```
ID           Name            Public IPv4    Private IPv4    Public IPv6    Memory    VCPUs    Disk    Region    Image                       Status    Tags    Features    Volumes
187949338    droplet-name                                                  1024      1        25      sfo2      Ubuntu 18.04.3 (LTS) x64    new
```

Use that value to delete the Droplet by running:

```
doctl compute droplet delete <DROPLET-ID>
```

When prompted, type y to confirm that you would like to delete the Droplet.

Step 5: Install Serverless Functions support (Optional)
To use doctl with our serverless Functions product, you must first install a software extension, then use it to connect to the development namespace.

To install the support for serverless Functions, run the serverless install subcommand:

```
doctl serverless install
```

This will download and install the extension, providing status updates along the way:

```
Downloading...Unpacking...Installing...Cleaning up...
Done
```

You are now ready to create a namespace and deploy your functions. See the Functions Quickstart to get started.

## Import existing Digitalocean resources into Terraform

https://www.koding.com/docs/terraform/providers/do/r/ssh_key.html/

https://www.digitalocean.com/community/tutorials/how-to-import-existing-digitalocean-assets-into-terraform#step-3-importing-your-assets-to-terraform

https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_key

```
doctl compute ssh-key list [flags]
```

```
ID          Name                                 FingerPrint
36253934    key_name-1                           56::8e:c0
31373390    key_name-1                           d7::04:71:6f:58
```

```
terraform import digitalocean_ssh_key.vault 36253934

terraform import digitalocean_ssh_key.vault 31373390
```

```
Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

## Domain records

https://docs.digitalocean.com/reference/doctl/reference/compute/domain/records/

doctl compute domain get

doctl compute domain records list

## Install and Upgrade Terraform

https://www.terraform.io/downloads

```
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
```

```
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```

```
sudo apt update && sudo apt install terraform
```

```
terraform -v
```

Output

```
Terraform v1.3.1
on linux_amd64
+ provider registry.terraform.io/digitalocean/digitalocean v2.21.0
+ provider registry.terraform.io/hashicorp/http v3.1.0
```
