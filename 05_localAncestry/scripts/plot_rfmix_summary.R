# Plot RFMix Summary
# Margaret Antonio

# Custom script for summarizing RFmix output
# Super messy
# Need to clean up

library(tidyr)
library(dplyr)
library(ggplot2)
require(cowplot)
library(viridis)


pops = "super"

dir = "~/sherlock/"

sum_file = paste0(dir, "analyses/rfmix/summary_gen3_crfOptimized_",pops,"Pop.Qfiles")
ref_pops = c("British",	"Finnish",	"Spanish",	"Tuscan")
meta_file = paste0(dir, "metadata/rmpr_sample_metadata_master.csv")

if(pops == "sub"){
  ref_pops = c("British",	"Finnish",	"Spanish",	"Tuscan")
  some_pop = "Tuscan"
  
}
if(pops == "super"){
  ref_pops = c("AFR","EAS","EUR","SAS")
  some_pop = "AFR"
}
if(pops == "subglobal"){
  ref_pops = c("Finnish",	"Indian",	"Spanish",	"Tuscan",	"Yoruba")
  some_pop = "Yoruba"
  
}

mat_meta <- read.table(paste0(dir,"analyses/pop_af/sample_lists/matullo_sample_pop_list.txt"), header = FALSE, col.names = c("Sample", "Population")) %>%
  mutate(Date_Average = 2000)

meta_df <- read.csv(meta_file, header = TRUE) %>%
  select(Sample, Date_Average) %>%
  mutate(Population = "RMPR") %>%
  rbind(mat_meta)

sum_df <- read.table(sum_file, header = FALSE, 
                     col.names = c("Chrom", "Sample",ref_pops), 
                     stringsAsFactors = FALSE) %>% 
  left_join(meta_df, by = "Sample") %>%
  arrange(Population,Date_Average) %>%
  gather(key = Pop, value = Ancestry_Prop, ref_pops) %>% 
  group_by(Sample,Pop,Population,Date_Average) %>%
  dplyr::summarize(Mean_Ancestry_Prop = mean(Ancestry_Prop)) %>% 
  ungroup() %>%
  separate(Sample, c("Sample", "Sample2"), sep = "_")

sample_order <- sum_df %>% filter(Pop == some_pop) %>% arrange(Date_Average,Population) %>% pull(Sample)
  
  ggplot(sum_df,aes(x = factor(Sample, levels = sample_order), y = Mean_Ancestry_Prop, fill = factor(Pop, levels = ref_pops))) +
    geom_bar(stat = "identity", width = 0.9) +
    scale_fill_brewer(name = "", palette = "Set1") +
    #coord_flip() +
    #ylim(0,1) +
    xlab("Sample") +
  ggtitle("RFMix Global Ancestry Proportions\nGenerations = 3") +
    #geom_hline(yintercept  = c(0.9,0.1), color = "darkgray") +
    theme(
      plot.title = element_text(size = 20, face = "bold"),
      legend.position = "top"
    ) +
    facet_wrap(~Population, scales = "free")


  
  
  
  
  
  
  
  
  
  
  
  
block_file = "/scratch/PI/pritch/AncientRome/analyses/rfmix/rmpr/rfmix_RMPR-132_all_gen3_crfOptimized_superPop.msp.tsv"

block_df <- read.table(block_file, header = TRUE, stringsAsFactors = FALSE)

afr_blocks <- block_df %>%
  gather(key = "Haplotype", value = "Ancestry", c(HapA,HapB)) %>%
  filter(Ancestry == 0)

combined = data.frame()

i = 1
temp_afr <- afr_blocks
while(i < nrow(afr_blocks) - 1){
  if(temp_afr[i,"epos"] == temp_afr[i + 1,"spos"]){
    temp_afr[i,"epos"] <- temp_afr[i + 1,"epos"]
    combined <- rbind(combined,temp_afr[i,])
    i = i + 2
  }  
  else{
    combined <- rbind(combined,afr_blocks[i,])
    i = i + 1
  }
}

combined <- combined %>%
  mutate(block_size_mb = (epos-spos)/1000000)
?dgamma
d = seq(1,20, by = 0.5)

exp_df <- data.frame(dist = d, y1 = dgamma(x = d, shape = 2,rate = 1/100)) %>%
  mutate(y25 = dgamma(x = d, shape = 2,rate = 25/100)) %>%
  mutate(y50 = dgamma(x = d, shape = 2,rate = 50/100)) %>%
  mutate(y60 = dgamma(x = d, shape = 2,rate = 60/100)) %>%
  mutate(y65 = dgamma(x = d, shape = 2,rate = 65/100)) %>%
  mutate(y70 = dgamma(x = d, shape = 2,rate = 70/100)) 
  



ggplot(combined, aes(x = block_size_mb)) +
  geom_density(fill = "red") +
  ggtitle("Length of African Ancestry Blocks in RMPR-132 at 3 Generations") +
  geom_vline(xintercept = mean(combined$block_size_mb)) +
  xlab("Block Size (MB)") + scale_x_continuous(breaks = seq(0,16,by = 1)) +
  theme(
    plot.title = element_text(size = 25),
    axis.text = element_text(size= 20),
    axis.title = element_text(size = 20)
  ) +
  xlab("Log10(BlockSize-MB)") +
  #scale_x_log10() +
  geom_line(data = exp_df, color = "blue", aes(x = dist, y = y65))
#breaks = c(500,1000,2000,3000,5000,9000,12000))


