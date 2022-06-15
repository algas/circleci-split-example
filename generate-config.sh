#!/usr/bin/env bash
ls -1 ./workflows/*.yml | sort | xargs yq eval-all '. as $item ireduce ({}; . * $item )'
