ROOT_DIR := $(shell pwd)/../..
DB_NAME := $(shell basename $(shell pwd))
LOAD_OPTIONS := --endpoint=localhost:8282

CPU_ONLY_QUERIES := \
	single-groupby-1-1-1 single-groupby-1-1-12 single-groupby-1-8-1 \
	single-groupby-5-1-1 single-groupby-5-1-12 single-groupby-5-8-1 \
	double-groupby-1 double-groupby-5 double-groupby-all \
	high-cpu-all high-cpu-1 lastpoint

DEVOPS_QUERIES := \
	single-groupby-1-1-1 single-groupby-1-1-12 single-groupby-1-8-1 \
	single-groupby-5-1-1 single-groupby-5-1-12 single-groupby-5-8-1 \
	double-groupby-1 double-groupby-5 double-groupby-all \
	high-cpu-all high-cpu-1 lastpoint

include ../common.mk

.PHONY: wait-db
wait-db:
	@while ! curl -s http://localhost:8181/api/stats; do \
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
