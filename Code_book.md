---
title: "Code_book"
output: 
    html_document:
        theme: united
        toc: yes
---

## Source data ##

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Files ##

The dataset includes the following files:


- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'X_train.txt': Training set.
- 'y_train.txt': Training labels.
- 'X_test.txt': Test set.
- 'y_test.txt': Test labels.
- subject_train.txt. 
- subject_test.txt.

Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Reading data ##

- "X_train.txt" is read to variable "x_train".
- "X_test.txt" is read to variable "x_test".

Train and test data is merged to the variable "x".

- "y_train.txt" -  "y_train".
- "y_test.txt" - "y_test".

Test and train activity data is merged to the variable "y".

- "subject_train.txt" -"s_train".
- "subject_test.txt" - "s_test".

Test and train data is merged to the variable "subject".

- "X" (mesurements), "y" (activities) and "subject" is merged to the "m_data".
- "features.txt" - "features" (names of the mesurement data).

The "colnames" command is used to set columns names of m_data fom the character vector.
This vector is created from "features" datа and two characters "subject" and "activites".

Use grep command to extract only mesurements of "std" and "mean" to the data frame "ex_data".

- "activity_labels.txt" is read to the variable "labels".

Variable "lables" is used to set descriptive activity names in "ex_data" (data in activity column is changed).

Names of "ex_data" is changed to more descriptive by "gsub" command.

Create tidy data farme ("data") by lapply command.

## Output

tidy.txt file created with write.table() using row.name=FALSE from "data" data frame.
