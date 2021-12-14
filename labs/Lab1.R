#######################################
##  Data Science in Medicine: Lab 1  ##
#######################################

# Author: Areti Manataki
# Last updated: 16th September 2020
# Description: This file is used as part of Lab 1 in the Data Science in Medicine course.
# Additional files needed: DataScienceClass.csv

# Instructions for students:
# To run a command, place your cursor on any part of it and click Ctrl+Enter (or Commd+Enter)
# To write a comment, include "#" at the beginning of the corresponding line.



######################
##  Part 1: Basics  ##
######################

5+3

#variables
age <- 28 + 10

#functions
sqrt(225)

#help with functions
?sqrt



## import data (csv format)
datasciClass <- read.csv("DataScienceClass.csv", header = TRUE, sep = ",")

# get a feel for the data
head(datasciClass)
names(datasciClass)
str(datasciClass)

# get the entire dataset (not recommended - for demonstration purposes here)
datasciClass

# get the Grades column within datasciClass
datasciClass$Grades


# ==> Exercise 1.1: Get the Degree column within datasciClass



##################################
##  Part 2: Summary statistics  ##
##################################

#getting overall summary
summary(datasciClass)

mean(datasciClass$Grades)
median(datasciClass$Grades)

max(datasciClass$Grades) 
min(datasciClass$Grades)
range(datasciClass$Grades)
max(datasciClass$Grades) - min(datasciClass$Grades)

var(datasciClass$Grades)
sd(datasciClass$Grades)

table(datasciClass$Degree)


#summarising by group
by(datasciClass$Grades, datasciClass$Degree, mean)
by(datasciClass, datasciClass$Degree, summary)


# ==> Exercise 2.1: Get the mean of Hours.of.sleep


# ==> Exercise 2.2: Get the variance of Hours.of.sleep


# ==> Exercise 2.3: Get the frequency table for Gender



################################
##  Part 3: Visualising data  ##
################################

plot(datasciClass$Degree)
plot(datasciClass$Grades)


# --------------------------
# Numerical data: histogram
# --------------------------
hist(datasciClass$Grades)
hist(datasciClass$Grades, breaks = 4) # set the number of bins
hist(datasciClass$Grades, 
     main = "Histogram of student grades in the Data Science class", # set the title of the plot
     xlab = "Student grades", # set the x-axis label
     ylab = "Frequency", # set the y-axis label
     col = "blue" # change the colour of the plot
     ) 

hist(datasciClass$Grades, 
     main = "Histogram of student grades in the Data Science class",
     xlab = "Student grades",
     ylab = "Frequency",
     col = "grey",
     xlim = c(0, 100), # change the scale of the x-axis
     ylim = c(0, 10), # change the scale of the y-axis
     labels = TRUE # add frequency labels to each bar
     ) 


# ==> Exercise 3.1: Get the histogram of Hours.of.sleep



# --------------------------
# Numerical data: boxplot
# --------------------------
boxplot(datasciClass$Grades)

boxplot(datasciClass$Grades,
        main = "Boxplot of student grades in the Data Science class",
        ylab = "Grade",
        col="lightblue",
        ylim = c(30, 100)
        )

boxplot(datasciClass$Grades,
        main = "Boxplot of student grades in the Data Science class",
        xlab = "Grade",
        col="lightblue",
        ylim = c(30, 100),
        horizontal = TRUE # display the plot horizontally
        )



# boxplot by group
boxplot(datasciClass$Grades~datasciClass$Degree,
        main = "Student grades in the Data Science class by Degree",
        xlab = "Degree",
        ylab = "Grade",
        col="lightblue",
        ylim = c(30, 100)
        )


# ==> Exercise 3.2: Get the boxplot of Hours.of.sleep. The colour should be "darkseagreen".


# ==> Exercise 3.3: Get the boxplot of Hours.of.sleep by Degree.



# ----------------------------
# Categorical data: bar chart
# ----------------------------

# first get a frequency table
freq <- table(datasciClass$Degree) 
freq

# get a bar chart
barplot(freq)

barplot(freq, 
        main = "Degree distribution",
        xlab = "Degrees",
        ylab = "Frequency",
        ylim = c(0, 10)
        )

