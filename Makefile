## ----------------------------------------------------------------------------
## Makefile for running the Time Series Benchmark Suite (TSBS) on various
## databases using Docker Compose.
## ----------------------------------------------------------------------------

ROOT_DIR := $(shell pwd)
COMPOSE := $(ROOT_DIR)/compose.sh

#ALL := akumuli cassandra clickhouse cratedb influx mongo questdb siridb timescaledb
ALL := akumuli cratedb influx siridb timescaledb

.PHONY: help
help:                 ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

.PHONY: benchmark
benchmark:            ## Run the benchmark for all databases
benchmark: $(addsuffix -benchmark, $(ALL))

.PHONY: clean         
clean:                ## Clean all data, queries, results, logs
clean: clean-data clean-queries clean-results clean-logs

.PHONY: clean-data
clean-data:           ## Clean all data directories
	rm -rf */data

.PHONY: clean-queries
clean-queries:        ## Clean all query directories
	rm -rf */queries

.PHONY: clean-results
clean-results:        ## Clean all result directories
	rm -rf */results

.PHONY: clean-logs
clean-logs:           ## Clean all log directories
	rm -rf */logs

.PHONY: clean-volumes
clean-volumes:        ## Clean all Docker volumes
clean-volumes: $(addsuffix -clean-volume, $(ALL))

.PHONY: tsbs
tsbs: 	              ## Build the TSBS binary
	$(MAKE) -C tsbs

.PHONY: up
up:                   ## Start all databases
	${COMPOSE} up -d

.PHONY: data
data:                 ## Generate data for all databases
data: $(addsuffix -data, $(ALL))

.PHONY: load-data
load-data:            ## Run the load data benchmark for all databases
load-data: $(addsuffix -load, $(ALL))

.PHONY: run-queries
run-queries:          ## Run the query benchmark for all databases
run-queries: $(addsuffix -run, $(ALL))

.PHONY: down
down:                 ## Stop all databases
	${COMPOSE} down

.PHONY: %-data
%-data:               ## Generate data for a specific database
	$(MAKE) -C $* data

%-load:               ## Load the data for a specific database
	$(MAKE) -C $* load-data

%-run:                ## Run the queries for a specific database
	$(MAKE) -C $* run-queries

%-benchmark:          ## Run the benchmark for a specific database
	$(MAKE) -C $* benchmark

%-clean-volume:       ## Clean the Docker volume for a specific database
	$(MAKE) -C $* clean-volume