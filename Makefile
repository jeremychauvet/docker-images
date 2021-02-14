DOCKER_TEST_IMAGE=gcr.io/gcp-runtimes/container-structure-test:v1.10.0

# Generics steps.
.PHONY: validate build

validate:
	pre-commit run --all-files

build: build-terraform

test: test-terraform

# Services steps.

## Terraform.
.PHONY: build-terraform

TERRAFORM_VERSION=0.14.6
TERRAFORM_IMAGE_NAME=ghcr.io/jeremychauvet/terraform:$(TERRAFORM_VERSION)

build-terraform:
	docker image build --build-arg TERRAFORM_VERSION="$(TERRAFORM_VERSION)" -t $(TERRAFORM_IMAGE_NAME) -f terraform/Dockerfile .

test-terraform:
	@echo "[INFO] Starting Dockerfile linting step."
	docker run --rm -i hadolint/hadolint:v1.22.1 < terraform/Dockerfile
	@echo "[SUCCESS] Dockerfile linting success."
	@echo "[INFO] Running UT tests on containers."
	docker container run --rm -it -v ${PWD}/terraform/tests/container-structure-tests.yml:/tests.yml:ro -v /var/run/docker.sock:/var/run/docker.sock:ro $(DOCKER_TEST_IMAGE) test --image $(TERRAFORM_IMAGE_NAME) --config /tests.yml
	@echo "[SUCCESS] UT tests success."
