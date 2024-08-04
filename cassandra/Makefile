ROOT_DIR := $(shell pwd)/../..
DB_NAME := $(shell basename $(shell pwd))

include ../common.mk

.PHONY: wait-db
wait-db:
	@while ! docker exec -i tsbs-cassandra-1 cqlsh -e "DESCRIBE KEYSPACES" 2>/dev/null; do \
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