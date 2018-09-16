SHELL = /bin/bash
MAKEFLAGS = "-s"
.DEFAULT_GOAL := build

REPOSITORY = gregoryguillou/eks-kubectl
VERSION := $(shell cat VERSION)
DOCKER = docker

clean:
	@$(DOCKER) rmi $(REPOSITORY):$(VERSION)

build:
	@$(DOCKER) build -t $(REPOSITORY):$(VERSION) .

.PHONY: build clean

