#####

# More Code For Day 2 of the R Course
# Remember the hashtag# is a comment 
# That means this green text is notes I wrote to help you

# Here are things this program does
# 1. Read in a very small (and flawed dateset!)
# 2. Do some basic data aggregation/ summary statistics
# 3. Remove duplicates from the dataset
# 4. Clean up the name variables 
# 5. Create categorical eGFR (if,else and Case_when)
# 6. Aggregate a continuous variable by a categorical one
 





# 1. First, lets read in the data! #########################################################

### Install a package (Only need to do this once- do it now if you did not last time)
#install.packages("haven")
#install.packages("tidyverse")

### Load the package (do this every time)
library(haven)
library(tidyverse)


# Remember- the thing we want to change is the filepath to where you saved the data

# like this change the ALL CAPS PART
# data<-read.csv("C:/YOUR_FOLDER/YOUR_SUB_FOLDER/names_n_dx.csv")

#Read in the data with read.csv

# Some data about GLP_1s and eGFR
data<-read.csv("C:/Users/samswift/Dropbox/NMPHANMDOH/NMDOH/Workshops/Workshop_2/Workshop_2_data.csv")

#1.5 (not shown on slides)
# some basic functions to look at datset features

#str() prints some features of the data similar to what is in the environment
str(data)
#names prints a list of the variable names
names(data)

#2. Using a table() command to look at the took_GLP1 variable 
table(data$took_GLP1)
#Add useNA="always" to include the NAs
table(data$took_GLP1, useNA="always")
##Something here is not right, there are blanks and NAs 

#Simple five number summary of the egfr variable using summary()
summary(data$egfr)
summary(data$egfr, useNA="always")






# 3. Data cleaning -- Remove duplicates

#Lets remove duplicates using the well named "unique" function
# Notice here I am using the arrow operator to create new data frame objects
data2<-unique(data)
# new n= 25 meaning there were two pairs of duplicates
# Look! I also created a new data.frame object here called data2
#I will work with data2 for the remainder of today


#4. Data Cleaning- Capatilize the whole variable name
# There are some capitalization differences in the two data sets- lets fix #############################
# Solution? Capitalize the entire name in each using "toupper()" function
# Notice that to refer to a variable within a dataset we use the syntax: dataset$variable
data2$name<-toupper(data2$name)


##lets fix eGFR
summary(data2$egfr)
##Here is one way to deal with that 9999 in the eGFR variable
# Overwrite the specific column
data2$egfr[data2$egfr == 9999] <- NA
#Lets rerun that summary
summary(data2$egfr)



# 5. Creating Variables-- lets categorize eGFR
# # This is probably the simplest option 
data2$kidney_function <- ifelse(data2$egfr > 90,c("normal"), c("reduced"))

table(data2$kidney_function, useNA="always")

# If you want to use this one you can change the syntax as follows:
# yourdata$yourNEWvariable<-ifelse(yourdata$yourOLDvariable > [number of cutoff], c("label above in quotes"), c("label below in quotes"))


# Lets use mutate and case_when to make a more complex variable 
# (how I like to do it)

data2 <- data2 %>%
  mutate(kidney_3cat=case_when(egfr<=60~"kidney disease",
                               egfr<=90 & egfr >60~ "early stage kidney disease",
                               egfr>90~"normal",
                               TRUE~NA))
table(data2$kidney_3cat)



#6. Aggregate a continuous variable by a categorical one

aggregate(egfr~took_GLP1, data2,mean)


#bonus- a table with two categorical variables

table(data2$has_diabetes, data2$kidney_function, dnn=c("has_diabetes", "Kidney function") )



###ON YOUR OWN--

##Fix the blanks in took_GLP1
##Create a variable for Kidney failure (egfr<20) vs all other kidney functions

##Super challenge: create a four category variable for 
##diabetes AND reduced kidney function
## USe these categories: 
#diabetic/reduced, diabetic/not reduced, not diabetic/reduced, not diabetic/not reduced




