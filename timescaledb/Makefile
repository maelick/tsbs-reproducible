ROOT_DIR := $(shell pwd)/../..
DB_NAME := $(shell basename $(shell pwd))
LOAD_OPTIONS := --chunk-time 8h0m0s --field-index-count 1 --pass postgres
RUN_OPTIONS := --pass postgres

include ../common.mk

.PHONY: wait-db
wait-db:
	@while ! docker exec -i tsbs-timescaledb-1 psql -U postgres -d postgres -c "SELECT count(1)"; do \
		echo "Waiting for ${DB_NAME} to be ready..."; \
		sleep 1; \
	done
	@echo "${DB_NAME} is ready!"

.PHONY: data
data: data/cpu-only.gz data/devops.gz data/iot.gz

.PHONY: load-data
load-data: load-cpu-only load-devops load-iot

.PHONY: run-queries
run-queries: run-cpu-only run-devops run-iot