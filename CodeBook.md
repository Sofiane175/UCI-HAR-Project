# Raw data description 
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals. These time domain signals  were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals  using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals . Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm. 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

# Project tasks 

A R script, called run_analysis.R does the following:
- Merges the training and the test sets to create one data set.
-	Extracts only the measurements on the mean and standard deviation for each measurement.
-	Uses descriptive activity names to name the activities in the data set
-	Appropriately labels the data set with descriptive variable names.
-	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Executing the work is as follows:
- Download of the required files to the working directory 
- Load the remaining data from the training and test sets. Use 'fread' to read the files and 'col.names' to set column names for future merging and clean-up. Use 'rbind' and 'cbind' to combine the training and test sets separately.
- Merge the datasets and remove the redundant tables to save memory.
- Extract measurements based on mean and standard deviation from the merged dataset. Adjust column names to more descriptive variables using 'names' and 'gsub' function.
- Change the activity values in preparation for the tidy data set.
- Use 'group_by' and 'summarise_all' with mean to create the tidy data set of the average of each variable for each activity and subject .

# The variables changed from the original data set are as follows:
•	"t" = "Time"
•	"f" = "Frequency"
•	"Acc" = "Accelerometer"
•	"Gyro" = "Gyroscope"
•	"Mag" = "Magnitude"
•	"BodyBody" = "Body"
•	"()" = ""

# Note
-  The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).
- The gyroscope units are rad/seg.
- mean: Mean value
- std: Standard deviation
