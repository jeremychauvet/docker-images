DOCKER_TEST_IMAGE=gcr.io/gcp-runtimes/container-structure-test:v1.10.0

# Generics steps.
.PHONY: validate build test lint publish

validate:
	pre-commit run --all-files

build: build-ubuntu build-terraform
test: test-terraform
lint: lint-terraform
publish: publish-ubuntu publish-terraform

# Services steps.

## Ubuntu.
.PHONY: build-ubuntu lint-ubuntu test-ubuntu publish-ubuntu

UBUNTU_IMAGE_NAME=ghcr.io/jeremychauvet/ubuntu:20.04

build-ubuntu:
	docker build -t $(UBUNTU_IMAGE_NAME) -f ubuntu/Dockerfile .

lint-ubuntu:
	@echo "[INFO] Starting Dockerfile linting step."
	docker run --rm -i hadolint/hadolint:v1.22.1 < ubuntu/Dockerfile
	@echo "[INFO] Dockerfile linting success."

test-ubuntu:
	@echo "[INFO] Running UT tests on containers."
	docker container run --rm -i -v ${PWD}/ubuntu/tests/container-structure-tests.yml:/tests.yml:ro -v /var/run/docker.sock:/var/run/docker.sock:ro $(DOCKER_TEST_IMAGE) test --image $(UBUNTU_IMAGE_NAME) --config /tests.yml
	@echo "[INFO] UT tests success."

publish-ubuntu:
	docker push $(UBUNTU_IMAGE_NAME)

## Terraform.
.PHONY: build-terraform lint-terraform test-terraform publish-terraform

TERRAFORM_VERSION=1.0.2
TERRAFORM_IMAGE_NAME=ghcr.io/jeremychauvet/terraform:$(TERRAFORM_VERSION)

build-terraform:
	docker build --cache-from $(UBUNTU_IMAGE_NAME) --build-arg TERRAFORM_VERSION=$(TERRAFORM_VERSION) -t $(TERRAFORM_IMAGE_NAME) -f terraform/Dockerfile .

lint-terraform:
	@echo "[INFO] Starting Dockerfile linting step."
	docker run --rm -i hadolint/hadolint:v1.22.1 < terraform/Dockerfile
	@echo "[INFO] Dockerfile linting success."

test-terraform:
	@echo "[INFO] Running UT tests on containers."
	docker container run --rm -i -v ${PWD}/terraform/tests/container-structure-tests.yml:/tests.yml:ro -v /var/run/docker.sock:/var/run/docker.sock:ro $(DOCKER_TEST_IMAGE) test --image $(TERRAFORM_IMAGE_NAME) --config /tests.yml
	@echo "[INFO] UT tests success."

publish-terraform:
	docker push $(TERRAFORM_IMAGE_NAME)

## NodeJS.
.PHONY: build-nodejs lint-nodejs publish-nodejs

NODEJS_VERSION=14
NODEJS_IMAGE_NAME=ghcr.io/jeremychauvet/nodejs:$(NODEJS_VERSION)

build-nodejs:
	docker build --cache-from $(UBUNTU_IMAGE_NAME) --build-arg NODEJS_VERSION=$(NODEJS_VERSION) -t $(NODEJS_IMAGE_NAME) -f nodejs/Dockerfile .

lint-nodejs:
	@echo "[INFO] Starting Dockerfile linting step."
	docker run --rm -i hadolint/hadolint:v1.22.1 < nodejs/Dockerfile
	@echo "[INFO] Dockerfile linting success."

test-nodejs:
	@echo "[INFO] Running UT tests on containers."
	docker container run --rm -i -v ${PWD}/nodejs/tests/container-structure-tests.yml:/tests.yml:ro -v /var/run/docker.sock:/var/run/docker.sock:ro $(DOCKER_TEST_IMAGE) test --image $(NODEJS_IMAGE_NAME) --config /tests.yml
	@echo "[INFO] UT tests success."

publish-nodejs:
	docker push $(NODEJS_IMAGE_NAME)

## Ansible.
.PHONY: build-ansible lint-ansible publish-ansible

ANSIBLE_IMAGE_NAME=ghcr.io/jeremychauvet/ansible:latest

build-ansible:
	docker build --cache-from $(UBUNTU_IMAGE_NAME) -t $(ANSIBLE_IMAGE_NAME) -f ansible/Dockerfile .

lint-ansible:
	@echo "[INFO] Starting Dockerfile linting step."
	docker run --rm -i hadolint/hadolint:v1.22.1 < ansible/Dockerfile
	@echo "[INFO] Dockerfile linting success."

publish-ansible:
	docker push $(ANSIBLE_IMAGE_NAME)
