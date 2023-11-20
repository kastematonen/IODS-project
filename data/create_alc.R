################################################################################################################################
# Julia Nihtilä
# 20.11.2023
# Assignment 3, data wrangling
# data downloaded from https://www.archive.ics.uci.edu/dataset/320/student+performance

################################################################################################################################

# prep libraries
library(tidyverse)
library(dplyr)

# read in data
mat <- read.table("./data/student/student-mat.csv", sep = ";", header = T)
por <- read.table("./data/student/student-por.csv", sep = ";", header = T)

# explore the structure and dimensions of the data
dim(mat) # 395  33
dim(por) # 649  33

str(mat)
str(por)

glimpse(mat)
glimpse(por)

#-------------------------------------------------------------------------------------------------------------------------------

# Join the two data sets using all other variables than "failures", "paid", "absences", "G1", "G2", "G3" as (student) identifiers. Keep only the students present in both data sets.
# doing this the exact way we did it in the excercises

# give the columns that vary in the two data sets
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")
# the rest of the columns are common identifiers used for joining the data sets
join_cols <- setdiff(colnames(por), free_cols)

math_por <- inner_join(mat, por, by = join_cols, suffix = c(".math", ".por"))

colnames(math_por)
glimpse(math_por)

#-------------------------------------------------------------------------------------------------------------------------------

# Get rid of the duplicate records in the joined data set

# create a new data frame with only the joined columns
alc <- select(math_por, all_of(join_cols))

# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

colnames(alc)
glimpse(alc)

#-------------------------------------------------------------------------------------------------------------------------------

# Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the joined data
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
 
# use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2
alc <- mutate(alc, high_use = alc_use > 2)

#-------------------------------------------------------------------------------------------------------------------------------

# Glimpse at the joined and modified data to make sure everything is in order

glimpse(alc) # 370 observations -> ok

# Save the joined and modified data set
write_csv(alc, "./data/student/acl.csv")

test <- read.table("./data/student/acl.csv", sep = ",", header = T)
# ok
