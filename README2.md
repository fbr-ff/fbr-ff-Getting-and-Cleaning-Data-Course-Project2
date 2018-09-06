# run_analysis.R

* All csv files are loaded into list objects, in which each list elements represents a csv file. There are 3 list objects, 1 for each folder (supplementary data, training data, testing data)
* It is checked whether all csv objects in the training set have the same number of rows.
* The training and testing data are obtained from the respective list objects and merged, columns of the resulting data frame is named temporarily to allow for dplyr::gather to be used later on.
* Activity labels are obtained from the "supplementary data" list object and added as column to the data set. Activity descriptions are then added by joining the respective data frame in the suppl. data list object. 
* The final column names are then applied while ommitting the number before the feature.
* The data frame is subset, so that only columns containing either "mean" or "std" are extracted.
* All features from the original dataset are then *gathered*, resulting in the final dataset "df.tidy.data"
* From the resulting data frame, a secondary data frame is created containing the means of the respective features by using dplyr group and summarize functions.
* Both tidy datasets are exported as csv.
