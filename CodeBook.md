# Raw data description 
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

# Feature Selection for "dataAvg", the final dataset

"dataAvg" are independent tidy data set with the average of each variable for each activity and each subject of data collected from the accelerometers from the Samsung Galaxy S smartphone.  Measurements on the mean and standard deviation for each measurement were extracted and averaged by activity.

The "dataAvg" containts the following list of variable :
- instruments : accelerometer/gyroscope
- domain_signals : Frequency/time
- capture : Body / Gravity
- Axis : X/Y/Z/Mag/ JerkMag
- Statisitics : mean/std
- Subject : from 1 to 30
- count : number of data points used to compute the average
- Avg_value :Features  normalized and bounded within [-1,1]

# Note
-  The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).
- The gyroscope units are rad/seg.
- mean: Mean value
- std: Standard deviation
