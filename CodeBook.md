# Data Cleaning CodeBook

## Raw Data
All raw data is taken from the UCI HAR Dataset. 
A full description of this dataset is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here is the link to the raw data for this project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Processed Data
First read in the raw trainingset and testset from X_train.txt and X_test.txt
Create a lookup which maps the activity code to its descriptive acitivity name. This mapping is given in activity_labels.txt

Read the subject (the volunteer that wore the device) corresponding to each record from subject_train.txt and subject_test.txt
Add this "subject" column as the first column of the trainingset and testset, respectively

Read the activity code corresponding to each record from y_train.txt and y_train.txt, respectively.
Translate the activity code into its descriptive label via the mapping created above
Add this activity label as the second column of the trainingset and testset, respectively.

Bind the resulting trainingset and testset dataframe by row. Because the subjects are partitioned into either the trainingset or testset, this gives us the complete set of measurements.

Call this dataframe the complete_dataset.

Extract the descriptive variable names from UCI_HAR_Dataset/features.txt. These describe all the columns in the complete_dataset except the first two that we added.

Name all columns of complete_dataset with these descriptive names.

Remove all columns which do not measure a "mean" or a standard deviation "std", because we are only interested in these.

Finally, produce a "summary" dataframe which calculates the mean for every column grouped by subject and activity.