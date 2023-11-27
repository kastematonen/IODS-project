################################################################################################################################

# Julia Nihtilä
# 2023_11_27
# week 4 data wrangling excercises

# information on the original datasets:
# https://hdr.undp.org/data-center/human-development-index
# https://hdr.undp.org/system/files/documents/technical-notes-calculating-human-development-indices.pdf

################################################################################################################################

library(dplyr)
library(tidyverse)
library(readr)

################################################################################################################################

# Read in the “Human development” and “Gender inequality” data sets
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# see the structure and dimensions of the data. Create summaries of the variables
dim(hd)
str(hd)
summary(hd)

dim(gii)
str(gii)
summary(gii)

# see metafile
# https://github.com/KimmoVehkalahti/Helsinki-Open-Data-Science/blob/master/datasets/human_meta.txt
# rename the variables with (shorter) descriptive names
colnames(hd)
colnames(gii)

# something like this, for example (not all variables have a new name in the metafile page -> giving them other, shorter names)
colnames(hd) <- c("HDI_rank", "Country", "HDI", "Life.Exp", "Edu.Exp", "Edu.Mean", "GNI", "GNI_HSI")
colnames(gii) <- c("GII_rank", "Country", "GII", "Mat.Mor", "Ado.Birth", "representation", "Edu2.F", "Edu2.M", "Labo.F", "Labo.M")

# Mutate the “Gender inequality” data and create two new variables
gii$Edu2.FM <- gii$Edu2.F / gii$Edu2.M
gii$Labo.FM <- gii$Labo.F / gii$Labo.M
# named like in the meta file

# Join the two datasets together  using the variable Country as the identifier
human <- inner_join(hd, gii, by = "Country")
dim(human) # 195  19

# save data
write_csv(human, "./data/human.csv")

