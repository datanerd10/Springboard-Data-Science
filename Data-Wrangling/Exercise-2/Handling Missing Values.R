#--------------------------------------------------------------------------
# Shivani Sheth 
# R script for 
# Data Wrangling Exercise 2 Handling missing values
# Springboard - Class of Feb 29, 2016
#--------------------------------------------------------------------------

library(dplyr)
library(tidyr)

#reads .csv
missing_values <- read.csv("C:/Users/ssheth/Documents/R/Raw Data/titanic_original.csv", 
                      header = TRUE, stringsAsFactors = FALSE)

#identify distinct column values
missing_values %>%  
  select(embarked) %>% distinct

# replaces empty values in embarked column w/ 'S'
missing_values$embarked[missing_values$embarked == ""] <- "S"

#replaces NA age value by mean of the age column
mean_age <- mean(missing_values$age, na.rm = T)
missing_values$age <- ifelse(is.na(missing_values$age), mean_age, missing_values$age)

#replace empty boat values w/ NA
missing_values$boat[missing_values$boat == ""] <- 'NA'

#new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise
missing_values <- missing_values %>% 
                    mutate(has_cabin_number = ifelse(missing_values$cabin == "", 0, 1))

#writes the clean csv 
write.csv(missing_values, "C:/Users/ssheth/Documents/R/Output/titanic_clean.csv")
