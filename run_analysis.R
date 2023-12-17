rm(list=ls())
library('lubridate')
library('dplyr')
library('stringr')
library('tidyr')

##############################################################################
####### 1 - Merges the training and the test sets to create one data set.#####
##############################################################################


### Import train data set
trainx <- read.table("./Dataset/train/X_train.txt",header=FALSE)
trainy <- read.table("./Dataset/train/y_train.txt",header=FALSE)
subjectX<- read.table("./Dataset/train/subject_train.txt",header=FALSE)
names(trainy)="y"
names(subjectX)="subject"

## Merge the X and Y columns for train data
train <- cbind(subjectX,trainx,trainy)
train$group <- "train"
## remove the intermediate data set
rm(subjectX,trainx,trainy)

### import test data set
testx <- read.table("./Dataset/test/X_test.txt",header=FALSE)
testy <- read.table("./Dataset/test/y_test.txt",header=FALSE)
subjecty <- read.table("./Dataset/test/subject_test.txt",header=FALSE)

names(testy)="y"
names(subjecty)="subject"


## Merge the X and Y columns for train data
test <- cbind(subjecty,testx,testy)
test$group <- "test"
## remove the intermediate data set
rm(subjecty,testx,testy)

data <- tibble::as_tibble(rbind(test,train))

features <- read.table("./Dataset/features.txt",header = FALSE)
names(data) <- c("subject",features$V2,"y","group")
activity_label <- read.table("./Dataset/activity_labels.txt",header = FALSE)


##############################################################################
####### 2 - Extracts the measurements on the mean and standard deviation #####
##############################################################################

## extract columns having mean and std in their names
## + subject, y and group columns

DataMeanStd <- data[c(1,grep("mean()|std()",names(data)))]

## Remove MeanFreq out of scope
DataMeanStd <- DataMeanStd[-grep("meanFreq()",names(DataMeanStd))]
names(DataMeanStd)

##############################################################################
####### 3 -  descriptive activity names  in the data set ##### #############
##############################################################################

names(DataMeanStd) <- str_replace(names(DataMeanStd),"^t","Time_")
names(DataMeanStd) <- str_replace(names(DataMeanStd),"^f","Freq_")
names(DataMeanStd) <- str_replace(names(DataMeanStd),"BodyAcc","Body_accelerometer")
names(DataMeanStd) <- str_replace(names(DataMeanStd),"GravityAcc","Gravity_accelerometer")
names(DataMeanStd) <- str_replace(names(DataMeanStd),"BodyGyro","Body_gyroscope")
names(DataMeanStd) <- str_replace(names(DataMeanStd),"\\(\\)","")
names(DataMeanStd) <- str_replace_all(names(DataMeanStd),"\\-","_")


##############################################################################
####### 4 - labels the data set with descriptive variable names #############
##############################################################################

data_final <- gather(DataMeanStd,"descriptive","Value",-subject)


data_final$statistics <- str_extract(data_final$descriptive,"mean|std")
table(data_final$statistics,useNA="ifany")

data_final$domain_signals  <- str_extract(data_final$descriptive,"Time|Freq")
table(data_final$domain_signals,useNA="ifany")

data_final$capture  <- str_extract(data_final$descriptive,"Body|Gravity")
table(data_final$capture,useNA="ifany")

data_final$instruments  <- str_extract(data_final$descriptive,"accelerometer|gyroscope")
table(data_final$instruments,useNA="ifany")

data_final$axis  <- str_extract(data_final$descriptive,"X|Y|Z|JerkMag|Mag")
table(data_final$axis,useNA="ifany")

###############################################################################
####### 5 - average of each variable for each activity and each subject. ######
###############################################################################


dataAvg <- data_final %>%
  group_by(instruments,domain_signals,capture, axis, statistics,subject) %>%
  summarize(count = n(),
            avg_value = mean(Value)
  )

write.table(dataAvg,file="tidydata.txt",row.name=FALSE)

