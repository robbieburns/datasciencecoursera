## Getting and cleaning smartphone gyroscope data set from UCI

### _Submitted by Robert C. Pollock for "Getting and Cleaning Data"_
#### ---A course in the "Data Science" Track from _Coursera_---

This script downloads a dataset in _zip_ format, taken from a study of the effect of activities
on gyroscope data from Samsung smartphones.

See [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#) for more information.

After downloading and unzipping the file (only if the expected files are not already in the 
script directory), the data is cleaned as follows:

* All statistics are removed from all variables, except for the _mean_ and _standard deviation_ which 
  are kept for all variables.

* As per the original dataset, the variables consist of various metrics for movement picked up by the gyroscopes, 
  and for each variable there are values for the X, Y and Z directions of movement (and mean and std dev).

* Information about the activity, and the "subject" (or participant) is added to each row of data

* Finally, the mean of all values (i.e. the mean of the means and the mean of the standard deviations) is taken
  for each combination of participant and activity, and the data saved as "summary_data.txt"
  
#### Code Book for Cleaned Data

 Variable name             |    Brief description
 --------------------------|-----------------------
 "activity"                |  Activity (walking, etc.)
 "participant"             |  Person/subject in study

For the following variables, the data set consists of mean and standard deviation
(defined as XXX.mean.[XYZ] and XXX.std.[XYZ], where XXX is the variable name).

In general, the naming scheme for theses variables is as follows:
   * Acc refers to "accelerometer"
   * Gyro refers to "gyroscope"
   * Gravity is the movement that can be attributed to gravity
   * Body is the corrected movement due to the body alone (not gravity)
   * Prefix 't' means "time domain"; prefix 'f' means "fourier transform" (i.e. frequency domain)

##### Vector variables (separate "X", "Y" and "Z" components)

   
Variable name              | 
---------------------------|
"tBodyAcc"                 |         
"tGravityAcc"              |       
"tBodyAccJerk"             |      
"tBodyGyro"                |            
"tBodyGyroJerk"            |      
"fBodyAcc"                 |           
"fBodyAccJerk"             |        
"fBodyGyro"                |          

##### Magnitude variables (only mean and std deviation)

Variable name              |
---------------------------|
"tBodyAccMag"              | 
"tBodyAccJerkMag"          |  
"tBodyGyroMag"             |         
"tBodyGyroJerkMag"         |
"fBodyAccMag"              | 
"fBodyBodyAccJerkMag"      |
"fBodyBodyGyroMag"         |     
"fBodyBodyGyroJerkMag"     |
