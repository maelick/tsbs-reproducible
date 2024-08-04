#!/bin/bash

script_dir="$(dirname $0)"
compose_dir="${script_dir}/../compose"
compose_file="${compose_dir}/compose.yaml"
docker compose -f "$compose_file" -p tsbs "$@"