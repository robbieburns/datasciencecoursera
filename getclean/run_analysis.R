##
## Script that downloads "wearable computing" dataset from specified
## url, unzips and performs data cleaning operations (described in
## code below).
##
## Robert C. Pollock
##
## Copyright November 22 2016
##
## Submitted as part of the requirements for the "Getting and Cleaning
## Data" course, Data Science Specialization on coursera.org
##
##

## Directory information
homedir <-
    "C:/Users/Robert/Dropbox/Documents/coursework/coursera/data science"
wdir <- "git/datasciencecoursera/getclean"

## Ensure we are in the correct working directory
setwd(homedir)
setwd(wdir)

## url to get data from
url <- paste("https://d396qusza40orc.cloudfront.net",
             "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
             sep="/")

## Get data (if it hasn't been downloaded already).
if(!file.exists("data.zip")) {
    download.file(url, "data.zip", method="curl") # You _do_ need
                                        # method="curl"  for https on
                                        # windows. This requires the
                                        # "curl" executable is in your
                                        # PATH, which should happen
                                        # automatically when you
                                        # install git.
}

## List of files
files <- unzip("data.zip", list=TRUE)

## files we need are:

## files[31,1] "UCI HAR Dataset/train/X_train.txt"
## files[17,1] "UCI HAR Dataset/test/X_test.txt"


## and for the labels/identification of activities (rows)

## files[32,1] "UCI HAR Dataset/train/y_train.txt"
## files[18,1] "UCI HAR Dataset/test/y_test.txt"


## the various individuals (the "subjects")

## files[16,1] "UCI HAR Dataset/test/subject_test.txt"
## files[30,1] "UCI HAR Dataset/train/subject_train.txt"

## ...and the various measurements (features, i.e cols)

## files[2,1] "UCI HAR Dataset/features.txt"

## Unzip the data (if it hasn't been already)
if(!file.exists(files[1,1]))
   unzip("data.zip")

## Get the feature labels (second element of data frame read in by read.table)
features <- read.table(files[2,1], stringsAsFactors=FALSE)[[2]]

## Columns/features required are those that contain "-mean()" or
## "-std()" for mean or standard deviation, respectively
cols2keep <-
    grep("(mean|std)\\(", features)

## Just keep the "features" we need for variable names
features <- features[cols2keep]

## Remove "()" from "features" (i.e. variable names)
features <- sub("\\(\\)","",features)

## Read in the entire test  set
testSet <- read.table(files[17,1])

## ...and only keep the columns we need
testSet <- testSet[,cols2keep]

## with sensible varnames
names(testSet) <- features

## the labels for the various measurements
## ... and the activity labels (just need first element of dataframe,
## which is an integer vector).
testLabels <- read.table(files[18,1])[[1]]

## ... and subjects
testSubjects <- read.table(files[16,1])[[1]]

## Convert to factor (with appropriate character strings for levels)
testLabels <- as.factor(testLabels)

levels(testLabels) <- c("Walking", "Walking upstairs",
                        "Walking downstairs", "Sitting", "Standing",
                        "Lying")

## add to testSet dataframe as appropriate factor
testSet <-
    data.frame(cbind(activity=testLabels,
                     participant=testSubjects,
                     testSet))          # use cbind to ensure that the
                                        # first element is the
                                        # labels. Second element is
                                        # the number of the person
                                        # taking part in the study.

## Same palaver with the training set...

trainSet <- read.table(files[31,1])

trainSet <- trainSet[,cols2keep]

names(trainSet) <- features

trainLabels <- read.table(files[32,1])[[1]]

trainSubjects <- read.table(files[30,1])[[1]]

trainLabels <- as.factor(trainLabels)

levels(trainLabels) <- c("Walking", "Walking upstairs",
                        "Walking downstairs", "Sitting", "Standing",
                        "Lying")

trainSet <-
    data.frame(cbind(activity=trainLabels,
                     participant=trainSubjects,
                     trainSet))

## Now join the two datasets

allData <- rbind(testSet, trainSet)

## Finally,  use ddply (from plyr) to take colMeans for all numeric columns
require(plyr)

summaryData <-
    ddply(allData,
          c("activity","participant"),
          function(x) colMeans(x[,-(1:2)], na.rm=TRUE))

write.table(summaryData, file="summary_data.txt", row.names=FALSE)




