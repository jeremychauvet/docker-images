FROM ghcr.io/jeremychauvet/ubuntu:20.04

LABEL org.opencontainers.image.source https://github.com/jeremychauvet/docker-images
LABEL org.opencontainers.image.authors Jeremy Chauvet

USER root

# Install Ansible.
RUN apt-add-repository --yes --update ppa:ansible/ansible
RUN apt-get update
RUN apt-get install ansible -y
