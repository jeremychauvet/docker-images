FROM public.ecr.aws/ubuntu/ubuntu:20.04

LABEL org.opencontainers.image.source https://github.com/jeremychauvet/docker-images
LABEL org.opencontainers.image.authors Jeremy Chauvet

# Install Terraform
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && \
  apt-get install --no-install-recommends software-properties-common make ssh git wget=1.20.3-1ubuntu1 unzip=6.0-25ubuntu1 python3-pip -y && \
  pip3 install pre-commit && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Create user "Victor Hugo" for rootless purpose.
RUN useradd --create-home vhugo
WORKDIR /home/vhugo
USER vhugo
