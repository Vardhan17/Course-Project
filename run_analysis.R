proj_analysis <- function() {
    
    features <- read.table("./UCI HAR Dataset/features.txt")
    features <- as.character(features[ , 2])
    
    x.test <- read.table("./UCI HAR Dataset/test/X_test.txt")
    y.test <- read.table("./UCI HAR Dataset/test/y_test.txt")
    subj.test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    
    test_df <- cbind(subj.test, y.test, x.test)
    names(test_df) <- c("Subject", "Activity", features)
    
    x.train <- read.table("./UCI HAR Dataset/train/X_train.txt")
    y.train <- read.table("./UCI HAR Dataset/train/y_train.txt")
    subj.train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    
    train_df <- cbind(subj.train, y.train, x.train)
    names(train_df) <- c("Subject", "Activity", features)
    
    
    merged_df <- rbind(train_df, test_df)
    
    col_select <- grep("mean", names(merged_df))
    col_select <- c(col_select, grep("std", names(merged_df)))
    col_select <- sort(col_select)
                    
    merged_df <- merged_df[ , c(1, 2 , col_select) ]
    
    for( i in 1:6) {
        
        activity_list <- c("WALKING", 
                           "WALKING_UPSTAIRS", 
                           "WALKING_DOWNSTAIRS", 
                           "SITTING", 
                           "STANDING",
                           "SLEEPING")
        
        merged_df[merged_df$Activity == i, 2] <- activity_list[i]
    }
    

    library(plyr)
    modify_mean_df <- ddply(merged_df, .(Subject, Activity), colwise(mean))
    
    
    
    modify_mean_df 
        
    
    
}





