# Pipeline for Ancestry using Haplotype-based methods
## Margaret Antonio 2019.07.16

### For haplotype-based analyses, need imputed and phased data.
### Two ways to get this:

1. Impute on a server using software (e.g. Beagle). This
is the best option if you have large amounts of data, 
have PHI data (patient data that can't be uploaded to a 
public server), want to control the imputation parameters 
(e.g. whether imputation is on genotype calls or probabilities).

2. Impute on a public server such as Michigan or Sanger 
Imputation servers

Note: prior to imputation, need genotype calls (so 
reads should be processed and genotypes called). See
readProcessing pipeline included in this repo for more info.

### Methods for haplotype-based ancestry
1. RFMix
2. Chromopainter/FineStructure

