# Data Source #
#################################################################################################################################
# Title: Life Expectancy at Birth by Country (1960-2015)
# Data Source: World BankAlso join us at the San Diego and Finland TUGs. Details on the events page.
# Link : https://www.makeovermonday.co.uk/data/data-sets-2017/

# Packages needed #
##################################################################################################################################
install.packages("lubridate")
install.packages('corrplot')
library(tidyverse)
library(lubridate)
library("dplyr")
library(corrplot)

# Read data #
##################################################################################################################################
life_expectancy <- read.csv(file.choose(), header = TRUE)
View(life_expectancy)


# Data Processing and cleaning #
##################################################################################################################################
# Make sure data is a dataframe format
life_expectancy <- as.data.frame(life_expentancy)
str(life_expectancy)
unique(life_expectancy$Region)
unique(life_expectancy$Gender)
unique(life_expectancy$Income.Group)
summary(life_expectancy)

# Drop all rows with NAs
life_expectancy <- life_expectancy %>% 
  drop_na()

summary(life_expectancy)  

# Fix data types 
life_expectancy$Gender <- factor(life_expectancy$Gender)
life_expectancy$Income.Group <- factor(life_expectancy$Income.Group)
life_expectancy$Region <- factor(life_expectancy$Region)

# Have a quick glimpse of data and data type changes 
glimpse(life_expectancy)

# Subset data to only what we need 
life_expectancy_Africa_America <-subset(life_expectancy, Region == 'North America' | Region == 'Sub-Saharan Africa'| Region == 'Middle East & North Africa')

# View the new subset data 
View(life_expectancy_Africa_America)

# Another clean step to look for mispellings 
unique(life_expectancy_Africa_America$Country.Name)

# Fix Mispellings 
life_expectancy_Africa_America$Country.Name[life_expectancy_Africa_America$Country.Name == 'Congo, Rep.'] <- 'Congo Republic'
life_expectancy_Africa_America$Country.Name[life_expectancy_Africa_America$Country.Name == 'Iran, Islamic Rep.'] <- 'Iran'
life_expectancy_Africa_America$Country.Name[life_expectancy_Africa_America$Country.Name == 'Syrian Arab Republic'] <- 'Syria'
life_expectancy_Africa_America$Country.Name[life_expectancy_Africa_America$Country.Name == 'Yemen, Rep.'] <- 'Yemen'
life_expectancy_Africa_America$Country.Name[life_expectancy_Africa_America$Country.Name == 'Congo, Dem. Rep.'] <- 'Congo Democratic Republic'
life_expectancy_Africa_America$Country.Name[life_expectancy_Africa_America$Country.Name == 'Egypt, Arab Rep.'] <- 'Egypt'
life_expectancy_Africa_America$Country.Name[life_expectancy_Africa_America$Country.Name == 'Gambia, The'] <- 'Gambia'

# Quick look at the mispelling fixes
unique(life_expectancy_Africa_America$Country.Name)

# Quick summary of new cleaned subset
summary(life_expectancy_Africa_America)  


# Exploratory Data Analysis #
###############################################################################################################################
# Install Smart EDA package
install.packages("SmartEDA")
library(SmartEDA)

# Generate Smart EDA Report
ExpReport(life_expectancy_Africa_America, op_file = "SmartEDA.html")

# Install Data Explorer 
install.packages("DataExplorer")
library(DataExplorer)

# Create Data Explorer Report
create_report(life_expectancy_Africa_America)



# Export subset data to csv to conduct visual analysis in Tableau #
##################################################################################################################################
write_csv(life_expectancy_Africa_America, file = '/Users/oluwaseyiorioye/Library/CloudStorage/OneDrive-ProvidenceCollege/MSBA 680 R CLASS/life_expectancy_Africa_America.csv')
