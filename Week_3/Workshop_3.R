#####

# R COURSE DAY 3!! 
# Going to slow things down a lot to try to get us on the same page
# Remember the hashtag# is a comment 
# That means this green text is notes I wrote to help you

# Here are things this program does
# 1. Read in not one, but TWO datasets!
# 2. Review removing duplicates and capitalizing names
# 3. Match (join in R) 
# 4. Tell us who didnt match (anti join)
# 5. fun with subsetting





# 1. First, lets read in the data! #########################################################

### Install a package (Only need to do this once- do it now if you did not last time)
#install.packages("haven")
#install.packages("tidyverse")

### Load the package (do this every time)
library(haven) #reads in data
library(tidyverse) #manipulates data 


# Remember- the thing we want to change is the filepath to where you saved the data

# like this change the ALL CAPS PART
# data<-read.csv("C:/YOUR_FOLDER/YOUR_SUB_FOLDER/Workshop_2_data.csv")

#Read in the data with read.csv

# Some data about GLP_1s and eGFR
data<-read.csv("C:/Users/samswift/Dropbox/NMPHANMDOH/NMDOH/Workshops/Week_2/Workshop_2_data.csv")

# like this change the ALL CAPS PART
# data<-read.csv("C:/YOUR_FOLDER/YOUR_SUB_FOLDER/Workshop_3_data.csv")
##Lets read in another dataset-- the favorite colors/ holidays
colors_holidays<-read.csv("C:/Users/samswift/Dropbox/NMPHANMDOH/NMDOH/Workshops/Week_3/Workshop_3_data.csv")


#2 A simple way to de duplicate
# Here I make new dataset objects (add the 2) so I don't write over the originals 
data2<-unique(data)
colors_holidays2<-unique(colors_holidays)


# 2. There are some capitalization differences in the two data sets- lets fix #############################


# Solution? Capitalize the entire name in each using "toupper()" function
# Notice that to refer to a variable within a dataset we use the syntax: dataset$variable
#not makeing new datasets here 
data2$name<-toupper(data2$name)
#data2$name2<-toupper(data2$name)
colors_holidays2$name<-toupper(colors_holidays2$name)

## Now the names are capitalized so we can match them! 



##Sam creates some indicatro variables to know which datasets people cam from
data2$in_data2<-1
colors_holidays2$in_ch<-1



# 3. Lets match (or join as it is called in SQL)##########################################################

### inner_join keeps whoever is in both- causes a problem for when not two identifiers
# Syntax is more comples but like this:
# newdata<-inner_join(data1,data2, by = c("identifier" = "identifier"))

both_inner_1<-inner_join(data2,colors_holidays2, by = c("name" = "name"))
#n=24
##This is wrong-- it matched liam hart multiple times 
#and gave us 2 birthdate variables in our resulting dataset

### SOLUTION: NOTE TWO IDENTIFIERS HERE 
both_inner_2<-inner_join(data2,colors_holidays2, by = c("name" = "name", "birthdate" = "birthdate"))
#n=22


#left joining keeps all (including not match) in first dataset
both_left<-left_join(data2,colors_holidays2, by = c("name" = "name", "birthdate" = "birthdate"))
#n=25

#left joining keeps all (including not match) in first dataset
both_right<-right_join(data2,colors_holidays2, by = c("name" = "name", "birthdate" = "birthdate"))
#n=22


not_match<-subset(both_left, is.na(in_ch))



###Your practice-- Try to understand why these data sets are different numbers?








# 4. LETS SEE WHO DIDNT MATCH ###############################################################################

# I will use anti_join for this- Similar syntax
not_match<-anti_join(data2,colors_holidays2, by = c("name" = "name", "birthdate" = "birthdate"))
# n=3





###5 subsetting 
## lets make a very simple new dataset of only people who like earth day
earth_day<-subset(both_inner_2, Favorite_holiday=="earth day")

table(earth_day$Favorite_holiday)











###Homework challenge questions
## 1. Create a dataset of people who live in santa fe from the ORIGINAL data2 dataset
## 2. Left or inner join those data with the favorite colors and holidays data (hopefully same answer)
## 3. What is the most popular color of people who live in santa fe? 
## 3.5 Review aggregate function- is there a difference in  egfr means across categories of GLP1 for people in SF?
## 3.5 will only be in santa fe dataset 
## 4. I will show a solution next week 











# BONUS!!! Just for those who wanted it. 
## Calculate age from birthdate and visit date ########################################################

#use lubridate package
##If you want to install this package delete the # and run line 139
#install.packages("libridate")
library(lubridate)
##reformat the dates as dates (function is as.Date)
both_inner_2$visit_date <- as.Date(both_inner_2$visit_date, format = "%m/%d/%Y")
both_inner_2$birthdate <- as.Date(both_inner_2$birthdate, format = "%m/%d/%Y")

##Other functions like this are as.number, as.factor, as.character

both_inner_2$age <- time_length(interval(both_inner_2$birthdate, both_inner_2$visit_date), "years")


##Remove duplicates with distinct as discussed in week 2
##Note syntax is a little different here, it wants to use the pipe %>%
#Syntax is not important-- knowing what you want to do is!! 
dinstinct_birthdate <- data %>% distinct(birthdate)
