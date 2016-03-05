[![Build Status](https://travis-ci.org/FGtatsuro/ansible-docker-toolbox.svg?branch=master)](https://travis-ci.org/FGtatsuro/ansible-docker-toolbox)

ansible-docker-toolbox
====================================

Ansible role for Docker Toolbox.

Requirements
------------

The dependencies on other softwares/librarys for this role.

- Debian
- OSX
  - Homebrew (>= 0.9.5)

Role Variables
--------------

The variables we can use in this role.

- docker_installscript_tmppath: Tmporary path for downloaded script to install Docker Engine.
  - default="/tmp/docker_install.sh"
- docker_machine_download_url: Download URL for Docker Machine binary. Different architecture/version has different URL.
  - default="https://github.com/docker/machine/releases/download/v0.6.0/docker-machine-Linux-x86_64"
- docker_machine_sha256: SHA256 signature of Docker Machine binary. This is used for idempotency.
  - default="6c383c4716985db2d7ae7e1689cc4acee0b23284e6e852d6bc59011696ca734a"
- docker_machine_bin_path: Path Docker Machine binary is put.
  - default="/usr/local/bin/docker-machine"
- docker_compose_download_url: Download URL for Docker Compose binary. Different architecture/version has different URL.
  - default="https://github.com/docker/compose/releases/download/1.6.2/docker-compose-Linux-x86_64"
- docker_compose_sha256: SHA256 signature of Docker Compose binary. This is used for idempotency.
  - default="7c453a3e52fb97bba34cf404f7f7e7913c86e2322d612e00c71bd1588587c91e"
- docker_compose_bin_path: Path Docker Compose binary is put.
  - default="/usr/local/bin/docker-compose"

- These variables are valid only on Debian, and they aren't used in OSX.
- If you want to overwrite values, please check following sites.
  - https://github.com/docker/machine/releases
  - https://github.com/docker/compose/releases

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

License
-------

MIT
