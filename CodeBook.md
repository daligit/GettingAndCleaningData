CodeBook
================

Credits
=======

The data used for this assignment is the "Human Activity Recognition Using Smartphones Data Set" created by Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

The data and description can be found at <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Overview
========

Original data files
-------------------

The data was collected from the accelerometers and gyroscope from the Samsung Galaxy S smartphone. All files and descriptive txt files are included in a zip file which contains a primary folder named "UCI HAR Dataset". This folder includes 4 text files and 2 sub-folders.

The 4 text files are:

-   readme.txt: provides an overview of the experiments and data collected. In short: a group of 30 volunteers performed six different physical activities while wearing the smartphone. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. When merged together, the "training data"" and the "test data" consist of 10,299 observations (each called a "feature vector" by the authors) of 561 variables.

-   features\_info.txt provides an overview of the dataset's features. 3-axial raw signals from the accelerometer and gyroscope were filtered to eliminate noise and processed to generate data relative to body and gravity acceleration, as well as other signals, magnitude, frequency and various statistical measures.

-   features.txt contains the complete list of 561 features (e.g. variables captured or calculated for each observation). This file in important for the purpose of naming the variables in the datatset (e.g. columns).

-   activity\_labels.txt describes the physical activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING). This file is important for the purpose of assigning a descriptive activity name to each observation (e.g. rows)

The sub-folders, respectively named "test" and "train" contain:

-   the data as single space separated text files ("X\_test.txt" and "X\_train.txt"). The data is numerical. Each row of the text file is a feature vector (561 variables each), matching the 561 features descriptions. All values are normalized and bounded within -1,1. There are no missing values.

-   the activity labels as text files ("y\_test.txt" and "y\_train.txt"). Possible values are integers (1 through 6), corresponding to the activity\_labels. The number of observations matches the respective data files (train and test), respectively 7,352 and 2,947.

-   the subjects ID (e.g. volunteers) as text files ("subject\_test.txt" and "subject\_train.txt". Possible values are integers (1 through 30), corresponding to the 30 participants. The number of observations also matches the respective data files (train and test).

Both of the "test" and "train" sub-folders each include a sub-folder named "Inertial Signals", which can be ignored for the purpose of this assignment.

The assignment
--------------

Create one R script called run\_analysis.R that does the following:

1.  Merge the training and the test sets to create one data set.

2.  Extract only the measurements on the mean and standard deviation for each measurement.

3.  Use descriptive activity names to name the activities in the data set.

4.  Appropriately label the data set with descriptive variable names.

5.  From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

New dataset
-----------

Besides this CodeBook.md and the ReadMe files, this repo contains the tidy dataset ("TidyDataSet.txt")" meeting the requirements above, as well as the script ("run\_analysis.R") which generated it.

For the purpose of making future analysis as easy as possible, I chose to write the resulting tidy dataset as a .txt file, while preserving the data labels that I added during the assignment (Activity, Labels (activity ID), and Subject).

I also chose to preserve the original names of the variables (e.g. 86 of the original 561 "features" listed in the "features.txt" file). All numerical values are bounded within -1,1.

PLEASE NOTE: each value in the "TidyDataSet.txt" file" is the mean of all observed values by Subject (participant) and Activity in the original dataset. There could be some confusion since some of the data is labeled "std". For example, the values for the "tBodyAcc.std...X" columns is now really the MEAN of all the observed values for the standard deviation of the "timed body accceleration signals on the X axis", by participant and activity.

Last but not least, I was not sure how to interpret the variables containing the "meanFreq" data. It seems to me that it is possible to consider them a mean measurement - or not, depending on the person's point of view. Since it will be easier to delete them than to resuscitate them for future analysis, I chose to keep them.

The script
----------

I have documented the scrip itself at each step of the way. As per assignment instructions, I am providing a walkthrough in the README.md file.

---end of CodeBook---
