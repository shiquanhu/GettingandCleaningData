Getting and Cleaning Data
======================

Data source: This is from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The original data can be downloaded from http://archive.ics.uci.edu/ml/machine-learning-databases/00240/

1. Input and merges the training and the test sets to create one data set
2. Input and merges the training and the test activity sets to create one activity data set
3. Input and merges the training and the test subject sets to create one subject data set
4. Set the data set column name with features.
5. Set the activity data set column names.
6. Set the subject data set column names.
7. Extracts only the measurements on the mean and standard deviation for each measurement.
8. Merge the data set from step 1 with activity data set
9. Merge the data set from step 8 with subject data set
10. Reshape the merged data set with reshape2 utility
11. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
