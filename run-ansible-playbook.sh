#!/usr/bin/env bash
#
# Wrapper script which runs correct version of Ansible for this repository.
# Forwards the user's ssh agent into the container so that Ansible can log into
# the machines it needs to.
#
# The script will fail to run if it cannot decrypt the vault passowrd or if the
# user has not got an SSH agent running.

# Exit on error
set -e

# Get the directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Use the open vault script to get the repository password.
export VAULT_PASSWORD=$(${DIR}/secrets/open-vault)

# Check that the vault passowrd was decrypted.
if [ -z "${VAULT_PASSWORD}" ]; then
  echo "$0: could not decrypt vault password" >&2
  exit 1
fi

# Check that a SSH agent is configures
if [ -z "${SSH_AUTH_SOCK}" ]; then
  echo "$0: ssh agent not running" >&2
  exit 1
fi

exec docker run \
  -t --rm \
  -e VAULT_PASSWORD \
  -v ${SSH_AUTH_SOCK}:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent \
  -v $PWD:/workspace:ro \
  uisautomation/ansible-playbook:2.7 \
  "$@"
