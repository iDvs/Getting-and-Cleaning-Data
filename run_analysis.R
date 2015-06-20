url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "dataset.zip")
unzip("Dataset.zip",exdir = "./data",junkpaths = TRUE)

## Merges the training and the test sets to create one data set

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
features <- read.table("./data/features.txt")
colnames(m_data)<-c(as.vector(as.character(features[,2])),"activity","subject")

## Extracts only the measurements on the mean and standard deviation for each measurement
col<-grep("*mean*|*std*|subject|activity", names(m_data), ignore.case=TRUE)
ex_data<- m_data[,col]
## Using descriptive activity names to name the activities in the data set

labels <-read.table("./data/activity_labels.txt")
for(i in 1:dim(activity)[1]) { ex_data$activity[i]<-as.character(labels[(activity[i,1]),2]) }

## Appropriately labels the data set with descriptive variable names
names(ex_data)<-tolower(names(ex_data))
names(ex_data)<-gsub("^t", "time_", names(ex_data))
names(ex_data)<-gsub("^f", "frequency_", names(ex_data))
names(ex_data)<-gsub("-mean", "mean_", names(ex_data))
names(ex_data)<-gsub("-std", "std_", names(ex_data))
names(ex_data)<-gsub("-freq()", "frequency_", names(ex_data))
names(ex_data)<-gsub("bodybody", "body_", names(ex_data))
names(ex_data)<-gsub("acc", "accel_", names(ex_data))

## Tidy data
## From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.
library(data.table)
ex_data<- data.table(ex_data)
data<-ex_data[,lapply(.SD,mean),by="activity,subject"]
write.table(data,file="tidy.txt",sep=" ",row.names = FALSE)