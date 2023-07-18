#!/bin/sh

set -euo pipefail

DATE=$(date +"%Y%m%d%H%M")
snakemake --profile ../sb-slurm/ &> log_${DATE}.out
