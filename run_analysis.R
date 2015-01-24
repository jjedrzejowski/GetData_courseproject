## run_analysis.R
## script for analytic tasks required by course project in Getting Data course
## requires that directory with Samsung data be present in the current directory
## also requires that file "descriptives.txt" be present in the current directory

## load necessary libraries
library(dplyr)
library(reshape2)

## loads labels for original data
labels<-read.table("./UCI HAR Dataset/features.txt")
## loads table for translating activities
Activities<-read.table("./UCI HAR Dataset/activity_labels.txt")

## read data into test dataframe
test<-read.table('./UCI HAR Dataset/test/X_test.txt')
## attach original variable names
colnames(test)<-labels$V2
## read in the subject and activity vectors
Subject<-scan("./UCI HAR Dataset/test/subject_test.txt")
Activity<-scan("./UCI HAR Dataset/test/y_test.txt")
## bind the subject and activity variables to the test dataframe
test<-cbind(Subject, Activity, test)

## repeat the steps done for test data to create and label training dataframe
training<-read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(training)<-labels$V2
Subject<-scan("./UCI HAR Dataset/train/subject_train.txt")
Activity<-scan("./UCI HAR Dataset/train/y_train.txt")
training<-cbind(Subject, Activity, training)

## Step 1: merge test and training data
dataSet1<-rbind(test, training)
## this needs to be done, as there are two additional columns
labels<-names(dataSet1)

## identify variables that contain mean and std
variables <- (grepl("-mean",labels)&!grepl("Freq",labels))|grepl("-std",labels)
## Step 2: extract only measurements on mean and std
dataSet2<-cbind(dataSet1["Subject"], dataSet1["Activity"], dataSet1[c(variables)])

## Step 3: replace activity id with descriptive names
dataSet3<-merge(dataSet2, Activities, by.y="V1", by.x="Activity")
dataSet3<-dataSet3[-1]

## Step 4: assign descriptive variable names
## requires file with descriptive names in the current directory
descriptiveLabels<-scan("./descriptives.txt", what="character")
## assign names
colnames(dataSet3)<-c(descriptiveLabels)

## Step 5: create tidy data set with average of each variable for each activity and each subject
dataSet4 <- melt(dataSet3, c("Subject", "Activity"))
tidyData <- dcast(dataSet4, Subject + Activity ~ variable, mean)

## save the dataset into file tidyData.txt
write.table(tidyData, "./tidyData.txt", row.names=FALSE)


