FROM ghcr.io/jeremychauvet/ubuntu:20.04

ARG TERRAFORM_VERSION

LABEL org.opencontainers.image.source https://github.com/jeremychauvet/docker-images
LABEL org.opencontainers.image.authors Jeremy Chauvet

# Install Terraform.
USER root
RUN curl -Lo ./terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
unzip terraform.zip && \
mv terraform /usr/local/bin && \
rm terraform.zip && \
apt-get clean && rm -rf /var/lib/apt/lists/*

# Install tflint.
RUN curl https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

# Install terraform-docs.
RUN curl -Lo ./terraform-docs.tar.gz "https://github.com/terraform-docs/terraform-docs/releases/download/v0.11.2/terraform-docs-v0.11.2-$(uname)-amd64.tar.gz" && \
tar -xzf terraform-docs.tar.gz && \
chmod +x terraform-docs && \
mv terraform-docs /home/vhugo/bin/terraform-docs

# Install checkov.
RUN python3 -m pip --no-cache-dir install -U checkov==1.0.831

USER vhugo
