# Getting-and-Cleaning-Data-Course-Project

Script run_analysis.R does the following:
- Read all available .txt files (get from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
UCI HAR Dataset/test/X_test.txt 		-> variable_test
UCI HAR Dataset/test/Y_test.txt 		-> activity_test 
UCI HAR Dataset/train/X_train.txt 		-> variable_train
UCI HAR Dataset/train/Y_train.txt		-> activity_train
UCI HAR Dataset/test/subject_test.txt	-> subject_test 
UCI HAR Dataset/train/subject_train.txt	-> subject_train
UCI HAR Dataset/features.txt			-> features
UCI HAR Dataset/activity_labels.txt		-> activity_labels

- Extracts only the measurements on the mean and standard deviation for each measurement.
variable_test and variable_train take only columns regarding mean and standard deviation
features data set contains full list of measurements
Details of measurements are given in source zipped data (in UCI HAR Dataset/features_info.txt)

- Merges the training and the test sets to create one data set.
variable_test is bound with subject_test and activity_test creating test data set
variable_train is bound with subject_train and activity_train creating train data set
test data set and train data set are bound in one data set (named full)

- Appropriately labels the data set with descriptive variable names.
descriptive variable names are get from features (only regarding mean and standard deviation)

- Uses descriptive activity names to name the activities in the data set
descriptive activity names are get from activity_labels
full data set is merged with activity_labels

- From the full data set creates a second, independent tidy data set with the average of each variable for each activity and each subject
gather function takes "variable" columns and collapses into key-value pairs, duplicating all other columns
dcast function returns mean value of each measurement for each activitiy and subject 
tidy data set is named full_average
full_average is written in tidy.txt file as result of the function
