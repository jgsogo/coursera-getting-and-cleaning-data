# [COURSERA] Getting and cleaning data

This is a repository created for the course project of the 
[Getting and Cleaning Data](https://class.coursera.org/getdata-013/)
course in Coursera.

The file `run_analysis.R` contains the functions needed to perform the
analysis on the data about wearable computing located in the `UCI HAR Dataset`
directory. More information about this dataset and how it was collected
can be found at the UCI Repository ([here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)).


# run_analysis.R

File `run_analysis.R` defines several functions in R language to perform the
analysis over the dataset. To perform yourself the analysis in your computer
just follow these steps (inside R console):

```
> setwd('/path/to/the/cloned/repository/')
> source('run_analysis.R')
> tidy_data <- run_analysis()
```

By default the function `run_analysis` looks for a dataset located in `./UCI HAR Dataset`,
but you can pass an path string to the function if you want to perform the analysis over
another **dataset with the same structure**.

This function works over the data following these steps:

 1. It selects the features it is going to work with from file `features.txt`, we
    are going to work only with data corresponding to mean and standard deviation.
 1. It loads **test data** files and filters by the columns corresponding to the
    previously selected features.
 1. It does the same with the **train data**.
 1. It appends one dataset to the other, so we now have just one big dataset.
 1. And rename columns and activity labels in order to improve the readability of the
    resulting dataset.

To load the test and the train data, the function uses another function also defined in
the same file, `tidy_dataset`, which is the one that actually reads the data files, filters
according to the selected features and build one single table.

