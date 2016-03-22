setwd("C:/Projects/R/Coursera")
library(dplyr)
library(tidyr)

#Read all .txt files
variable_test <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE)
activity_test <- read.table("./UCI HAR Dataset/test/Y_test.txt",header = FALSE)
variable_train <- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE)
activity_train <- read.table("./UCI HAR Dataset/train/Y_train.txt",header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE)
features <- read.table("./UCI HAR Dataset/features.txt",header = FALSE)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE)


#2.Extracts only the measurements on the mean and standard deviation for each measurement.
features[,2]<-as.character(features[,2])
features_msd_rows<-features[grepl("*mean()|std()*",features$V2)&!grepl("meanFreq()",features$V2),1]
variable_test<-variable_test[,features_msd_rows]
variable_train<-variable_train[,features_msd_rows]

#1.Merges the training and the test sets to create one data set.
test<-cbind(variable_test, subject_test, activity_test)
train<-cbind(variable_train, subject_train, activity_train)
full<-rbind(test,train)

#4.Appropriately labels the data set with descriptive variable names.
features_msd<-features[grepl("*mean()|std()*",features$V2)&!grepl("meanFreq()",features$V2),2]
names(full)<-c(features_msd,"subject","Act")

#3.Uses descriptive activity names to name the activities in the data set
activity_labels[,2]<-as.character(activity_labels[,2])
names(activity_labels)[2]<-"activity"
full<-full %>% merge(activity_labels,by.x="Act",by.y="V1",all=TRUE,sort = FALSE) %>% select(-1)


#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
full_average<-full %>% gather(variable, value, 1:(ncol(full)-2), na.rm= TRUE) %>% dcast(activity+subject~variable,mean)
write.table(full_average, "./tidy.txt", row.name = FALSE, quote = FALSE)