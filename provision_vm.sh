#!/usr/bin/env bash
set +e

# this script can be used to provision Vagrant VM

CEOS_IMAGE="add-your-image-here.tar.gz"

# install docker
curl -fsSL https://get.docker.com | sh
# add user to the docker group
sudo usermod -aG docker vagrant
# import docker image that must be downloaded from arista.com in advance
docker import /home/vagrant/gitignored_files/$CEOS_IMAGE ceos-lab:latest
# copy all files to VM native file system to avoid cLab permission issues
cd /vagrant/; for directory in demo*; do mkdir /home/vagrant/$directory; cp -Rp $directory/. /home/vagrant/$directory; done