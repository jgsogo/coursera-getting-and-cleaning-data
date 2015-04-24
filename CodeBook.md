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
variable for each activity and each subject so the pair `(volunteerID, activity)` is unique in
the resulting dataset.


## Data processing

To get from the origina data at [UCI Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) to the resulting dataset, it has been done
several operations:

 1. Operations on `train` and `test` data folders:
    1. Data from `subject_<train|test>.txt`, `y_<train|test>.txt` and `X_<train|test>.txt`
       (only the selected features) are joined side-by-side to build a single table.
 2. Both dataset are concatenated.
 3. Values are averaged for each activity and each subject.

Afterwards, labels are added to identify columns and the activity factors.


## Variables in columns

The meaning of the first two columns is the following:

 * `volunteerID`: identifier of the volunteer.
 * `activity`: activity performed by the volunteer, labels are self-explanatory.

The rest of the columns correspond to the features on the original dataset documented
in the [features_info.txt](./UCI HAR Dataset/features_info.txt) file.


## Observations in rows

Each row contains the average of the variables for each activity and each subject.