---
title: "Codebook"
author: "Daniel Veit"
date: "June 21, 2020"
output: html_document
---

The `run_analysis.R` script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

##### 1. Download the dataset

-   Dataset downloaded and extracted under the folder called UCI HAR Dataset

##### 2. Assign each data to variables

-   `functions <- features.txt` : 561 rows, 2 columns
    *The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.*
-   `activities <- activity_labels.txt` : 6 rows, 2 columns
    *List of activities performed when the corresponding measurements were taken and its codes (labels)*
-   `subject_test <- test/subject_test.txt` : 2947 rows, 1 column
    *contains test data of 9/30 volunteer test subjects being observed*
-   `xtest <- test/X_test.txt` : 2947 rows, 561 columns
    *contains recorded features test data*
-   `ytest <- test/y_test.txt` : 2947 rows, 1 columns
    *contains test data of activities’code labels*
-   `subject_train <- test/subject_train.txt` : 7352 rows, 1 column
    *contains train data of 21/30 volunteer subjects being observed*
-   `xtrain <- test/X_train.txt` : 7352 rows, 561 columns
    *contains recorded features train data*
-   `ytrain <- test/y_train.txt` : 7352 rows, 1 columns
    *contains train data of activities’ code labels*

##### 3. Merges the training and the test sets to create one data set

-   `X` (10299 rows, 561 columns) is created by merging `xtrain` and `xtest` using **rbind()** function
-   `Y` (10299 rows, 1 column) is created by merging `ytrain` and `ytest` using **rbind()** function
-   `Subject` (10299 rows, 1 column) is created by merging `subject_train` and `subject_test` using **rbind()** function
-   `MergedData` (10299 rows, 563 column) is created by merging `Subject`, `Y` and `X` using **cbind()** function

##### 4. Extracts only the measurements on the mean and standard deviation for each measurement

-   `Data` (10299 rows, 88 columns) is created by subsetting `MergedData`, selecting only columns: `subject`, `code`, and only the measurements with `mean` and standard deviation `(std)`

##### 5. Uses descriptive activity names to name the activities in the data set

-   Entire numbers in code column of the `Data` replaced with corresponding activity taken from second column of the `activities` variable

##### 6. Appropriately labels the data set with descriptive variable names

-   `code` column in `Data` renamed to `activities`
-   All `Acc` in column’s name replaced by `Accelerometer`
-   All `Gyro` in column’s name replaced by `Gyroscope`
-   All `BodyBody` in column’s name replaced by `Body`
-   All `Mag` in column’s name replaced by `Magnitude`
-   All start with character `f` in column’s name replaced by `Frequency` ignoring case
-   All start with character `t` in column’s name replaced by `Time`
-   All `tBody` in column’s name replaced by `TimeBody`
-   All ending with `mean()` replaced by `Mean` ignoring case
-   All ending with `std()` replaced by \`STD\`\` ignoring case
-   All ending with `freq()` replaced by \`Frequency\`\` ignoring case
-   All `angle` in column’s name replaced by `Angle`
-   All `gravity` in column’s name replaced by \`Gravity

##### 7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

-   `FinalData` (180 rows, 88 columns) is created by sumarizing `Data` taking the means of each variable for each activity and each subject, after groupped by subject and activity.
-   Export `FinalData` into `FinalData.txt` file.
