.DEFAULT_GOAL := shell


CONTAINER_CMD = podman
CONTAINER_NAME = portablegl

FILES_TO_MOUNT = -v ./entrypoint/entrypoint.sh:/entrypoint.sh:Z \
		 -v ./entrypoint/format.sh:/usr/local/bin/format.sh:Z \
		$(DNF_CACHE_TO_MOUNT)

USE_X = -e DISPLAY=$(DISPLAY) \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	--security-opt label=type:container_runtime_t
WAYLAND_FLAGS_FOR_CONTAINER = -e "WAYLAND_DISPLAY=${WAYLAND_DISPLAY}" \
                              -e "XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR}" \
                              -v "${XDG_RUNTIME_DIR}:${XDG_RUNTIME_DIR}"



.PHONY: all
all: image ## Build the image

.PHONY: image
image: ## Build a podman image in which to build the book
	# build the container
	$(CONTAINER_CMD) build  \
                         -t $(CONTAINER_NAME) \
                         $(PACKAGE_CACHE) \
                         .


.PHONY: shell
shell: ## Get Shell into a ephermeral container made from the image
	$(CONTAINER_CMD) run -it --rm \
		--entrypoint /bin/bash \
		$(FILES_TO_MOUNT) \
		$(USE_X) \
		$(WAYLAND_FLAGS_FOR_CONTAINER) \
		$(CONTAINER_NAME) \
		/usr/local/bin/shell.sh


.PHONY: help
help:
	@grep --extended-regexp '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