# get a grouped bar chart
freq2 <- table(datasciClass$Gender, datasciClass$Degree) 
freq2
barplot(freq2, 
        main = "Number of students by Degree and Gender",
        xlab = "Degrees",
        ylab = "Frequency",
        ylim = c(0, 8),
        beside=TRUE, # get a grouped bar chart (if FALSE, then we get a stacked bar chart)
        legend = rownames(freq2) # get the legend
        )



# ==> Exercise 3.4: Get the bar chart for Gender.



# ----------------------------
# Categorical data: pie chart
# ----------------------------

pie(freq)
pie(freq, main = "Pie chart of Degrees")



# ------------
# Scatterplot
# ------------

plot(datasciClass$Grades, datasciClass$Hours.of.sleep)

plot(datasciClass$Grades, datasciClass$Hours.of.sleep,
     main = "Student grades vs. Hours of sleep",
     xlab = "Student grades",
     ylab = "Hours of sleep",
     xlim = c(25, 100),
     ylim = c(5, 10),
     col = "blue"
     )

# draw a line of best fit
abline(lm(datasciClass$Hours.of.sleep ~ datasciClass$Grades))

# Note that:
# lm: generates a linear regression model of the two variables 
# abline: draws trend line


# -----------------------------------
# Additional visualisations by group
# -----------------------------------
# visualising a variable mean per group
g <- by(datasciClass$Grades, datasciClass$Degree, mean)
barplot(g, 
        main = "Average grade by Degree",
        xlab = "Degree", 
        ylab = "Average Grade"
        )




##################################
##  Part 4: Manipulating data   ##
##################################

# ----------
# Vectors
# ---------

#create a numerical vector
weekly_sales <- c(200, 120, 130, 125, 220) 
weekly_sales

# get the length of the weekly_sales vector
length(weekly_sales)


#create a character vector
friends <- c("maria", "john", "harry") 


## indexing vectors
# get the 3rd element
weekly_sales[3]
# get the 3rd and 5th element
weekly_sales[c(3,5)]

# get from the 3rd up to the 5th elements
weekly_sales[3:5]

# get the elements with index 3, 4, 5, 2 and 4 (in this order)
weekly_sales[c(3, 4, 5, 2, 4)]

## subsetting vectors
weekly_sales[weekly_sales > 180]
weekly_sales[weekly_sales > 180 | weekly_sales < 128 ]

#alter elements of a vector
weekly_sales[3] <- 140

#add elements to a vector
weekly_sales[6] <- 130


# ==> Exercise 4.1: Get the 4th element in weekly_sales


# ==> Exercise 4.2: Get all elements in weekly_sales that are lower than 135



# ----------
# Factors
# ---------

gender <- c(1, 1, 2, 1)

# encode a vector as a factor
gender <- as.factor(gender)

# get the levels of a factor
levels(gender)

# set the levels of a factor
levels(gender) <- c("male", "female")



# -------------
# Data frames
# ------------
name <- c("Tom", "Dave", "Anna", "John")
age <- c (20, 35, 28, 30)

# create a data frame by combining vectors
people <- data.frame(name, age, gender)
people


## indexing data frames
# get the element that is on the 1st row and 2nd column
people[1,2]

# get the elements that are on the 1st row and on columns 1 up to 3
people[1, 1:3]

# get the entire 1st row
people[1,]

# get the entire 2nd column
people[,2]

# get the entire age column
people$age


## subsetting data frames (notice the comma!)
# get all rows that satisfy a constraint (one or more constraints)
people[people$gender=="male",]
people[(people$gender=="male") & (people$age>22),]

# Useful: We can use subsetting to summarise a particular group in datasciClass
infgroup <- datasciClass[datasciClass$Degree=='Informatics',]
mean(infgroup$Grades)


## add a new column to a dataframe and instantiate it
people$city <- c("Edinburgh", "Edinburgh", "Aberdeen", "Glasgow")


# ==> Exercise 4.3: Get the entire 3rd column in datasciClass


# ==> Exercise 4.4: Get all rows where Grades > 80


# ==> Exercise 4.5: Get the Degree column for the cases where Grades > 80



############################
##  Part 5: More basics   ##
############################

#help with functions
?sqrt
?qplot
??qplot

#define your own function
sum_of_two <- function(x, y){
  z <- 2*y
  x + z
}

sum_of_two(3,5)


# when reassigning values to an object, the old ones cease to exist
myAge <- 23
myAge <- 45

# It can sometimes be useful to create a copy of an object that we want to modify
people$age2 <- people$age + 10


