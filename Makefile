ROOT_DIR := $(shell pwd)/..
SCRIPT_DIR := $(ROOT_DIR)/scripts
COMPOSE := $(SCRIPT_DIR)/compose.sh

#ALL := akumuli cassandra clickhouse cratedb influx mongo questdb siridb timescaledb
ALL := akumuli cratedb influx siridb timescaledb

.PHONY: benchmark
benchmark: $(addsuffix -benchmark, $(ALL))

.PHONY: clean
clean: clean-data clean-queries clean-results clean-logs clean-volume

.PHONY: clean-data
clean-data:
	rm -rf */data

.PHONY: clean-queries
clean-queries:
	rm -rf */queries

.PHONY: clean-results
clean-results:
	rm -rf */results

.PHONY: clean-logs
clean-logs:
	rm -rf */logs

.PHONY: clean-volume
clean-volume: $(addsuffix -clean-volume, $(ALL))

.PHONY: up
up:
	${COMPOSE} up -d

.PHONY: data
data: $(addsuffix -data, $(ALL))

.PHONY: load-data
load-data: $(addsuffix -load, $(ALL))

.PHONY: run-queries
run-queries: $(addsuffix -run, $(ALL))

.PHONY: down
down:
	${COMPOSE} down

.PHONY: %-data
%-data:
	$(MAKE) -C $* data

%-load:
	$(MAKE) -C $* load-data

%-run:
	$(MAKE) -C $* run-queries

%-benchmark:
	$(MAKE) -C $* benchmark

%-clean-volume:
	$(MAKE) -C $* clean-volume