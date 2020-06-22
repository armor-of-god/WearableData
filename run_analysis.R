library(dplyr)
filename <- "Data.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, destfile = "Data.zip", method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename)
}

# Assign all the data frames from original data
functions <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = functions$functions)
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = functions$functions)
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Merge the training and test data sets into one data set
X <- rbind(xtrain, xtest)
Y <- rbind(ytrain, ytest)
Subject <- rbind(subject_train, subject_test)
MergedData <- cbind(Subject, Y, X)


# Select only the subject, code, and columns which contain "mean" and "std" from MergedData
Data <- MergedData %>% select(subject, code, contains("mean"), contains("std"))

# Assign descriptive activity names
Data$code <- activities[Data$code, 2]

# Rename labels with more descriptive variable names
names(Data)[2] = "activity"
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("^t", "Time", names(Data))
names(Data)<-gsub("^f", "Frequency", names(Data))
names(Data)<-gsub("tBody", "TimeBody", names(Data))
names(Data)<-gsub("-mean()", "Mean", names(Data), ignore.case = TRUE)
names(Data)<-gsub("-std()", "STD", names(Data), ignore.case = TRUE)
names(Data)<-gsub("-freq()", "Frequency", names(Data), ignore.case = TRUE)
names(Data)<-gsub("angle", "Angle", names(Data))
names(Data)<-gsub("gravity", "Gravity", names(Data))

# creates a second, independent tidy data set with the average of each variable for each activity and each subject
FinalData <- Data %>%
    group_by(subject, activity) %>%
    summarize_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)
