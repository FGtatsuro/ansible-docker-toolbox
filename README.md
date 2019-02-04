[![Build Status](https://travis-ci.org/FGtatsuro/ansible-docker-toolbox.svg?branch=master)](https://travis-ci.org/FGtatsuro/ansible-docker-toolbox)

ansible-docker-toolbox
====================================

Ansible role for Docker Toolbox.

Requirements
------------

The dependencies on other softwares/librarys for this role.

- Debian/Ubuntu
- OSX
  - Homebrew (>= 0.9.5)

Role Variables
--------------

The variables we can use in this role.

### Only Linux

These variables are valid only on Debian/Ubuntu, and they aren't used on OSX.

|name|description|type|default|
|---|---|---|---|
|docker_installscript_tmppath|Temporary path for downloaded script to install Docker Engine.|str|/tmp/docker_install.sh|
|docker_install_machine|Whether Docker Machine is installed. This value isn't valid on OSX.|bool|no|
|docker_machine_download_url|Download URL for Docker Machine binary. Different architecture/version has different URL.|str|https://github.com/docker/machine/releases/download/v0.6.0/docker-machine-Linux-x86_64|
|docker_machine_sha256|SHA256 signature of Docker Machine binary. This is used for idempotency.|str|6c383c4716985db2d7ae7e1689cc4acee0b23284e6e852d6bc59011696ca734a|
|docker_machine_bin_path|Path Docker Machine binary is put.|str|/usr/local/bin/docker-machine|
|docker_install_compose|Whether Docker Compose is installed. This value isn't valid on OSX.|bool|no|
|docker_compose_download_url|Download URL for Docker Compose binary. Different architecture/version has different URL.|str|https://github.com/docker/compose/releases/download/1.6.2/docker-compose-Linux-x86_64|
|docker_compose_sha256|SHA256 signature of Docker Compose binary. This is used for idempotency.|str|7c453a3e52fb97bba34cf404f7f7e7913c86e2322d612e00c71bd1588587c91e|
|docker_compose_bin_path|Path Docker Compose binary is put.|str|/usr/local/bin/docker-compose|
|docker_daemon_options|Options Docker daemon uses. It's defined as string like `-g /mnt/docker --insecure-registry 192.168.1.1:5000`.|str|It isn't defined in default.|
|docker_group_append_user|**This variable is deprecated! Please use `docker_group_append_users`**<br><br> Append 'docker' group to specified user's groups. The user can exec 'docker' command without root privilege.|str|It isn't defined in default.|
|docker_group_append_users|Append 'docker' group to specified multiple users' groups. The users can exec 'docker' command without root privilege.|list|It isn't defined in default.|

- If you want to overwrite values, please check following sites.
  - https://github.com/docker/machine/releases
  - https://github.com/docker/compose/releases

### Only OSX

These variables are valid only on OSX, and they aren't used on Debian/Ubuntu.

|name|description|default|
|---|---|---|
|docker_install_native_client|Whether native client on OSX(Docker for Mac) is installed instead of Docker ToolBox.|no|

Role Dependencies
-----------------

The dependencies on other roles for this role.

- FGtatsuro.python-requirements

Example Playbook
----------------

    - hosts: all
      roles:
         - { role: FGtatsuro.docker_toolbox }

Test on local Docker host
-------------------------

This project run tests on Travis CI, but we can also run then on local Docker host.
Please check `install`, `before_script`, and `script` sections of `.travis.yml`.
We can use same steps of them for local Docker host.

Local requirements are as follows.

- Ansible (>= 2.0.0)
- Docker (>= 1.10.1)

Test on Vagrant VM
------------------

To confirm the behavior of Docker daemon, we run tests on Vagrant VM.

```bash
$ vagrant up

# Debian
$ ansible-playbook tests/test.yml -i tests/inventory -l vagrant_debian --extra-vars="docker_daemon_options='-H fd:// --insecure-registry 192.168.1.1:5000 --insecure-registry 192.168.1.2:5000'"
$ bundle exec rake spec SPEC_TARGET=vagrant_debian

# Ubuntu
$ ansible-playbook tests/test.yml -i tests/inventory -l vagrant_ubuntu --extra-vars="docker_daemon_options='-H fd:// --insecure-registry 192.168.1.1:5000 --insecure-registry 192.168.1.2:5000'"
$ bundle exec rake spec SPEC_TARGET=vagrant_ubuntu

# CentOS
$ ansible-playbook tests/test.yml -i tests/inventory -l vagrant_centos --extra-vars="docker_daemon_options='-H fd:// --insecure-registry 192.168.1.1:5000 --insecure-registry 192.168.1.2:5000'"
$ bundle exec rake spec SPEC_TARGET=vagrant_centos
```

Notes
-----

- On Debian, [Kitematic](https://kitematic.com/) isn't installed.
- On OSX, this role just does installation. To use Docker daemon and related tools. additional steps are needed.
  - If you install Docker Toolbox(`docker_install_native_client`=no), you must create Docker environment with Docker Machine. (ex. https://docs.docker.com/machine/get-started/)
  - If you install Docker for Mac(`docker_install_native_client`=yes), you must run /Applications/Docker.app manually and complete setup.
- If you use `docker_daemon_options` variable, You must restart Docker daemon to adapt your options.
  - Ref. https://docs.docker.com/engine/admin/configuring/

License
-------

MIT
