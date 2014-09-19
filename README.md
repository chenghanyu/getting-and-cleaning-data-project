Getting and Cleaning Data Course Project
========================================

This repo is for the course project of the course ``getting and cleaning data'' offered by Johns Hopkins University from Coursera.

## Introduction to the Project
The purpose of this project is to demonstrate our ability to collect and clean a data set. The goal is to prepare tidy data that can be used for later analysis. There are three files in this repo. The dataset and its full description can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). One can aslo download the data package via this [website](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).  

## Files in the repo
There are three files in this repo, run_analysis.R, README.md, and CookBook.md.

### run_analysis.R
The R script ```run_analysis.R``` does the followings for the project.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### README.md
README.md includes all the information about this repo, for example, why creates this repo and how the R script works.

### CodeBook.md
CodeBook.md describes the variables in the dataset.


## Explanation on ```run_analysis.R```
Before getting and working with data, we clear the workspace the set the working directory at ```"~/Documents/coursera/Data Cleaning"```, and then download the data set from the website provided previously.

 1. Load the data into R. In addition to ```features``` and ```activity_labels```, data ```subject_train```, ```Y_train```, ```X_train``` form a data frame ```train_data```.  ```test_data``` is generated similarly. A merged data set called ```dataset``` is constructed by row binding ```train_data``` and ```test_data```.
 
 2. First create a logical vector ```extract``` using ```grepl()``` function to extract variables associated with mean and standard deviation. The ```extract_data```, a data set subsetted from ```dataset``` by the vector ```extract```, contains only the measurements on the mean and standard deviation for each measurement.

 3. Create a new column variable ```activity``` that describes the activity names into ```extract_data``` through matching activity numbers and names in ```activity_labels```. The new data set is called ```extractData```.

 4. Using the commend ```gsub()``` to rename the variables in ```extractData```. 

 5. Using ```aggregate()``` function to create another data set called ```tidyData``` with the average of each variable for each activity and each subject. Then write this data to the file ```tidyData.txt```.
