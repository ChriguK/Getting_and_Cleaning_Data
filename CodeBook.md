# Code Book
This Code Book describes the variables, the data, and any transformations or work that was done to clean up the tidy dataset produced for the Getting and Cleaning Data Course Project on Coursera. Information on the original data can be found in [*README.md*](https://github.com/ChriguK/Getting_and_Cleaning_Data/blob/master/README.md) and the references therein.

## Variables

* **subject:** Person that volunteered in carrying a smartphone that performed accelerometer and gyroscope measurements.
* **activity:** Activity the subject performed while the smartphone carried out accelerometer and gyroscope measurements.
* **domain:** Domain of the signal (either frequency or time).
* **feature:** Feature derived from accelerometer and gyroscope measurements (for details see *features_info.txt* in the [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)).
* **direction:** Direction of the axial signals.
* **mean:** Mean of the (preprocessed) accelerometer and gyroscope measurements by subject, activity, domain, feature and direction.
* **std:** Standard deviation of the (preprocessed) accelerometer and gyroscope measurements by subject, activity, domain, feature and direction.

## Data

### Subject
* **Values:** Integers from 1 to 30.
* **Origin:** *subject_train.txt* and *subject_test.txt*
* **Transformation:** 
    1. Data from *subject_train.txt* were merged with selected variables from *X_train.txt* using the R command *mutate* (add-on package *dplyr*)
    2. Data from *subject_test.txt* were merger with selected variables from *X_test.txt* using the R command *mutate* (add-on package *dplyr*)
    3. The two merged datasets were combined using the R command *bind_rows* (add-on package *dplyr*)
    4. **Subject** (together with **Activity**) was used as a grouping variabe that summarized **Mean** and **Standard Deviation** using the R command *group_by* (add-on package *dplyr*)
    
### Activity
* **Values:** LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
* **Origin:**
    * Activity Codes (integers from 1 to 6): *Y_train.txt* and *Y_test.txt*
    * Activity Labes (see **Values** above): *activity_labels.txt*
* **Transformation:**
    1. Data from *Y_train.txt* were merged with selected variables from *X_train.txt* using the R command *mutate* (add-on package *dplyr*)
    2. Data from *Y_test.txt* were merger with selected variables from *X_test.txt* using the R command *mutate* (add-on package *dplyr*)
    3. The two merged datasets were combined using the R command *bind_rows* (add-on package *dplyr*)
    4. **Activity Codes** were linked to **Activity Labes** using the R command *inner_join* (add-on package *dplyr*)
    5. **Activity Codes** were dropped using the R command *select* (add-on package *dplyr*)
    6. The variable **Activity Labes** was renamed to **Activity** using the R command *rename* (add-on package *dplyr*)
    4. **Activity** (together with **Subject**) was used as a grouping variabe that summarized **Mean** and **Standard Deviation** using the R command *group_by* (add-on package *dplyr*)

### Domain
* **Values:** frequency, time
* **Origin:** 
    * Labels: *features.txt*
    * Data: *X_train.txt* and *X_test.txt*
* **Transformation:**
    1. Preprocessing (as outlined in [*README.md*](https://github.com/ChriguK/Getting_and_Cleaning_Data/blob/master/README.md))
        * Labels :
            1. Only labels for measurements on the mean and standard deviation for each measurement were selected using regular expressions and the R command *grep* (search for labels that include the substrings *mean()* or *std()*)
            2. Parenthesis in the labels were removed using regular expressions and the R command *gsub*
            3. Labels were converted to lowercase using the R command *tolower*
            4. The prefix "f" was subsituted with "frequency-" using regular expressions and the R command *gsub*, enabling a simple extraction of **Domain** after preprocessing
            5. The prefix "t" was subsituted with "time-" using regular expressions and the R command *gsub*, enabling a simple extraction of **Domain** after preprocessing
        * Data:
            1. Only measurements on the mean and standard deviation for each measurement were selected from *X_train.txt* (see step 1 in Labels)
            2. Only measurements on the mean and standard deviation for each measurement were selected from *X_test.txt* (see step 1 in Labels)
            3. The two datasets from steps 1 and 2 were combined using the R command *bind_rows* (add-on package *dplyr*)
            4. The data in the resulting data set were averaged for each measurement on the mean and standard deviation, for each **Activity** and each **Subject** using the R commands *group_by* and *summarise_each* (add-on package *dplyr*) and *mean*
            5. The means of measurements on the mean and standard deviation, which were still organized in 66 columns ("wide format"), were collapsed into key-value pairs ("long format") using the R command *gather* (add-on package *tidyr*)
    2. After preprocessing, the derived key-value pairs included information on **Domain**, **Feature**, **Direction** and statistical measure (mean or standard deviation). **Domain** was extracted by using the R command *separate* (add-on package *tidyr*)
    
### Feature
* **Values:** bodyacc, bodyaccjerk, bodyaccmag, bodybodyaccjerkmag, bodybodygyrojerkmag, bodybodygyromag, bodygyro, bodyaccjerkmag, bodygyrojerk, bodygyrojerkmag, bodygyromag, gravityacc, gravityaccmag
* **Origin:** 
    * Labels: *features.txt*
    * Data: *X_train.txt* and *X_test.txt*
* **Transformation:**
    1. Preprocessing (as outlined in [*README.md*](https://github.com/ChriguK/Getting_and_Cleaning_Data/blob/master/README.md))
        * Labels :
            1. Only labels for measurements on the mean and standard deviation for each measurement were selected using regular expressions and the R command *grep* (search for labels that include the substrings *mean()* or *std()*)
            2. Parenthesis in the labels were removed using regular expressions and the R command *gsub*
            3. Labels were converted to lowercase using the R command *tolower*
            4. The prefix "f" was subsituted with "frequency-" using regular expressions and the R command *gsub*, enabling a simple extraction of **Domain** after preprocessing
            5. The prefix "t" was subsituted with "time-" using regular expressions and the R command *gsub*, enabling a simple extraction of **Domain** after preprocessing
        * Data:
            1. Only measurements on the mean and standard deviation for each measurement were selected from *X_train.txt* (see step 1 in Labels)
            2. Only measurements on the mean and standard deviation for each measurement were selected from *X_test.txt* (see step 1 in Labels)
            3. The two datasets from steps 1 and 2 were combined using the R command *bind_rows* (add-on package *dplyr*)
            4. The data in the resulting data set were averaged for each measurement on the mean and standard deviation, for each **Activity** and each **Subject** using the R commands *group_by* and *summarise_each* (add-on package *dplyr*) and *mean*
            5. The means of measurements on the mean and standard deviation, which were still organized in 66 columns ("wide format"), were collapsed into key-value pairs ("long format") using the R command *gather* (add-on package *tidyr*)
    2. After preprocessing, the derived key-value pairs included information on **Domain**, **Feature**, **Direction** and statistical measure (mean or standard deviation). **Feature** was extracted by using the R command *separate* (add-on package *tidyr*)

### Direction
* **Values:** x, y, z, NA (not available)
* **Origin:** 
    * Labels: *features.txt*
    * Data: *X_train.txt* and *X_test.txt*
* **Transformation:**
    1. Preprocessing (as outlined in [*README.md*](https://github.com/ChriguK/Getting_and_Cleaning_Data/blob/master/README.md))
        * Labels :
            1. Only labels for measurements on the mean and standard deviation for each measurement were selected using regular expressions and the R command *grep* (search for labels that include the substrings *mean()* or *std()*)
            2. Parenthesis in the labels were removed using regular expressions and the R command *gsub*
            3. Labels were converted to lowercase using the R command *tolower*
            4. The prefix "f" was subsituted with "frequency-" using regular expressions and the R command *gsub*, enabling a simple extraction of **Domain** after preprocessing
            5. The prefix "t" was subsituted with "time-" using regular expressions and the R command *gsub*, enabling a simple extraction of **Domain** after preprocessing
        * Data:
            1. Only measurements on the mean and standard deviation for each measurement were selected from *X_train.txt* (see step 1 in Labels)
            2. Only measurements on the mean and standard deviation for each measurement were selected from *X_test.txt* (see step 1 in Labels)
            3. The two datasets from steps 1 and 2 were combined using the R command *bind_rows* (add-on package *dplyr*)
            4. The data in the resulting data set were averaged for each measurement on the mean and standard deviation, for each **Activity** and each **Subject** using the R commands *group_by* and *summarise_each* (add-on package *dplyr*) and *mean*
            5. The means of measurements on the mean and standard deviation, which were still organized in 66 columns ("wide format"), were collapsed into key-value pairs ("long format") using the R command *gather* (add-on package *tidyr*)
    2. After preprocessing, the derived key-value pairs included information on **Domain**, **Feature**, **Direction** and statistical measure (mean or standard deviation). **Direction** was extracted by using the R command *separate* (add-on package *tidyr*)

### Mean and Standard Deviation
* **Values:** bounded within [-1,1]
* **Origin:** 
    * Labels: *features.txt*
    * Data: *X_train.txt* and *X_test.txt*
* **Transformation:**
    1. Preprocessing (as outlined in [*README.md*](https://github.com/ChriguK/Getting_and_Cleaning_Data/blob/master/README.md))
        * Labels :
            1. Only labels for measurements on the mean and standard deviation for each measurement were selected using regular expressions and the R command *grep* (search for labels that include the substrings *mean()* or *std()*)
            2. Parenthesis in the labels were removed using regular expressions and the R command *gsub*
            3. Labels were converted to lowercase using the R command *tolower*
            4. The prefix "f" was subsituted with "frequency-" using regular expressions and the R command *gsub*, enabling a simple extraction of **Domain** after preprocessing
            5. The prefix "t" was subsituted with "time-" using regular expressions and the R command *gsub*, enabling a simple extraction of **Domain** after preprocessing
        * Data:
            1. Only measurements on the mean and standard deviation for each measurement were selected from *X_train.txt* (see step 1 in Labels)
            2. Only measurements on the mean and standard deviation for each measurement were selected from *X_test.txt* (see step 1 in Labels)
            3. The two datasets from steps 1 and 2 were combined using the R command *bind_rows* (add-on package *dplyr*)
            4. The data in the resulting data set were averaged for each measurement on the mean and standard deviation, for each **Activity** and each **Subject** using the R commands *group_by* and *summarise_each* (add-on package *dplyr*) and *mean*
            5. The means of measurements on the mean and standard deviation, which were still organized in 66 columns ("wide format"), were collapsed into key-value pairs ("long format") using the R command *gather* (add-on package *tidyr*)
            6. The derived key-value pairs included information on **Domain**, **Feature**, **Direction** and statistical measure (mean or standard deviation). The statistical measure was extracted by using the R command *separate* (add-on package *tidyr*)
    2. After preprocessing, the statistical measure (mean or standard deviation) needed to be separated in values on the *Mean* and on the *Standard Deviation*. The key-value pairs on statistical measures were spread across the two columns using the R command *spread* (add-on package *tidyr*)
