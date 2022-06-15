#!/usr/bin/env bash
yq eval-all '. as $item ireduce ({}; . * $item )' ./workflows/_base.yml ./workflows/systems/*.yml
