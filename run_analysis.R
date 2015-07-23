############################################################################
#
# This R script prepares a tidy dataset from the UCI HAR Dataset.
# For more information visit:
# https://github.com/ChriguK/Getting_and_Cleaning_Data/blob/master/README.md
#
############################################################################

library(dplyr)
library(tidyr)

data.dir <- file.path("..", "UCI HAR Dataset")
train.dir <- file.path(data.dir, "train")
test.dir <- file.path(data.dir, "test")

# Read data and extract only the measurements on the mean and standard deviation for each measurement. 

feature.labels <- read.table(file.path(data.dir, "features.txt"), row.names=1, col.names=c("feature.code", "feature.label"), stringsAsFactors=F)
idx <- grep("mean\\(\\)|std\\(\\)", feature.labels$feature.label)

activity.labels <- read.table(file.path(data.dir, "activity_labels.txt"), col.names=c("activity.code", "activity.label"), stringsAsFactors=F)

subject.train <- scan(file.path(train.dir, "subject_train.txt"))
activity.train <- scan(file.path(train.dir, "Y_train.txt"))
features.train <- tbl_df(read.table(file.path(train.dir, "X_train.txt")))
features.train <- features.train[, idx]

subject.test <- scan(file.path(test.dir, "subject_test.txt"))
activity.test <- scan(file.path(test.dir, "Y_test.txt"))
features.test <- tbl_df(read.table(file.path(test.dir, "X_test.txt")))
features.test <- features.test[, idx]

# Merges the training and the test sets to create one data set.

features.train <- mutate(features.train, subject = subject.train, activity = activity.train, set="train")
features.test <- mutate(features.test, subject = subject.test, activity = activity.test, set="test")
data <- bind_rows(features.train, features.test)

# Appropriately labels the data set with descriptive variable names.
feature.labels <- feature.labels$feature.label[idx]
feature.labels <- gsub("\\(\\)", "", feature.labels)
feature.labels <- gsub("^t", "time-", feature.labels)
feature.labels <- gsub("^f", "frequency-", feature.labels)
feature.labels <- tolower(feature.labels)
names(data) <- c(feature.labels, "subject", "activity.code", "set")

# Uses descriptive activity names to name the activities in the data set
data <- inner_join(data, activity.labels)

# From the data set produces in the previous step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy.data <- data %>%
                select(-activity.code, -set) %>%
                group_by(subject, activity.label) %>%
                summarise_each(funs(mean)) %>% 
                gather(feature, value, -subject, -activity.label) %>%
                separate(feature, c("domain", "feature", "statistical.measure", "direction"), extra="drop") %>%
                spread(statistical.measure, value) %>%
                rename(activity = activity.label)

write.table(tidy.data, "tidydata.txt", row.names=F)
