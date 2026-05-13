#  Sam Swifts Example R program: NMDOH R Workshops
#  Look a comment can be anything!! 

#  Welcome to the example Program!!
#  Any line that starts with the pound sign "#" is Green!!!
#  That tells R- "This is a comment, ignore this line"
#  Comments are used to explain what is going on in script
#  Your mission is to run the code in this script to practice coding 

#  Lets begin

#  1. Creating an object
#  An object can be anything, but the the point is you use the arrow operator "<-"
#  Here I create a "value" object that is a string of text  
#  To run code, highlight a line and click the run button,
#  Or, click anywhere on the line and press control+enter on PC, 
#  On Mac its command+enter 


the_truth<-"learning to code is fun"
# print() is our first function. It prints an object that we made
print(the_truth)


#  Here I create a "value" object that is the number zero
zero_is_the_name_of_this_object<-0
print(zero_is_the_name_of_this_object)

# If the parenthesis in this code go onto 
# a second line I need to run both lines

print(zero_is_the_name_of_this_object
      )

# Lets make it error so you see what that looks like 
# Delete pound sign on line 37 to see error
# the_truth<-(learning to code is fun
# To fix the error I closed the parenthesis and added quotes
 
# lets try to print an object that we haven't made yet, 
# this will also cause an error
print(object_that_does_not_exist)

# lets learn a function "sqrt()" which is square root 

# Create a value object that is 4 (HOMEWORK QUESTION ON THIS)
four<-4
# Take the square root of that value
# The name of the function to take a square root is sqrt()
sqrt(four)


# the correct name of this function is "summary"
summary(four)


# lets install a package! 
# You can do this using the package window, or using code below
# here is the install.packages function, only need to run this once
# note that the name of the package must be in double quotes
install.packages("tidyverse")



# here is the library function 
# library function tells R studio 
# we will be using this package in this session
# You will need to run library functions every session you use a package
library(tidyverse)

# Lets learn how to read in data 
# TO MAKE THE LINE BELOW WORK YOU MUST CHANGE THE PATH- KEY CONCEPT FOR THE WEEK
# The path is where the data are, slashes are subfolders 


##Read it as a CSV (base R)
##You have to change the backslashes to forward slashes and there are fixes for that, but not for day 1  
data_1<-read.csv("C:/Users/samswift/Dropbox/NMPHANMDOH/NMDOH/Workshops/Workshop_1/Week_1_data.csv")

##Install the haven package to read in SAS and Stata data 
install.packages("haven")
## call the package into the session
library(haven)

##THESE HAVE THE SAME NAME AND DIFFERENT EXTENTIONS ON PURPOSE
##I MUST MENTION MY INTENTION THAT YOU PAY ATTENTION TO EXTENSIONS 

##Read in a sas7bdat
data_2<-read_sas("C:/Users/samswift/Dropbox/NMPHANMDOH/NMDOH/Workshops/Workshop_1/Week_1_data.sas7bdat")

##Read in dta
data_3<-read_dta("C:/Users/samswift/Dropbox/NMPHANMDOH/NMDOH/Workshops/Workshop_1/Week_1_data.dta")



#Writing the code "View(data_week_1) opened the dataset the same as clicking on it
View(data_1)
## Functions for this weeks homework 


# dim(dataframe): Returns the dimensions of the data frame (number of rows and columns).
# REMEMBER ROWS ARE OBSERVATIONS AND COLUMNS ARE VARIABLES
# str(dataframe): Displays the structure of the data frame, including variable names, data types, and the first few values.
# names(dataframe): Returns the names of all the columns (variables) in the data frame.
# head(dataframe, n=6): Displays the first n rows of the data frame (default is 6).
# tail(dataframe, n=6): Displays the last n rows of the data frame (default is 6)

# the way this dim() function works is it 
# will print observations then variables in the console
dim(data_week_1)
str(data_week_1)
# next week Sam will show how to make cancer deaths a number

# print first 6 observations
head(data_week_1)
# print last 6 observations
tail(data_week_1)
# Names will print out the variable names in a dataset 
names(data_week_1)

# Look I can get a 5 number summary
summary(data_week_1$Flu_18_per)
