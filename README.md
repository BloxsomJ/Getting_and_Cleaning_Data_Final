Getting and Cleaning Data Final Project

Alex Herrault


This project demonstrates the collection and cleaning of a tidy data set that can be used for downstream analysis. A full description of the data used in this project can be found at The UCI Machine Learning Repository


Making Modifications to This Script

Once you have obtained and unzipped the source files, you will need to make the following alteration to this code:  change the third executable line of code to reflect your working directory

This code will:

Download the dataset if it does not already exist in the working directory

Load the activity and feature info,both the training and test datasets, keeping only those columns which reflect a mean or standard deviation

Imports the activity and subject data for each dataset, and merges those columns with the dataset, then merges the two datasets

A Conversion is exevuted which is applied to the activity and subject columns into factors.

The "tidy dataset" (tidy,txt) asked for in the assignment is produced.

This dataset consists of the average (mean) value of each variable for each subject and activity pair.

