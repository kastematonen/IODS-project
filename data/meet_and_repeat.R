################################################################################################################################

# Julia Nihtilä
# 2023_12_06
# week 6 data wrangling excercises

################################################################################################################################

library(dplyr)
library(tidyr)


BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# structure and the dimensions
dim(BPRS) 
str(BPRS)
summary(BPRS)
glimpse(BPRS)

dim(RATS) 
str(RATS)
summary(RATS)
glimpse(RATS)

# Convert the categorical variables of both data sets to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


# Convert the data sets to long form
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>% arrange(weeks) 
# Add a week variable to BPRS and a Time variable to RATS
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5, 5)))

# Convert the data sets to long form
# Add a Time variable to RATS
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD,3,4))) %>%
  arrange(Time)



# take a serious look at the new data sets and compare them with their wide form versions: Check the variable names, view the data contents and structures, and create some brief summaries of the variables

glimpse(BPRSL)
dim(BPRSL)

# for BPRSL, the columns for different weeks were "merged" into one column with weeks numbered from zero to 8. That is why there are as many rows in the long format as individuals * weeks 

glimpse(RATSL)
dim(RATSL)

# the same for RATSL, but the pivoted variables are the WDs

# save data
write_csv(BPRSL, "./data/BPRSL.csv")
write_csv(RATSL, "./data/RATSL.csv")
