####Alex Herrault
#### Getting and Cleaning Data
#### week4, peer graded assingment

rm(list=ls())
library(reshape2)
setwd("//data4/Mass Spec DataRrepository/Development/Alex Data Science Cert/Getting and Cleaning Data/Final Project/resource 3/UCI HAR Dataset")



### Function for reading subject_train, X_train, y_train from the folder trainand labelling and extracting the data for mean and SD. 

Data = function (foldername, folder)
{
path = file.path(folder, paste0("y_", foldername, ".txt"))

imported_y_data = read.table(path, header=FALSE, col.names = c("ActiviytID"))
  
path = file.path(folder, paste0("subject_", foldername, ".txt"))

imported_subject_data = read.table(path, header=FALSE, col.names=c("SubjectID"))
  
features_data = read.table("features.txt", header=FALSE, as.is=TRUE, col.names=c("MeasureID", "MeasureName"))
  
path = file.path(folder, paste0("X_", foldername, ".txt"))

imported_x_data = read.table(path, header=FALSE, col.names=features_data$MeasureName)
  
subsetted_data = grep(".*mean\\(\\)|.*std\\(\\)", features_data$MeasureName)
  
imported_x_data = imported_x_data[, subsetted_data]
  
imported_x_data$ActivityID = imported_y_data$ActivityID

imported_x_data$SubjectID = imported_subject_data$SubjectID
  
imported_x_data

}

#### read test imported_x_data
read_test_data = function()
{
  Data("test", "test")
}

#### read the train imported_x_data
read_train_data = function () 
{
  Data("train", "train")
}

####  merge read test data and training data 

mergedataset = function () 

{

imported_x_data = rbind(read_test_data(), read_train_data())

cnames = colnames(imported_x_data)

cnames = gsub("\\.+mean\\.+", cnames, replacement = "Mean")

cnames = gsub("\\.+std\\.+", cnames, replacement = "Std")

colnames(imported_x_data) = cnames

imported_x_data

}


### Read activity labels, create and appropriate column for them

activitylabs = function (imported_x_data)

{

activity_labels = read.table("activity_labels.txt", header = FALSE, as.is=TRUE, col.names = c("ActivityID", "ActivityName"))

activity_labels$ActivityName = as.factor(activity_labels$ActivityName)

data_labels = merge(imported_x_data, activity_labels)

data_labels

}

#### merge the activity labels to the already merged imported_x_data

merged_from_labels = function () 
{
  activitylabs(mergedataset())
}


##### Creatinging the second independent tidy data set with the average of each variable for each activity, subject. 

tidyData = function(merged_from_labels) 

{

categories = c("ActivityID", "ActivityName", "SubjectID")
  
measure_categories = setdiff(colnames(merged_from_labels), categories)
  
post_melt <- melt(merged_from_labels, id=categories, measure.categories=measure_categories)
  
#### post melt recast 

dcast(post_melt, ActivityName + SubjectID ~ variable, mean)

}

####  Getting the clean tidy imported_x_data

tidimported_y_datafile =function(foldername){
  
tidimported_y_data = tidyData(merged_from_labels())
  
write.table(tidimported_y_data, foldername)

}

tidimported_y_datafile("tidy.txt")