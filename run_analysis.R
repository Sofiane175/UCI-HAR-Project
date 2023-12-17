# The R script will perform the following tasks:
# 1. Merge the training and test sets to create one data set
# 2. Extracts measurements on the mean and standard deviation for each measurement
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names
# 5. From the data set in Step 4, create a second, independent tidy data set with
#.   the average of each variable for each activity and each subject



rm(list=ls())
library('lubridate')
library('dplyr')
library('stringr')
library('tidyr')
library('data.table')

##############################################################################
####### Merges the training and the test sets to create one data set#####
##############################################################################


### Import train data set
activity_labels <- fread("./Dataset/activity_labels.txt",header = FALSE, 
                         col.names = c("activityID", "activityNames"))
features <- fread("./Dataset/features.txt",header = FALSE,
                  col.names = c("featureID", "featureNames"))


trainx <- fread("./Dataset/train/X_train.txt",header=FALSE, 
                col.names= features$featureNames)
trainy <- fread("./Dataset/train/y_train.txt",header=FALSE, 
                col.names = "Activity")
subjectX<- fread("./Dataset/train/subject_train.txt",header=FALSE, 
                 col.names = "SubjectID")

## Merge the X and Y columns for train data
train <- cbind(subjectX,trainy,trainx)

## remove the intermediate data set
rm(subjectX,trainx,trainy)

### import test data set
testx <- fread("./Dataset/test/X_test.txt",header=FALSE,
                    col.names= features$featureNames)

testy <- fread("./Dataset/test/y_test.txt",header=FALSE,
                    col.names = "Activity")
subjecty <- fread("./Dataset/test/subject_test.txt",header=FALSE,
                       col.names = "SubjectID")



## Merge the X and Y columns for train data
test <- cbind(subjecty,testy,testx)

data <- rbind(train,test)

## remove the intermediate data set
rm(subjecty,test,train,testx,testy)



##############################################################################
#######  Extracts the measurements on the mean and standard deviation #####
##############################################################################

tidydata <- data %>% 
  select(SubjectID, Activity, contains("mean()"), contains("std()"))

##############################################################################
####### descriptive activity names in the data set and label ##### ############
##############################################################################

tidydata$Activity <- activity_labels[tidydata$Activity, 2]

names(tidydata) <- gsub("^t", "Time", names(tidydata))
names(tidydata) <- gsub("^f", "Frequency", names(tidydata))
names(tidydata) <- gsub("Acc", "Accelerometer", names(tidydata))
names(tidydata) <- gsub("Gyro", "Gyroscope", names(tidydata))
names(tidydata) <- gsub("BodyBody", "Body", names(tidydata))
names(tidydata) <- gsub("Mag", "Magnitude", names(tidydata))
names(tidydata) <- gsub("()", "", names(tidydata))

###############################################################################
####### average of each variable for each activity and each subject. ######
###############################################################################


tidyMeans <- tidydata %>% group_by(SubjectID, Activity) %>% 
  summarise_all(funs(mean))


fwrite(tidyMeans, file = "tidy_data.txt")
