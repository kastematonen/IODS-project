################################################################################################################################

# Julia Nihtilä
# 2023_12_04
# week 5 data wrangling excercises
# continuing from the data wrangling of week 4, done in create_human.R

# original data source
# data: United Nations Development Programme https://hdr.undp.org/data-center/human-development-index
# overview: https://hdr.undp.org/system/files/documents/technical-notes-calculating-human-development-indices.pdf
# variable names etc.: https://github.com/KimmoVehkalahti/Helsinki-Open-Data-Science/blob/master/datasets/human_meta.txt

################################################################################################################################

library(readr)

human <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.csv")

# structure and the dimensions
dim(human) # 195  19
str(human)
summary(human)

# describe the dataset briefly
# see the beginning of this file for the original sources of the data, the premodifications done last week (in script create_human.R), and variable naming and how new variables were computed

# exclude unneeded variables
human <- human[,c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" )]

# Remove all rows with missing values
human <- na.omit(human)
# or the way used in the exercises:
# human <- filter(human, complete.cases(human))
# both do the same thing

# Remove the observations which relate to regions instead of countries
human <- human[1:(nrow(human) - 7), ]

# check dimensions
dim(human) # 155 9 -> ok

# save data
write_csv(human, "./data/human_2.csv") 
# not overwriting the data from last week, because i made this script to be separate from the one from last week, create_human.R
# for then this script makes no sense if i was to load the overwritten data at the beginning of this script to modify its





