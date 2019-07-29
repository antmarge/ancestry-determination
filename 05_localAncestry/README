# Snakemake pipeline for local ancestry

### Margaret Antonio

## Description
Calls RFmix to estimate local ancestry from phased genotype data and plots karyograms. Parallelized for samples and chromosomes, with options for running multiple parameters at once.

## Required Inputs

1. Sample VCF of phased genotypes (individual for which local ancestry is being estimated)
2. Reference VCF of multiple individuals with phased data (e.g. 1000 Genomes)
3. Reference Population IDs file - tab-delim file with sample population
4. Genetic map in RFmix order (hg19 included in examples/)


## Getting phased data

If data is not phased, do one of the following:
1. Impute/phase locally using BEAGLE, ShapeIt, Impute2 or other software
2. If data is not PHI (can be uploaded to a public server), then use the Michigan or Sanger Imputation servers

## Required software
1. Python 2 for the plot_karyogram rule in scripts/Snakefile. I use a conda environment so I activate it with `source activate python27`. Substitute that line for whatever way you activate python 2 (or remove if python2 is your default)
2. RFmix. Download from slowkoni @ https://github.com/slowkoni/rfmix. There's an older version online that requires custom genotype file formats (ew), so use this version instead for VCFs.


## Example data

Example data is provided in example/. A subset of 1000 Genomes reference panel is provided as the reference panel and 6 Bedouin and Egyptian individuals from HGDP are provided. Only chr 21 is included for reference and sample example data.

## Running the pipeline

See Snakemake documentation for more information
In scripts/ run `snakemake -np` to See rules that will run for example data
Alter path and variables in scripts/snakemake_variables.py to run on user data
Change sm_slurm.config and sm_script.sbatch params to reflect cluster configurations.
