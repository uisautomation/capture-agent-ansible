# Capture Agent Configuration #

Ansible configuration management for Lecture Capture Captures Agents.

## From bare machine to configurable host ##

1. Use [uisautomation/lecture-capture-agent-bootstrap](https://github.com/uisautomation/lecture-capture-agent-bootstrap) to build a netboot installer image
2. Copy this to a bootable USB stick
3. Configure the PC's BIOS as described [here](https://github.com/uisautomation/lecture-capture-agent-bootstrap/#bios-configuration)
4. Insert the USB stick, power on and press `F12` (boot menu)
5. Choose the USB stick - installation of lubuntu 18.04 will start
6. When finished, the PC will power off
7. Remove the USB stick and boot the PC
8. The PC will automatically login as the `galicaster` user
9. Take a note of the PC's IP address

## Configuring a host ##

### Agent deployment keys ###

Hosts are configured so that login as root is by means of a deploy key.
The canonical source for the deploy key is the DevOps secret store.
You must have the deploy key available to your local SSH agent before you can
log into the box or run the playbook. To add the deploy key to your local SSH
agent:

```bash
$ cd ~/repos/devops/docs/secrets  # location of secrets store clone
$ alias vault="ansible-vault --vault-password-file=$PWD/open-vault"

# Decrypt deploy key
$ vault view lecture-capture-deploy-main > ~/.ssh/lecture-capture-deploy-main
$ chmod 0600 ~/.ssh/lecture-capture-deploy-main

# Copy passphrase to clipboard
$ vault view lecture-capture-deploy.passphrase | xclip -i -sel clip

# Add key to ssh-agent
$ ssh-add ~/.ssh/lecture-capture-deploy-main
```

### Updating hosts file ###

To be able to specify the host when running the ansible playbook it needs adding to the appropriate hosts file for the environment (prod-hosts, test-hosts or dev-hosts). It needs to be added in the section relevant to the video/audio hardware in the device.

Copy a commented example in the hosts file, changing the IP address to that of the desired host. The hostname doesn't matter but needs to be unique and is specified when running the playbook.
```
[capture-agents-v4l2-split]
uis-capture-agent-42 ansible_host=172.24.234.123 ansible_ssh_port=22
```
### Running ansible playbook ###

The ``run-ansible-playbook.sh`` wrapper script pulls a Docker image with the correct version of Ansible and uses it to run the playbook. Invoke it
via the following, specifying the appropriate hosts file and hostname:

```bash
$ ./run-ansible-playbook.sh capture-agent.yml -i dev-hosts uis-capture-agent-42
```

> NOTE: the ``run-ansible-playbook.sh`` wrapper will attempt to decrypt the
> vault password in ``secrets/password.asc`` using GPG. If your GPG key is not
> one of those able to decrypt this file, you cannot run the playbook.

This will configure the PC to launch galicaster on boot.

## Secrets

Secrets have been encrypted using Ansible vault. The following alias will give
you a ``vault`` alias which can decrypt/encrypt vault variables.

```bash
$ cd ~/path/to/this/repo
$ alias vault="ansible-vault --vault-password-file=$PWD/secrets/open-vault"
```

You can check that you can decrypt secrets by decrypting the test secret:

```bash
$ vault view secrets/test-secret.txt
```

The vault password is GPG encrypted with the team's keys and was generated via:

```bash
$ pwgen -1 64 | gpg --encrypt --recipient automation@uis.cam.ac.uk --armor
```
