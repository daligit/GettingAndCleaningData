ReadMe
================
December 30, 2016

Getting and Cleaning Data Course Project - Week4 assignment.
============================================================

The purpose of this assignment is to gather and clean data related wearable computing (in this case, Samsung devices), in order prepare a tidy file for future analysis.

This assignment requires the submission of 4 files:
---------------------------------------------------

1.  a README.md file (e.g. this file).
2.  a tidy data set, included in this repo as "TidyDataSet.txt.
3.  the script for performing the analysis, which generated the tidy data set. It is included in this repo as "run\_analysis.R".
4.  a code book ("CodeBook.md") describing the variables, the data, and work performed to process the data.

The assignment
--------------

Create one R script called "run\_analysis.R"" that does the following:

1.  Merge the training and the test sets to create one data set.
2.  Extract only the measurements on the mean and standard deviation for each measurement.
3.  Use descriptive activity names to name the activities in the data set.
4.  Appropriately label the data set with descriptive variable names.
5.  From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

The script
==========

Here is a quick walkthrough of the sequence of data manipulations. I have documented the scrip itself at each step of the way. Without comments, the script has 21 lines of codes. Please note that the script will load the dplyr package.

It seems to me that it was easier and more logical to accomplish the steps of the assignment in a slightly different order.

Step 0. Download and unzip the files:
-------------------------------------

The script file (as saved) will perform the analysis if the target zip file has been previously downloaded and unzipped in the working directory. Here is the file source <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

However, I have also left the code that does that in the script. In the event someone (or I) would want to start from scratch, just remove the \# signs.

Step 1. Merge the training and the test sets to create one data set.
--------------------------------------------------------------------

While preparing the "Test"" and "Training"" datasets, it seemed easier to do a few things prior to merging them, specifically:

-   assign the activity labels to each row

-   assign the subject identifiers to each row

-   assign the appropriate labels to the data set with descriptive names of each variable (columns)

In other words, I processed the "test" and "train" files separately, before merging them. This made it easy to read the files and verify that the number of rows for the "label files" (such as "y\_test.txt"" for activity Label, or "subject\_test.txt" for Subject) were the same as the number of row of the "test" data itself. The same goes for the "train" data - as well as the number of columns for both the "test" and "train" data.

It added the row labels (Labels and Subject) with the cbind() function after reading the corresponding files into dataframes - and added the column names using colnames while reading the data files. Finally, I used the rbind() function to merge the new "test" and "train" dataframes into one single dataframe.

Step 2.Extract only the measurements on the mean and standard deviation for each measurement.
---------------------------------------------------------------------------------------------

For this, the script is loading the dplyr package in order to use the select(matches()) nested functions.

`dataExtract <- completeDataSet %>% select(matches('Labels|Subject|mean|std'))`

This allowed me to only retain the columns containing the Labels (activity), Subject (participant ID) and all mean and standard deviation measurements.

I was not sure how to interpret the variables containing the "meanFreq" data. It seems to me that it is possible to consider them a mean measurement - or not, depending on the person's point of view. Since it will be easier to delete them than to resuscitate them for future analysis, I chose to keep them.

Step 3. Uses descriptive activity names to name the activities in the data set
------------------------------------------------------------------------------

Having already added the Labels for each row, in Step 1, I would just have to add the corresponding activity name as a new column, but I chose to do this at the end of Step 5, since the result is the same.

Step 4. Appropriately label the data set with descriptive variable names.
-------------------------------------------------------------------------

This was already done in Step1 while preparing the date before merging the "train" and "test" datasets (Step 1)

Step 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
-----------------------------------------------------------------------------------------------------------------------------------------------------

I used the aggregate.data.frame() function to calculate the mean of the variables by suject (Subject) and activity (Labels) and return the final dataframe.

`Group <- list(dataExtract$Labels,dataExtract$Subject)`

`finalDataset <- aggregate.data.frame(dataExtract,Group,mean)`

I cleaned up the final dataframe, by removing to redundant columns

`finalDataset$Group.1 <- NULL; finalDataset$Group.2 <- NULL`

Finally, I added the descriptive activity names to name the activities in the data set (initially "Step 3"") by adding a new "Activity" column to the dataframe. with activity names matching Labels by row, as first column in the final dataframe.

`finalDataset$Activity <- names(ActivityCode)[match(finalDataset$Labels, ActivityCode)]`

`finalDataset <- finalDataset[,c(ncol(finalDataset),1:(ncol(finalDataset)-1))]`

The script saves the final dataframe as a .txt file ("TidyDataSet.txt") in the working directory.

``` write.table(finaldataset,"tidydataset.txt",row.name=false)
```

License:
========

The dataset used for this assignment is located at <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012 This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited. Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

--- end of README.md---
