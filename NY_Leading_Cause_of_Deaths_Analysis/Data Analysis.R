library(ggplot2)
library(tidyverse)
library(dplyr)

# setting working directory
setwd('/Users/nimbi/Desktop/Bilal Spring 22/AIT 580/Final Project')

# Creating a data frame from the csv file
df <- read.csv('Data Cleaned.csv')

# Displaying the data
df

# Grouping the data by the Major_Cause column and displaying the mean and sum for all the numeric columns
x <- df %>% group_by(Major_Cause) %>% summarise(across(where(is.numeric), list(mean = mean, sum = sum)))

# Extracting the top 20 values by the sum of deaths for each of the Major_Cause
data_new <- x  %>% arrange(desc(Deaths_sum)) %>% slice(1:20)
data_new          

#Graphing the death count for the top 20 causes of death
p<-ggplot(data=data_new, aes(x=reorder(Major_Cause,Deaths_sum),y= Deaths_sum,fill=Major_Cause)) +geom_bar(stat="identity")+ theme(legend.position="none")
a <- p + ggtitle("Top 20 causes of death") + theme(plot.title = element_text(hjust = 0.5)) + xlab("Cause of Death") + ylab("Death Count")
a + coord_flip()

# Causes of death by Gender
q<-ggplot(data=df, aes(x=reorder(Major_Cause,Deaths),y= Deaths,fill=Gender)) +geom_bar(stat="identity",position=position_dodge())
b <- q + ggtitle("Causes of death by Gender") + theme(plot.title = element_text(hjust = 0.5)) + xlab("Cause of Death") + ylab("Death Count")
b1 <- b + scale_fill_discrete(name = "Gender", labels = c("Female", "Male"))
b1 + coord_flip()

# Death by ethnicities
# Grouping the data by the Major_Cause column and displaying the mean and sum for all the numeric columns
y <- df %>% group_by(Racial_Ethnicity) %>% summarise(across(where(is.numeric), list(mean = mean, sum = sum)))

r<-ggplot(data=y, aes(x=reorder(Racial_Ethnicity,Deaths_sum),y= Deaths_sum,fill=Racial_Ethnicity)) +geom_bar(stat="identity")
c <- r + ggtitle("Reported Deaths by Ethnicity") + theme(plot.title = element_text(hjust = 0.5)) + xlab("Ethnicity") + ylab("Death Count")
c + coord_flip()

# causes of death by Ethnicity
s<-ggplot(data=df, aes(x=reorder(Major_Cause,Deaths),y= Deaths,fill=Racial_Ethnicity)) +geom_bar(stat="identity",position=position_dodge())
d <- s + ggtitle("Causes of death by Ethnicity") + theme(plot.title = element_text(hjust = 0.5)) + xlab("Cause of Death by Ethnicity") + ylab("Death Count")
d + coord_flip()

#Yearly analysis of the death counts
#Extracting data for the top 5 major causes of death
e3<-df[(df$Major_Cause=="Heart Diseases" | df$Major_Cause=="Malignant Neoplasms" | df$Major_Cause=="Influenza (Flu) and Pneumonia" | df$Major_Cause=="Assault" | df$Major_Cause=="Diabetes Mellitus"),]
e3

# Using the extracted data to generate the plot
t3<-ggplot(data=e3, aes(x=reorder(Major_Cause,Deaths),y= Deaths,fill=Year)) +geom_bar(stat="identity",position='dodge')
e4 <- t3 + ggtitle("The Impact of Time on theTop 5 Major Causes of Death") + theme(plot.title = element_text(hjust = 0.5)) + xlab("Cause of Death") + ylab("Death Count")
e4 + coord_flip()



