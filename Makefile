.PHONY: validate

validate:
	pre-commit run --all-files
