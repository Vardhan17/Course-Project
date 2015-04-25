# Assumed that you have unzipped the "getdata-projectfiles-UCI HAR Dataset" file in your working directory
# load library(plyr)

# Step -1 Merge the data together

# Reading of the column names from features.txt file - around 561 col names 
features <- read.table("./UCI HAR Dataset/features.txt")
features <- as.character(features[ , 2])

# Reading of 3 txt files in "test" folder to 3 variables
x.test <- read.table("./UCI HAR Dataset/test/X_test.txt")                       # dim() - [1] 2947  561 
y.test <- read.table("./UCI HAR Dataset/test/y_test.txt")                       # dim() - [1] 2947  1
subj.test <- read.table("./UCI HAR Dataset/test/subject_test.txt")              # dim() - [1] 2947  1

# using cbind() to make a data frame - test_df and naming the columns of the d.f.
test_df <- cbind(subj.test, y.test, x.test)                                     # dim() - [1] 2947  563
names(test_df) <- c("Subject", "Activity", features)

# Reading of 3 txt files in "train" folder to 3 variables
x.train <- read.table("./UCI HAR Dataset/train/X_train.txt")                    # dim() - [1] 7352  561
y.train <- read.table("./UCI HAR Dataset/train/y_train.txt")                    # dim() - [1] 7352  1            
subj.train <- read.table("./UCI HAR Dataset/train/subject_train.txt")           # dim() - [1] 7352  1

# using cbind() to make a data frame - train_df and naming the columns of the d.f.
train_df <- cbind(subj.train, y.train, x.train)                                 # dim() - [1] 7352  563
names(train_df) <- c("Subject", "Activity", features)

# using rbind to merge the test_df and train_df by rows 
merged_df <- rbind(train_df, test_df)                                           # dim() - [1] 10299   563

# Step - 2 extracts only the measurements on the mean and standard deviation for each measurement.

# Use grep to get the col nos containg mean & std in col_select
col_select <- grep("mean", names(merged_df))
col_select <- c(col_select, grep("std", names(merged_df)))
col_select <- sort(col_select)

# Subset the colnames containing mean & std - 79 columns              
merged_df <- merged_df[ , c(1, 2 , col_select) ]                                # dim() - [1] 10299   81


# Step - 3 Uses descriptive activity names to name the activities in the data set

# Looping to give activity labels in the "Activity" column
for( i in 1:6) {    
    activity_list <- c("WALKING", 
                       "WALKING_UPSTAIRS", 
                       "WALKING_DOWNSTAIRS", 
                       "SITTING", 
                       "STANDING",
                       "SLEEPING")    
    merged_df[merged_df$Activity == i, 2] <- activity_list[i]
}


# Step - 4 Appropriately labels the data set with descriptive variable names. 
# Already performed while giving names to train_df and test_df

# Step - 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Using the ddply() from plyr package calculating column mean for each col grouped by Subject, Activity
library(plyr)
modify_mean_df <- ddply(merged_df, .(Subject, Activity), colwise(mean))


# Final - Writing the output of the 2nd dataset into a text file  

write.table(modify_mean_df, file = "Project_Work.txt", row.names = FALSE)
