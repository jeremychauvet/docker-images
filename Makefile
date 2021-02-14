.PHONY: validate buid build-terraform
TERRAFORM_VERSION=0.14.6

validate:
	pre-commit run --all-files

build: build-terraform

build-terraform:
	docker image build --build-arg TERRAFORM_VERSION="$(TERRAFORM_VERSION)" -t ghcr.io/jeremychauvet/terraform:$(TERRAFORM_VERSION) -f terraform/Dockerfile .
