
##1.Merges the training and the test sets to create one data set.
##2.Extracts only the measurements on the mean and standard deviation for each measurement. 
##3.Uses descriptive activity names to name the activities in the data set
##4.Appropriately labels the data set with descriptive activity names. 
##5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Read in the train data and test data
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt", sep="", header = FALSE)
testData <- read.table("./UCI HAR Dataset/test/X_test.txt", sep="", header = FALSE)

##Read in the train activity and test activity
yTrainData <- read.table("./UCI HAR Dataset/train/Y_train.txt", sep="", header = FALSE)
yTestData <- read.table("./UCI HAR Dataset/test/Y_test.txt", sep="", header = FALSE)

##Read in the train subject and test subject
subjectTrainData <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep="", header = FALSE)
subjectTestData <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep="", header = FALSE)

##Merge train data and test data
## 1.Merges the training and the test sets to create one data set.
totalData <-rbind(trainData, testData)

##Read in the features
features <- read.table("./UCI HAR Dataset/features.txt", sep="", header = FALSE)

##load package
library(sqldf)

##column names
featureNames <- features[, 2]
colnames(totalData) <- featureNames

colnames(features)[2] <- "featureName"
subFeatures <- sqldf("select * from features where featureName LIKE '%mean%' or featureName LIKE '%std%'")
subFeatureNames <- subFeatures[, 2]

##2.Extracts only the measurements on the mean and standard deviation for each measurement.
subTotalData <- totalData[, subFeatureNames]

## Merge train activity and test activity
yData <- rbind(yTrainData, yTestData)
colnames(yData)[1] <- "activityID"

##Read in the activities
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", sep="", header = FALSE)
colnames(activities) <- c("id", "activity")


## Merge train subject and test subject
subjectData <- rbind(subjectTrainData, subjectTestData)
colnames(subjectData)[1] <- "subject"

## Merge result data with activity
allData <- cbind(totalData, yData)

## Merge with subject
allData <- cbind(allData, subjectData)

##Load library
library(reshape2)

## Melt data
allDataMelt <- melt(allData, id=c("activityID", "subject"), measure.vars = featureNames)

##5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
activitySubjectMean <- dcast(allDataMelt, activityID + subject ~ variable, fun.aggregate=mean)

activitySubjectMean <- merge(activities, activitySubjectMean, by.x = "id", by.y = "activityID")

activitySubjectMean <- subset(activitySubjectMean, select = -c(id))

write.csv(activitySubjectMean, "./activitySubjectMean.txt", col.names = TRUE, sep=",")
