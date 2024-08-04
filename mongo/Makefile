ROOT_DIR := $(shell pwd)/../..
DB_NAME := $(shell basename $(shell pwd))
LOAD_OPTIONS := --url "mongodb://mongo:mongo@127.0.0.1:27017"
#LOAD_OPTIONS := --url "mongodb://mongo:mongo@127.0.0.1:27017/?directConnection=true"
RUN_OPTIONS := --url "mongodb://mongo:mongo@127.0.0.1:27017"
#RUN_OPTIONS := --url "mongodb://mongo:mongo@127.0.0.1:27017/?directConnection=true"

include ../common.mk

.PHONY: wait-db
wait-db:
	@while ! docker exec -i tsbs-mongo-1 mongosh --eval "db.adminCommand('ping')" 2>/dev/null; do \
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