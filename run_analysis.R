library(dplyr)

# read in the training and test set
trainingset = read.table("UCI_HAR_Dataset/train/X_train.txt")
testset = read.table("UCI_HAR_Dataset/test/X_test.txt")

# create lookup map for activity labels
activities = read.table("UCI_HAR_Dataset/activity_labels.txt")
get_activity_label = activities$V2
names(get_activity_label) = activities$V1

# add columns identifying the subject and the activity labels
trainingsubject = read.csv("UCI_HAR_Dataset/train/subject_train.txt", header = F)[,1]
testsubject = read.csv("UCI_HAR_Dataset/test/subject_test.txt", header = F)[,1]

training_activities = read.csv("UCI_HAR_Dataset/train/y_train.txt", header = F)[,1]
test_actitivities = read.csv("UCI_HAR_Dataset/test/y_test.txt", header = F)[,1]
training_activity_labels = sapply(training_activities, function(act) {get_activity_label[[act]]})
test_activity_labels = sapply(test_actitivities, function(act) {get_activity_label[[act]]})

trainingset = trainingset %>% mutate(subject = trainingsubject, activity = training_activity_labels, .before = 1)
testset = testset %>% mutate(subject = testsubject, activity = test_activity_labels, .before = 1)

# merge the test and trainingset (i.e. rowbinding)
complete_dataset = rbind.data.frame(trainingset, testset)

# extract the descriptive names for the measured features
feature_names = read.table("UCI_HAR_Dataset/features.txt")[,2]

# Name the columns descriptively: First column is the subject, second is the activity, the rest are the measured features
column_names = c("subject", "activity", feature_names)
colnames(complete_dataset) = column_names

# now, we only want any features representing "means" or "stds"
desired_measurements = grep("-mean\\(\\)|-std\\(\\)", colnames(complete_dataset))
# and of course the first two columns, which contain the subject and activity
desired_columns = c(1, 2, desired_measurements)

# throw away all other columns
complete_dataset = complete_dataset[,desired_columns]

# produce the summary aggregate, which shows the average of each variable by activity and subject. 
summary = complete_dataset %>% 
  group_by(subject, activity) %>% 
  summarise_all(mean)

# save this dataset as textfile, as required by the assigment
summary %>% write.table("tidy_summary.txt", row.names = FALSE)

# as a last step, as required by the assignemnt, output this dataset
summary
