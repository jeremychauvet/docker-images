FROM public.ecr.aws/ubuntu/ubuntu:20.04

ARG TERRAFORM_VERSION

LABEL org.opencontainers.image.source https://github.com/jeremychauvet/docker-images
LABEL org.opencontainers.image.authors Jeremy Chauvet

# Install Terraform
RUN apt-get update && \
apt-get install --no-install-recommends wget=1.20.3-1ubuntu1 unzip=6.0-25ubuntu1 -y && \
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip --no-check-certificate -O terraform.zip && \
unzip terraform.zip && \
mv terraform /usr/local/bin && \
rm terraform.zip && \
apt-get clean && rm -rf /var/lib/apt/lists/*

# Create user "Victor Hugo" for rootless purpose.
RUN useradd --create-home vhugo
WORKDIR /home/vhugo
USER vhugo
