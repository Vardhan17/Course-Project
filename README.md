# Getting and Cleaning Data Course Project


This file describes how run_analysis.R script works.

1. Unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Make sure the file folder and the run_analysis.R script are both in the current working directory.
3. Use library(plyr) to load the package plyr; as a part of the script uses it. 
4. Use source("run_analysis.R") command in RStudio.
4. You will find the output file in the current working directory - "Project_Work.txt"
5. Finally, use below command in RStudio to read the file. 
      temp <- read.table("Project_Work.txt", header = TRUE)
      View(temp)
6. Since we are required to get the average of each variable for each activity and each subject, and there are 6 activities in     total and 30 subjects in total, we have 180 rows with all combinations for each of the 79 features.
