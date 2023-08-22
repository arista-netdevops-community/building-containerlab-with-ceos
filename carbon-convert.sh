#!/usr/bin/env bash

set +e

cd carbon-snippets
for filename in *; do
    carbon-now ${filename} --save-to ../img/ --save-as ${filename}  --config ../carbon-config.json -p deep-space;
done
