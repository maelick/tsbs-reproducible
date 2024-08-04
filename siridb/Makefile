ROOT_DIR := $(shell pwd)/../..
DB_NAME := $(shell basename $(shell pwd))
LOAD_OPTIONS := --hosts localhost:9002
RUN_OPTIONS := --hosts localhost:9002

include ../common.mk

.PHONY: wait-db
wait-db:
	@while ! nc -z localhost 9002; do \
		echo "Waiting for ${DB_NAME} to be ready..."; \
		sleep 1; \
	done
	@echo "${DB_NAME} is ready!"

.PHONY: data
data: data/cpu-only.gz data/devops.gz

.PHONY: load-data
load-data: load-cpu-only load-devops

.PHONY: run-queries
run-queries: run-cpu-only run-devops
