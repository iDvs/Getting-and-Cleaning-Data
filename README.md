---
title: "Information"
output: 
    html_document:
        theme: united
        toc: yes
---
## Introduction ##

The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 


## Data Souce ##

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:


- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'X_train.txt': Training set.
- 'y_train.txt': Training labels.
- 'X_test.txt': Test set.
- 'y_test.txt': Test labels.

And two files
- subject_train.txt 
- subject_test.txt 
Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Reading and unziping data ##
This part of code load and unzip the files to the working directory

```r
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"  # Setup URL of data
download.file(url, destfile = "dataset.zip")                                                     # loading data to the file    
unzip("dataset.zip",exdir = "./data",junkpaths = TRUE)                                           # Unzip data to the folder 
```
If the drgument "junkpaths" is TRUE, Unzip command use only the basename of the stored filepath when extracting.
We unzip the all files in the same directory/


## Merging the training and the test sets ##

Merges the training and the test sets to create one data set.

```r
x_train <- read.table("./data/X_train.txt")
x_test <- read.table("./data/X_test.txt")
x <- rbind(x_train,x_test)
y_train<-read.table("./data/y_train.txt")
y_test<-read.table("./data/y_test.txt")
activity<- rbind (y_train,y_test)
s_train <- read.table("./data/subject_train.txt")
s_test  <- read.table("./data/subject_test.txt")
subject<-rbind(s_train,s_test)
m_data<-cbind(x,activity,subject)
```

## Extracting the measurements ##


Extracts only the measurements on the mean and standard deviation for each measurement.

```r
col<-grep("*mean*|*std*|subject|activity", names(m_data), ignore.case=TRUE)
ex_data<- m_data[,col]
```

## Using descriptive activity names ##

Using descriptive activity names to name the activities in the data set
```r
labels <-read.table("./data/activity_labels.txt")
for(i in 1:dim(activity)[1]) { ex_data$activity[i]<-as.character(labels[(activity[i,1]),2]) }
```

## Appropriately labels the data set with descriptive variable names ##

All variable use a lower letters
"t" -  can be replaced with "time"
"f"  - can be replaced with "frequency"
"-mean" to "mean_"
"-std" to "std_"
"-freq" to "frequency"
"bodybody" - to "body" 
"acc" - to "accel"

```r
names(ex_data)<-tolower(names(ex_data))
names(ex_data)<-gsub("^t", "time_", names(ex_data))
names(ex_data)<-gsub("^f", "frequency_", names(ex_data))
names(ex_data)<-gsub("-mean", "mean_", names(ex_data))
names(ex_data)<-gsub("-std", "std_", names(ex_data))
names(ex_data)<-gsub("-freq()", "frequency_", names(ex_data))
names(ex_data)<-gsub("bodybody", "body_", names(ex_data))
names(ex_data)<-gsub("acc", "accel_", names(ex_data))
```
## Tidy data ##

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

```r
library(data.table)
ex_data<- data.table(ex_data)
data<-ex_data[,lapply(.SD,mean),by="activity,subject"]
write.table(data,file="tidy.txt",sep=" ",row.names = FALSE)
```
