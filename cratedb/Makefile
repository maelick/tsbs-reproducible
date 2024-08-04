ROOT_DIR := $(shell pwd)/../..
DB_NAME := $(shell basename $(shell pwd))
LOAD_OPTIONS := --port 5433
RUN_OPTIONS := --port 5433

CPU_ONLY_QUERIES := \
	single-groupby-1-1-1 single-groupby-1-1-12 single-groupby-1-8-1 \
	single-groupby-5-1-1 single-groupby-5-1-12 single-groupby-5-8-1 \
	double-groupby-1 double-groupby-5 double-groupby-all \
	high-cpu-1 lastpoint groupby-orderby-limit

DEVOPS_QUERIES := \
	single-groupby-1-1-1 single-groupby-1-1-12 single-groupby-1-8-1 \
	single-groupby-5-1-1 single-groupby-5-1-12 single-groupby-5-8-1 \
	double-groupby-1 double-groupby-5 double-groupby-all \
	high-cpu-1 lastpoint groupby-orderby-limit

include ../common.mk

.PHONY: wait-db
wait-db:
	@while ! docker exec -i tsbs-cratedb-1 curl -s http://localhost:4200; do \
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
