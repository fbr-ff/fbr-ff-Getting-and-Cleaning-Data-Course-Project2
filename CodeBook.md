# Codebook

The final tidy dataset *tidy_dataset_1.csv* contains the following columns:

* activity_index
* activity_description: the activity each subject was performing
	- WALKING
	- WALKING_UPSTAIRS
	- WALKING_DOWNST
	- AIRS
	- SITTING
	- STANDING	
	- LAYING
* subject: anonymized subject from 1 to 30.
* measurement_type columns: type of conducted measurement, see README.txt of original dataset.

The secondary dataset *tidy_dataset_2_means.csv* contains

* activity_description (see above)
* subject (see above)
* mean: mean of the original feature data broken down by subject and activity.
