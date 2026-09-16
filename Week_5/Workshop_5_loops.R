###Workshop #5
##This is 1/2 of workshop 5-- here I show some basic loops 
## The other 1/2 is workshop 5.qmd, which shows basic quarto to make a report
#
# Here is what the program does
#
# 1. A very simple loop 
#
# 2. demonstrate simple loops through columns and rows 
#
# 3. Create a loop that tells me the first year a country had 
#    life expectancy >=82
#





# 1. First, the most basic loop

##like a Macro in SAS, "i" is an arbirtary number 
#1:5: This creates a sequence of numbers: 1, 2, 3, 4, 5.
#i: This is a temporary "placeholder" variable (you can name it whatever you want).
#in: This tells R to move through the sequence one by one.
#{ }: The curly braces hold the code you want to repeat

for (i in 1:5) 
  {print(i)}







### 2. Looping through a data frame by columns or rows 
# Create a sample data frame
df <- data.frame(
  Age = c(25, 30, 35),
  Height = c(165, 175, 180),
  Weight = c(60, 70, 80)
)

# Loop through columns by name
for (col_name in colnames(df)) {
  print(paste("Column Name:", col_name))
  
  # Access the data inside that column
  print(df[[col_name]]) 
}

# Loop through rows by index
# here I named the placeholder s
for (s in 1:nrow(df)) #go down through the rows 
  {print(paste("This is row number:", s))
  # Extract the entire current row
  current_row <- df[s, ]
  print(current_row)}






#3. Lets make a loop that actually does something 
#lets use the life expectancy data 
life_ex<-read.csv("C:/Users/samswift/Dropbox/NMPHANMDOH/NMDOH/Workshops/Week_4/Workshop_4_data.csv")

# test ncol function
ncol(life_ex)

# lets show the first year a country passes life expectancy 
# of 82 years from birth 


## Looping through columns--make a table of the first year a country passes 82

##Step 1, make an empty table
results <- data.frame(
  Country = names(life_ex)[-1], #takes all the column names from the data except year
  First_Year_Above_82 = NA_character_ )#sets the new variable to blank


# step 2, make the loop
#Note multiple steps with {}- different steps in the loop

for (i in 2:ncol(life_ex)) #go from the second to the last column 
  {
  
  first_row <- which(life_ex[[i]] >= 82)[1] 
  #find the rows where that happens and put them in a separate object
  
  if (is.na(first_row)) {
    results$First_Year_Above_82[i - 1] <- "never"
  } else {
    results$First_Year_Above_82[i - 1] <- as.character(life_ex$Year[first_row])
  }
}

results