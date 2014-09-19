# Getting and Cleaning Data Course Project
# Cheng-Han Yu
# 09/18/2014
#############################################################################
# Here are the data for the project: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for 
#    each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. Creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject. 
##############################################################################
rm(list = ls())
library(reshape2)
setwd("~/Documents/coursera/Data Cleaning")
ac
##############################################################################
# 1.
####
features <- read.table("./UCI HAR Dataset/features.txt", sep = "", 
                       header = FALSE)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                              sep = "", header = FALSE)
# train data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", sep = "", 
                      header = FALSE)
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt", sep = "", 
                      header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                            sep = "", header = FALSE)
colnames(X_train) <- features[, 2]
colnames(Y_train) <- "activity_no"
colnames(subject_train) <- "subject_no"
colnames(activity_labels) <- c("activity_no", "activity_name")
train_data <- cbind(subject_train, Y_train, X_train)

# test data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", sep = "", 
                      header = FALSE)
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt", sep = "", 
                      header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                            sep = "", header = FALSE)
colnames(X_test) <- features[, 2]
colnames(Y_test) <- "activity_no"
colnames(subject_test) <- "subject_no"
test_data <- cbind(subject_test, Y_test, X_test)

# merge the training and the test sets to create one data set
dataset <- rbind(train_data, test_data)

##############################################################################
# 2.
####
#grep(".*mean.*|.*std.*", names, value = TRUE) 
#grep("mean|std", names, value = TRUE) 
#grepl("mean|std", names)
#!grepl("meanFreq", names)
# sum(grepl("std", names))

# create a logical vector to extract mean and std
extract <- grepl("mean|std", colnames(dataset)) & 
    !grepl("meanFreq", colnames(dataset))
# Extract only the measurements on the mean and standard deviation for 
# each measurement.
extract_data <- cbind(dataset[, 1:2], dataset[, extract])
colNames <- colnames(extract_data)

##############################################################################
# 3.
####
# Use descriptive activity names to name the activities in the data set
num <- 1
extract_data$activity <- extract_data$activity_no
colnames(extract_data) <- c(colNames, "activity")
for (name in activity_labels$activity_name) {
    # replace number by name
    #     1 1   WALKING
    #     2	2	WALKING_UPSTAIRS
    #     3	3	WALKING_DOWNSTAIRS
    #     4	4	SITTING
    #     5	5	STANDING
    #     6	6	LAYING
    extract_data$activity <- gsub(num, name, extract_data$activity)
    num <- num + 1
}
attach(extract_data)
extractData <- cbind(extract_data[, 1:2], activity, 
                     extract_data[, 3:(dim(extract_data)[2] - 1)])
#colnames(extractData)
detach(extract_data)

##############################################################################
# 4.
####
# Appropriately labels the data set with descriptive variable names
colnames(extractData) <- gsub("\\()", "", colnames(extractData))
colnames(extractData) <- gsub("-mean", "Mean", colnames(extractData))
colnames(extractData) <- gsub("-std", "Std", colnames(extractData))
colnames(extractData) <- gsub("^t", "time", colnames(extractData))
colnames(extractData) <- gsub("^f", "freq", colnames(extractData))
# colnames(extractData)

##############################################################################
# 5.
####
tidyData <- aggregate(
    extractData[, colnames(extractData) != c("subject_no", "activity_no",
                                             "activity")], 
    by = list(activity_name = extractData$activity, 
              subject = extractData$subject_no), mean)

tidyData <- merge(tidyData, activity_labels, by = 'activity_name', 
                  all.x = TRUE)
tidyData <- tidyData[order(tidyData$subject), ]

t




