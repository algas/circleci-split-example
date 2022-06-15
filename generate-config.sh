#!/usr/bin/env bash
yq eval-all '. as $item ireduce ({}; . * $item )' ./workflows/*.yml
