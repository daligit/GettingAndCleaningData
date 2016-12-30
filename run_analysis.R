#Step 0. Download and unzip the files
#filesURL<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#files <- tempfile()
#files <- file.path(getwd(), "Dataset.zip")
#download.file(filesURL,files,method = "curl")
#unzip(files); unlink(files)

#Step1. Merge the training and the test sets to create one data set.

#note: as we prepare the Test and Training datasets for merging it seems easier to assign the activity labels
# (e.g. the rows) to each row in both data sets prior to merging them
#we also assign the subject identifiers to each row in both data sets prior to merging
#while we're at it, we can assign the appropriate labels to the data set (colums) with descriptive variable names

#read the variable names from the "features.txt" file, assign to vector vNames
vNames <-read.delim("UCI HAR Dataset/features.txt",sep = "",header = FALSE)
vNames <- as.vector(vNames[,2])

#first we prepare the test data
#read the Test data into a data frame called testData, add names of variables (as columns header)
testData<- read.delim("UCI HAR Dataset/test/X_test.txt",sep = "",header = FALSE,col.names = vNames)

#read the Test activity labels from "y_test.txt", add to temporary dataframe
VtestLabels <- read.delim("UCI HAR Dataset/test/y_test.txt",sep = "",header = FALSE,col.names = "Labels")

#read the subject IDs from "subject_test.txt", add to temporary dataframe
VtestSubjects <- read.delim("UCI HAR Dataset/test/subject_test.txt",sep = "",header = FALSE,col.names = "Subject")

#bind the temporary dataframes to add two new columns to the test data ("Labels" and "Subject")
testData <- cbind(VtestLabels,VtestSubjects,testData)

#then we repeat the same steps with the training data
#read the Training data into data frame called trainData, add names of variables (as columns header)
trainData<- read.delim("UCI HAR Dataset/train/X_train.txt",sep = "",header = FALSE,col.names = vNames)

#read the Training activity labels from "y_train.txt", add to temporaty dataframe
VtrainLabels <- read.delim("UCI HAR Dataset/train/y_train.txt",sep = "",header = FALSE,col.names = "Labels")

#read the subject IDs from "subject_train.txt", add to temporary dataframe
VtrainSubjects <- read.delim("UCI HAR Dataset/train/subject_train.txt",sep = "",header = FALSE,col.names = "Subject")

#bind the temporary dataframes to add two new columns to the test data ("Labels" and "Subject")
trainData <- cbind(VtrainLabels,VtrainSubjects,trainData)

#Merge the training and the test sets to create one data set called completeDataSet
completeDataSet <- rbind(trainData,testData)

#Step 2.Extract only the measurements on the mean and standard deviation for each measurement.
#preserve the activity Labels and Subject data
library(dplyr)
dataExtract <- completeDataSet %>% select(matches('Labels|Subject|mean|std'))

#Step 3. Uses descriptive activity names to name the activities in the data set
# since we already have the labels for each row, we just need to add the matching activity name as a new column
#we'll add that at the end so we can use the function aggregate() in Step5.

#Step4. Appropriately labels the data set with descriptive variable names.
#This was already done while preparing the date before merging the datasets (Step1)

#Step5. From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

#first we create a list of variables used by the aggregate() function for grouping results by suject and activity
Group <- list(dataExtract$Labels,dataExtract$Subject)

#then we calculate the mean of all values in the dataframe, using the grouping variables (Subject and Activity)
finalDataset <- aggregate.data.frame(dataExtract,Group,mean)

#we can get rid of the first two columns, 
finalDataset$Group.1 <- NULL; finalDataset$Group.2 <- NULL

#now is a good time to add the descriptive activity names to the dataset
#read activities full names from "activity_labels.txt", create vector mapping names to Labels (activity values) 
ANames <-read.delim("UCI HAR Dataset/activity_labels.txt",sep = "",header = FALSE)
ActivityCode <- as.numeric(ANames[,1]); names(ActivityCode) = ANames[,2]

#Add new "Activity" column to dataframe. with variable names matching Labels by row.
finalDataset$Activity <- names(ActivityCode)[match(finalDataset$Labels, ActivityCode)]

#Move that new column to the first column in the dataframe.
finalDataset <- finalDataset[,c(ncol(finalDataset),1:(ncol(finalDataset)-1))]

#Write the new tidy dataset to a new file named "TidyDataSet.txt" in the working directory
write.table(finalDataset,"TidyDataSet.txt",row.name=FALSE)
