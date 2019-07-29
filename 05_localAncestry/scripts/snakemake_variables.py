# Local ancestry pipeline using RFMIX
# Margaret Antonio
# Sometime before 7/29/2019


########### Variables and file paths for Snakefile ##########

HOME_DIR = ".."

# 1000 Genomes reference panel
# Downloaded from the beagle imputation server 
# (just b/c already using it for imputation)
# Filtered for MAF > 0.05
REF_VCF = HOME_DIR + "/example/ref/1000Genomes_chr21_phase3_v5a_biSNPs_maf05_small20.vcf.gz"

# Change to where rfmix is located
RFMIX = "/home/groups/pritch/Margaret/bin/rfmix/rfmix" 

# Change to name of run directory
RUN = HOME_DIR + "/run1"

# RFmix formatted genetic map
GENETIC_MAP = HOME_DIR + "/example/ref/plink.allChr.GRCh37.rfMixOrder.map"

# 1000 Genomes reference files
#POP_FILE = "ref/1000Genomes_poplabels.txt"
# Randomly sampled 20 individuals from non-admixed populations
POP_FILE = HOME_DIR + "/example/ref/1000Genomes_poplabels_small20.txt"
TEMP_FILE = HOME_DIR + "/example/ref/temp_popfile.txt"

# From Alicia Martin's Github
KARYOGRAM_SCRIPT = "plot_karyogram.py" 


## RFmix run paramters
# NUMBER OF GENERATIONS
#GENERATIONS = ['3','10']
GENERATIONS = '3'
# CONDITIONAL RANDOM FIELD WEIGHT PARAMETER
#CRF_WEIGHT = ['Optimized','5', '15','30']
CRF_WEIGHT = 'Optimized'

# WHICH 10000 Genomes POPULATION DISTINCTION
# e.g. superpops (ASN, EUR, AFR)
# These are the columns in the 
#POP_TYPE = ['superpop','subpop']
POP_TYPE = ['superpop']
# CHROMOSOMES
#CHROMS = [i for i in range(22)]
CHROMS = '21'

# File for the sample IDs and filepaths
SAMPLE_LIST = HOME_DIR + "/example/sample_filelist.txt"

# Create dictionary of samples
from collections import defaultdict

sample_file_dict = defaultdict()

with open(SAMPLE_LIST) as f:
    for line in f:
       (key, val) = line.split()
       sample_file_dict[key] = val

# SAMPLES listed here
SAMPLES = sample_file_dict.keys()
