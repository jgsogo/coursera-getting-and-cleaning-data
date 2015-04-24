# CodeBook

The output from the `run_analysis.R` script is a table like the one below:

```
"volunteerID"   "activity"  "tBodyAcc-mean()-X"     "tBodyAcc-mean()-Y"      [...]
2               "STANDING"  0.277911472222222       -0.0184208270166667     
2               "SITTING"   0.27708735173913        -0.0156879937282609
2               "LAYING"    0.281373403958333       -0.0181587397583333 
....
```

where each column correspond to one of the features selected from the original dataset and each
row is an observation for a volunteer for an activity. The values are the average of each
variable for each activity and each subject so the pair `(volunteerID, activity)` is unique.


## Data processing

To get from the origina data at [UCI Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) to the resulting dataset, it has been done
several operations:

 1. For train and 


## Variables in columns

The meaning of the variables is the following:
