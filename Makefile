CURRENT_DIR := $(shell pwd)

.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: carbon
carbon: ## create images from carbon snippets
	carbon-now $(CURRENT_DIR)/carbon-snippets/* --save-to $(CURRENT_DIR)/img/ --config $(CURRENT_DIR)/carbon-now-preset.json -p deep-space
