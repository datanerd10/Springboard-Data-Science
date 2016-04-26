#--------------------------------------------------------------------------
# Shivani Sheth 
# R script for 
# Data Wrangling Exercise 1 Basic Data Manipulation
# Springboard - Class of Feb 29, 2016
#--------------------------------------------------------------------------

library(dplyr)
library(tidyr)

#reads .csv
to_refine <- read.csv("C:/Users/ssheth/Documents/R/Raw Data/refine_original.csv", 
                      header = TRUE, stringsAsFactors = FALSE)

#identifies distinct company names
to_refine %>% 
  select(company) %>%
  distinct

# clean up company names
to_refine$company[grepl("^[p|f|P]+", to_refine$company)] <- 'philips'
to_refine$company[grepl("^[A|a]+", to_refine$company)] <- 'akzo'
to_refine$company[grepl("^[Va|va]+", to_refine$company)] <- 'van houten'
to_refine$company[grepl("^[u|U]+", to_refine$company)] <- 'unilever'

#ensures all errorneous values have been removed
to_refine %>% 
  select(company) %>%
  distinct

# Add 'product Category' column
to_refine$product_category[grepl("^[p|P]+", to_refine$Product.code...number)] <- 'Smartphone'
to_refine$product_category[grepl("^[v|V]+", to_refine$Product.code...number)] <- 'TV'
to_refine$product_category[grepl("^[x|X]+", to_refine$Product.code...number)] <- 'Laptop'
to_refine$product_category[grepl("^[q|Q]+", to_refine$Product.code...number)] <- 'Tablet'

#Separate product code and number
to_refine <- to_refine %>% 
  separate(Product.code...number, c('product_code', 'product_number'), sep = '-')

# Add 'full_address' column that concatenates address, city and country
to_refine <- to_refine %>% 
              mutate(full_address = paste(address, city, country, sep = ', '))

# Create dummy variables for companies
to_refine <- to_refine %>%
              mutate(company_philips = ifelse(company == "philips", 1, 0))%>%
              mutate(company_akzo = ifelse(company == "akzo", 1, 0))%>%
              mutate(company_van_houten = ifelse(company == "van houten", 1, 0))%>%
              mutate(company_unilever = ifelse(company == "unilever", 1, 0))

# Create dummy variables for product categories
to_refine <- to_refine %>%
              mutate(product_smartphone = ifelse(product_category == "Smartphone", 1, 0))%>%
              mutate(product_tv = ifelse(product_category == "TV", 1, 0))%>%
              mutate(product_laptop = ifelse(product_category == "Laptop", 1, 0))%>%
              mutate(product_tablet = ifelse(product_category == "Tablet", 1, 0))

#writes the clean csv 
write.csv(to_refine, "C:/Users/ssheth/Documents/R/Output/refine_clean.csv")


