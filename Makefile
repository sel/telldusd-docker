CONTAINER_NAME ?= telldusd
CONTAINER_REPO ?= $(DOCKER_ID)/$(CONTAINER_NAME)
CONTAINER_TAG ?= latest
DOCKER_ID ?= slarkin

all: run

.PHONY: run
run: build kill
	docker run -d --restart unless-stopped --name $(CONTAINER_NAME) \
	  --privileged -v /dev/bus/usb:/dev/bus/usb \
	  -v $(PWD)/tellstick.conf:/etc/tellstick.conf:ro \
	  $(CONTAINER_REPO):$(CONTAINER_TAG)

.PHONY: build
build:
	docker build -t $(CONTAINER_REPO):$(CONTAINER_TAG) .

.PHONY: kill
kill:
	docker rm -f $(CONTAINER_NAME) || echo

.PHONY: upload
upload: build
	docker push $(CONTAINER_REPO):$(CONTAINER_TAG)

.PHONY: shell
shell:
	docker exec -it $(CONTAINER_NAME) bash
