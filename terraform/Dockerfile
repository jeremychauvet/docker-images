FROM ghcr.io/jeremychauvet/ubuntu:20.04

ARG TERRAFORM_VERSION

LABEL org.opencontainers.image.source https://github.com/jeremychauvet/docker-images
LABEL org.opencontainers.image.authors Jeremy Chauvet

# Install Terraform
USER root
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip --no-check-certificate -O terraform.zip && \
unzip terraform.zip && \
mv terraform /usr/local/bin && \
rm terraform.zip && \
apt-get clean && rm -rf /var/lib/apt/lists/*
USER vhugo
