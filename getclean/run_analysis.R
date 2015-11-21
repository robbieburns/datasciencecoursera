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

files <- unzip("data.zip", list=TRUE)

## Unzip the data (if it hasn't been already)
if(!file.exists(files[1,1]))
   unzip("data.zip")

