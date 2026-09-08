###Workshop #4-- Introduction to ggplot2
## confusing but the package is called ggplot2 and the function is ggplot
## Doesn't matter, its included in tidyverse so you don't need to stress 

##Part 1. eGFR data bar graphs

# Here are things this program does
# 1. Read in a dataset to plot means calculated by ggplot
# 2. Repeat some data cleaning from previous weeks and make a bad graph
# 3. Subset the data to slightly improve graph
# 4. Make a simple bar graph
# 5. Make the graph again, using aggregate stats from an object
# 6. Make a fancier bar graph in iterations, adding to the plot object each time

### Part 2. Life expectancy data line graph

# Here are things this program does 
# 7. Read in a dataset to plot values in a dataset
# 8. subset the data for making a simple (ugly) line graph
# 9. transpose the data so it works for ggplotting 
# 10. Make a fancier line graph in iterations, adding to the object each time




# 1. First, lets read in the data! #########################################################

### Install a package (Only need to do this once- do it now if you did not last time)
#install.packages("haven")
#install.packages("tidyverse")

### Load the package (do this every time)
library(haven) #reads in data
library(tidyverse) #manipulates data 
##ggplot2 is part of tidyverse, so no need to install separately 


##Lets just use week 2 data for the first simple example
data<-read.csv("C:/Users/samswift/Dropbox/NMPHANMDOH/NMDOH/Workshops/Week_2/Workshop_2_data.csv")

## 2. Data cleaning review and a simple bar graph
data2<-unique(data)
##Repeat some data cleaning from workshop 2
data2$egfr[data2$egfr == 9999] <- NA
data2$took_GLP1[data2$took_GLP1 == ""] <- NA

## Simple not good bargraph of mean eGFR by GLP1
##This graph is terrible- we will make it better later 
pbar<- ggplot(data2, aes(x=took_GLP1, y=egfr)) + 
  geom_bar(stat='summary',fun='mean')
#type the plot object on its own line to make it show up in the plots window 
pbar

#3. Lets subset the data to create a new datset removing the NAs for a new graph
# A double negative happening here- !is.na means is not not missing 
data3<-subset(data2, !is.na(took_GLP1))


## 4. Simple not good bargraph of mean eGFR by GLP1- MISSINGS REMOVED 
##NOTE OUR DATASET IS DATA 3 HERE  
pbar<- ggplot(data3, aes(x=took_GLP1, y=egfr)) + 
  geom_bar(stat='summary',fun='mean')
#type the plot object on its own line to make it show up in the plots window 
pbar

## 5. Another way to do this is make an object of the aggregated data (like last week)
# then plot it 

meantable<-aggregate(egfr~took_GLP1,data3,mean)
###Here I actually made an object from the aggregate function
## Object is called mean table 
meantable

##Note data here is meantable and stat is "identity"
pbar2<-ggplot(meantable, aes(x=took_GLP1, y=egfr)) + 
  geom_bar(stat="identity") 
pbar2

##6. Adding a couple things in iterations 
## THis will work like this
## We will write over the original plot object 
# with the plot object plus some new chart elements 
##Add a lable to y axis
pbar2<-pbar2 + labs(y = "Mean eGFR")
pbar2

##Add a lable to x axis
pbar2<-pbar2 + labs(x = "GLP1 use")
pbar2

##Add a title
pbar2<-pbar2 + labs(title = "Mean eGFR by GLP1 use")
pbar2

###This graph is still lacks taste, lets make a better one below 


################Part 2- plotting values from a dataset################

# Remember- the thing we want to change is the filepath to where you saved the data
# like this change the ALL CAPS PART
# data<-read.csv("C:/YOUR_FOLDER/YOUR_SUB_FOLDER/Workshop_2_data.csv")

##7. read in some data 
##Some data about life expectancy from birth by year in high income nations 
#Source: https://www.healthsystemtracker.org/chart-collection/u-s-life-expectancy-compare-countries/
life_ex<-read.csv("C:/Users/samswift/Dropbox/NMPHANMDOH/NMDOH/Workshops/Week_4/Workshop_4_data.csv")


##8. Subset the data-- lets compare just the US and the comparable country average 
##Here select=c() keeps only the columns we want 
life_ex2<- subset(life_ex, select=c(Year,high_inc_avg,United_States))

##9.transpose the data 
# GG plot will not like that data - it wants x, y and categories for another dimension
## solution-- transpose the data
life_ex_long<-life_ex2 %>% #the pipe says do this next
  pivot_longer(                          #pivot longer is the transpose function 
    cols = c(high_inc_avg,United_States), # The columns you want to collapse
    names_to = "Country",  # The name of the new column for old headers
    values_to = "Life_ex") # The name of the new column for cell values



##10 ggplotting in iterations 

##Here I use fill=country to tell it there is a third category 
pline<- ggplot(life_ex_long, aes(x=Year, y=Life_ex, fill=Country)) + 
        geom_line(stat='identity')
pline 
##THAT GRAPH IS NO GOOD BECAUSE I DON'T KNOW WHICH IS WHICH 

#If I change fill to color the colors of the lines change
##NOTE this automatically generates a legend: you can turn that off
pline<- ggplot(life_ex_long, aes(x=Year, y=Life_ex, color=Country)) + 
  geom_line(stat='identity')
pline 

##Ok looks pretty bad lets do some simple cleaning

## fix the legend lables and manually set the colors
pline<- pline+   scale_color_manual(
  values = c("black", "red"), #make the thing you want to emphasize red? is that lying with statistics? 
  labels = c("Comparable country average", "United States")
)
pline 

##Change legend position 
pline<- pline + theme(legend.position = "bottom")
pline

##Remove background "chart junk" 
pline<- pline + theme( 
  panel.background = element_blank(),
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank())
pline

### add a title, and a y label 
pline<-pline + labs(title = "Life expectancy from birth in the US vs comparable high income countries, 1980-2024", 
                    y= "Life expectancy")
pline




##GGSave if you wanna save the plot this way
#Change the path in the same way as always
ggsave(
  filename = "C:/Users/samswift/Dropbox/NMPHANMDOH/NMDOH/Workshops/Week_4/my_plot.png", 
  plot = pline,
  width = 6, #if you leave width blank it maintains the aspect ratio
  height = 4, 
  units = "in",     # Options: "in", "cm", "mm", "px"
  dpi = 300         # High resolution for crisp text/lines
)


##Challenge question! 

# Make a line graph comparing life expectancy 
# in Japan, Australia, and the US 2018-2024
# Use three colors in the plot
# Super bonus-- Try to make the legend a bigger font 






