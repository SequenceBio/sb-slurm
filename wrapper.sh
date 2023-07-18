#!/bin/sh

set -euo pipefail

DATE=$(date +"%Y%m%d%H%M")
snakemake --profile path/to/profile &> log_${DATE}.out
