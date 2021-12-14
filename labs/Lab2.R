#######################################
##  Data Science in Medicine: Lab 2  ##
#######################################

# Author: Areti Manataki
# Last updated: 6th October 2020
# Description: This file is used as part of Lab 2 in the Data Science in Medicine course.
# Additional files needed: i) parenthood.Rdata, ii) chapek9.Rdata, iii) harpo.Rdata
# iv) parenthood2.Rdata, v) DataScienceClass.csv, vi) DataScienceClass2.csv

# Instructions for students:
# To run a command, place your cursor on any part of it and click Ctrl+Enter (or Commd+Enter)
# To write a comment, include "#" at the beginning of the corresponding line.


##################################
##  Part 1: Hypothesis testing  ##
##################################

# ----------------------------------------
# Correlation between numerical variables
# ----------------------------------------

# import data (Rdata format)
load("parenthood.Rdata")

# explore the data
str(parenthood)
head(parenthood)
summary(parenthood)

# visualise in scatterplot (labeling should be better!)
plot(parenthood$dan.sleep, parenthood$dan.grump)
abline(lm(parenthood$dan.grump ~ parenthood$dan.sleep))

# get correlation coefficient for two variables
cor(parenthood$dan.sleep, parenthood$dan.grump) 

# carry out correlation testing
cor.test(parenthood$dan.sleep, parenthood$dan.grump) 


# ==> Exercise 1.1: Visualise in a scatterplot the relationship between Dan's hours of sleep and the baby's hours of sleep

# ==> Exercise 1.2: Carry out hypothesis testing to investigate correlation between Dan's hours of sleep and the baby's hours of sleep



# ------------------------------------------
# Association between categorical variables
# ------------------------------------------

# import data (Rdata format)
load("chapek9.Rdata")

# explore the data (and check whether categorical)
str(chapek9)
summary(chapek9)
head(chapek9)

# get observed frequencies
chapekFrequencies <- table(chapek9$choice, chapek9$species)
chapekFrequencies

# get expected frequencies
chisq.test(chapekFrequencies)$expected

# carry out chi-square testing
chisq.test(chapekFrequencies) 



# --------------------------------------------------------
# Comparing the means of two independently drawn samples
# --------------------------------------------------------

# import data (Rdata format)
load("harpo.Rdata")

# explore the data
str(harpo)
head(harpo)
summary(harpo)


# carry out independent samples t-testing
t.test(formula = grade ~ tutor, data = harpo, var.equal = TRUE)


# ==> Exercise 1.3: Use DataScienceClass.csv to carry out hypothesis testing to compare the grades means for female vs male students



###############################
##  Part 2: Missing values   ##
###############################

# import data (Rdata format)
load("parenthood2.Rdata")

# explore the data (missing values detected!)
str(parenthood2)
head(parenthood2)
summary(parenthood2)

# get the mean
mean(parenthood2$baby.sleep)
mean(parenthood2$baby.sleep, na.rm=TRUE)

# Note that: mean, median, sd and other descriptive statistics functions return NA, unless we set na.rm=TRUE
#  while summary detects missing values and ignores them when calculating descriptive statistics 

# visualise columns that contain missing values
hist(parenthood2$baby.sleep)
boxplot(parenthood2$baby.sleep)
plot(parenthood2$dan.sleep, parenthood2$dan.grump)
abline(lm(parenthood2$dan.grump ~ parenthood2$dan.sleep))

# get the correlation coefficient for two variables that contain missing values
cor(parenthood2$dan.sleep, parenthood2$dan.grump) 
cor(parenthood2$dan.sleep, parenthood2$dan.grump, use="complete.obs") 

# ==> Exercise 2.1: Get the mean of Dan's hours of sleep 


# ==> Exercise 2.2: Get the standard deviation of Dan's grumpiness


# ==> Exercise 2.3: Get the boxplot of Dan's grumpiness




######################################
##  Part 3: More data manipulation  ##
######################################

# import data (csv format)
ds_class2 <- read.csv("DataScienceClass2.csv", header = TRUE, sep = ",")

# get a feel for the data
str(ds_class2)
head(ds_class2)

 
# ---------------------------------------------------------
# Data coercion: converting data from one type to another
# ---------------------------------------------------------

# coercing to numeric
ds_class2$StudyYear<- as.numeric(ds_class2$StudyYear)
class(ds_class2$StudyYear)

# coercing to character
ds_class2$StudyYear<- as.character(ds_class2$StudyYear)

# coercing to int
ds_class2$StudyYear<- as.integer(ds_class2$StudyYear)

# coercing to factor
ds_class2$StudyYear<- as.factor(ds_class2$StudyYear)

# coercing to date
ds_class2$DoB <- as.Date(ds_class2$DoB, "%Y-%m-%d")


# ==> Exercise 3.1: Coerce the Nationality (from ds_class2) to character, and then back to factor



# --------------------
# Subsetting data
# --------------------

# Subset data using the subset() function
df1 <- subset(ds_class2, Degree == "Medicine")
print(df1)

# Use subset() on a numeric/integer column
df2 <- subset(ds_class2, Grades >= 70)
print(df2)

# Use subset() and specify which column(s) to keep
df3 <- subset(ds_class2, Grades >= 70, select = Hours.of.sleep)
print(df3)


# Selecting (or keeping) variables 
vars_to_keep <- c("Degree", "Hours.of.sleep", "Nationality")
df4 <- ds_class2[vars_to_keep]
str(df4)

# Excluding (or dropping) variables 
df5 <- ds_class2[, -1]
str(df5)


# ==> Exercise 3.2: Subset ds_class2 to keep only the observations for EU students, and name the resulting data frame df6


# ==> Exercise 3.3: Subset ds_class2 to keep only the observations for EU students that have slept 7 hours or more, and name the resulting data frame df7


# ==> Exercise 3.4: Subset ds_class2 to keep only the Gender information for EU students that have slept 7 hours or more, and name the resulting data frame df8


# ==> Exercise 3.5: Select the Grades and Gender columns from ds_class2, and name the resulting data frame df9



# --------------------
# Renaming columns
# --------------------

# Get the column names
names(ds_class2)

# Change the name of the 7th column
names(ds_class2)[7] <- "DateOfBirth"

# Change the name of the column "Hours.of.sleep"
names(ds_class2)[names(ds_class2) == "Hours.of.sleep"] <- "HoursOfSleep"


# ==> Exercise 3.6: Rename StudyYear to YearOfStudy (using the number of the column)


# ==> Exercise 3.6: Rename Grades to Grade (using the name of the column)





##############################
##  Part 4: Using packages  ##
##############################

#If the package is not already installed, you will need to install it
#install.packages("ggplot2")

#loading a package (a package needs to be loaded every time you need to use it)
library("ggplot2")

# get a histogram with ggplot2
ggplot(parenthood, 
       aes(x = dan.sleep)) + 
  geom_histogram(fill = "blue") + # add histogram geom in blue
  labs(title ="Histogram of Dan's sleep", x = "Dan's sleep (hours)") # add labels


# Dealing with overplotting (example with mpg dataset)
str(mpg)
plot(mpg$displ, mpg$hwy)
plot(mpg$displ, mpg$hwy,
     col="#00000033")
abline(lm(mpg$hwy ~ mpg$displ), col = "blue")


###########################################
##  Part 5: Further practice (optional)  ##
###########################################

# Use the dataset provided in Tutorial 2 to practise with what you've learnt in this lab



