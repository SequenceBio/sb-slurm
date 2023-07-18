[![Snakemake](https://img.shields.io/badge/snakemake-≥7.0.0-brightgreen.svg)](https://snakemake.github.io)

# Snakemake Profile for Running on AWS ParallelCluster with the Slurm Scheduler

This is a [Snakemake](https://snakemake.github.io/) profile for running on [AWS ParallelCluster](https://docs.aws.amazon.com/parallelcluster) with the [Slurm](https://slurm.schedmd.com/documentation.html) scheduler.
It is heavily based on [John Blischak's smk-simple-slurm profile](https://github.com/jdblischak/smk-simple-slurm) and as such this repository uses the same license.

Default ParallelCluster Slurm installations have two peculiarities that make them differ from most other Slurm installations:
- The `--mem` argument to `sbatch` is not supported, and if used sends nodes into the `DRAINED` state.
- The `sacct` accounting system is not installed by default.

This profile accomodates these peculiarities.


## Usage

### Obtain the profile

Clone this repository to a convenient location on the head node
```
git clone https://github.com/SequenceBio/sb-slurm.git
```

### Edit the profile

The profile in this repository should be sufficient for many basic use cases at SB.  If needed, you can edit this profile by changing parameters in `config.yaml`.  For example, you may want to add `--rerun-incomplete` to the snakemake command, or you may want to adjust the default partition.

### Set up a wrapper script

Copy the script `wrapper.sh` from this repository into your pipeline directory.  Be sure that the path after `--profile` points back to this repository.

### Run your pipeline

Navigate into your pipeline directory.  Submit the wrapper script to the job scheduler
```
sbatch wrapper.sh
```

### Evaluate your pipeline run

Monitor your jobs with `squeue`.  To continually refresh `squeue` at 10 second intervals, run `watch -n10 squeue`


Upon pipeline completion, check the following to examine your run:
- Look in `results/` to see the files produced by the pipeline run
- Look in `log_<datestamp>.out` to see the Snakemake stdout - the final few lines should include an indication of whether the pipeline finished successfully or not
- Look in the `logs/` directory, which contains the stdout and stderr for every rule that was run.  This is helpful for troubleshooting if a pipeline did not complete successfully.

