ReadMe for run_analysis.R
========================================================

**Purpose**
=====
The purpose of this analysis is to obtain the UCI Human Activity Recognition dataset (available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ), combine training and test datasets, subset the variables available to include the mean and standard deviation metrics only, and summarize those variables for each subject and activity.

For each of training (/train) and test (/test), we first load the data (the X, Y, and Subject datasets) using `read.table`.  We apply labels from the features.txt file, using `gsub` to remove parentheses and dashes, removing the former and converting dashes to periods, merge in the Y and Subject columns using `cbind`, and use the activity_labels.txt values to label the activity codes with useful language (`activityType` is the plain language value, `activityCode` is the code).  Finally, we combine the training and test datatables into one dataframe.

Next, we determine which variables we will keep for the mean and standard deviation columns. We determine which variables have .mean. or .mean{end of string} (needing the complexity as some variables include "Mean" without being actual means), and similarly which have std (we do not need to check for end of string or dots, as no variables have std in them without being of interest).  At this step we have 33 variables of interest in each of the means and standard deviation lists (for a total of 66 variables), plus the three id variables `subject`, `activityCode`, and `activityType`).  
We then filter the dataframe by these columns, creating `df_mean` and `df_std` dataframes.  Finally, we melt these dataframes (using `melt` from `reshape`) and combine then using `cbind`, keeping only the value from the `df_std` dataframe.  This gives us a single data frame with 339867 observations and 6 variables.
We then remove the `.mean` from the variable column to make it more generic, and change `f` at the start to `frequency` and `t` to `time` to make those more clear.  We reorder the data frame to make it more useful for future users, ordering by subject, activity, and variable.

To perform the last step, the summarization, we summarize by subject*activity using `ddply` from the `plyr` package.  This gives us 180 values for each variable (30 subjects, 6 activities) , for a total of 5940 observations.

=====

Packages required in addition to base: 

* `plyr`
* `reshape`

Data frames of interest produced: 

* `df_UCIHAR` (complete dataframe of all variables, combining test and training data)
* `df_long` (non-summarized, filtered dataset of mean/std measurements) 
* `means_df_long`(summarized dataset of mean/std measurements, summarized by mean)
