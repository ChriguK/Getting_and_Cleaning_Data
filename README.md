# Getting and Cleaning Data
Getting and Cleaning Data Course Project on Coursera


## Objectives
The goal of this project is to provide an R script, called *run_analysis.R*, that prepares a tidy dataset from the [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The data stem from accelerometer and gyroscope measurements  of the Samsung Galaxy S II smartphone carried by **30 volunteers** (referred to as "subject") while performing **six activities** (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING).


## Data Provided
### Root directory
In the root directory of the unzipped UCI HAR Dataset, there is a *README.txt* on the experimental design, the files and the variables included in the dataset (for a more detailed description see [this link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)). The file *features_info.txt* also provides information on selected variables in the dataset. The two files were not called by *run_analysis.R*.

The text file *features.txt* includes a complete list of variables available after pre-processing the accelerometer and gyroscope measurements. The text file *activity_labels.txt* provides the activity labels to the six corresponding activity codes. The two text files were read into R by *run_analysis.R*, providing variable names and activity labels, respectively.

### Train and Test directories
The pre-processed measurements were randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. The training / test data were filed in the training / test directories, respectively. The train and test directories hold similar files and variables; file names differ only by suffix:

1. *X_train.txt* and *X_test.txt*: including 561 variables and 7352 (train) or 2947 (test) measurements.
2. *subject_train.txt* and *subject_test.txt*: the codes (one to thirty) of the 30 volunteers ("subjects") corresponding with the mearurements in X_train.txt and X_test.txt.
3. *Y_train.txt* and *Y_test.txt*: the activity codes (one to six) of the activities performed by the volunteers while conducting the measurements corresponding with the mearurements in X_train.txt and X_test.txt.

All files were read into R by *run_analysis.R*.

The Train and Test directories both hold another folder called *Inertial Signals*, each containing nine text files on accelerometer and gyroscope measurements. These files were disregarded  in this project, because the data of interest were summarized in *X_train.txt* and *X_test.txt*.

## Methods (How *run_analysis.R* works)
The R script requires the R add-on packages *dplyr* and *tidyr*. It reads the data from a directory called "UCI HAR Dataset", which is NOT in the working directory. If you want to run the script in your own setting, **make sure to adust the variable *data.dir* at the beginning of the script**.

The script performs the following tasks:
1. Read in all data (see section on *Data Provided* above).
2. Extract only the measurements on the mean and standard deviation for each measurement. (Note: There has been a lot of discussion going on in the Forum on the task ["Extracts only the measurements on the mean and standard deviation for each measurement"](https://class.coursera.org/getdata-030/forum/thread?thread_id=215). Here, *run_analysis.R* selects only variables that have *mean()* or *std()* in their variable name. Variables with *meanFreq()* in their names or on angles of means of variables (e.g. *angle(tBodyAccMean,gravity)*, *angle(tBodyAccJerkMean),gravityMean)*) were not selected, because there is no corresponding standard deviation available.)
3. Merge the training sets and the test sets to create one data set including (i) the mean and standard deviation for each measurement (see step 2.), (ii) subject codes, (iii) activity codes and (iv) the variable "set" which indicates whether the measurement was derived from the training set or the test set.
4. Appropriately label the data set with descriptive variable names:
    1. Remove parenthesis
    2. Convert variable names to lowercase.
    3. Substitute prefix "f" with "frequency-" (preparation for step 6).
    4. Substitute prefix "t" with "time-" (preparation for step 6). 
5. Use descriptive activity names from *activity_labels.txt* to name the activities in the data set.
6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
7. Write the result to a text file (no row names).

The **tidy dataset** from step 6 is described in [*CodeBook.md*](https://github.com/ChriguK/Getting_and_Cleaning_Data/blob/master/CodeBook.md). It describes the variables, the data, and any transformations or work that was done to clean up the data.