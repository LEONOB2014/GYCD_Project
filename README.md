GYCD_Project
============


The R script run_analysis.R assumes that the downloaded data has been extracted and the folder has been placed in the working directory. It reads the necessary data and ouputs saves the tidy.txt file containg the mean and standard deviation of the initial variables. The data is assembled with the variable names, for each Test and Training data, and merged with cbind to get a full data set, later is joined with the Subject and activity data frame, and filter by mean and stdv and getting activity changed for the label its number represent.

Information about data source

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data
Here is the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should download it and extract it into your working directory in order for the script to work properly.
