Codebook for means_df_long
========================================================

```r
means_df_long<-read.csv("UCIHAR_means_of_means_stds.txt",sep=" ")
```

**Variables**

```r
data.frame(variable.name=c(names(means_df_long)),
                                label=c("Subject Number (1:30)",
                                        "Activity Code (1:6)",
                                        "Activity Type (text explanation of Activity Code)",
                                        "Variable of Interest",
                                        "Mean of variable means",
                                        "Mean of variable standard deviations")
)
```

```
##   variable.name                                             label
## 1       subject                             Subject Number (1:30)
## 2  activityCode                               Activity Code (1:6)
## 3  activityType Activity Type (text explanation of Activity Code)
## 4      variable                              Variable of Interest
## 5    mean.means                            Mean of variable means
## 6 mean.std_devs              Mean of variable standard deviations
```

**Unique values of variable**

```r
unique(means_df_long$variable)
```

```
##  [1] frequency.BodyAcc.X           frequency.BodyAcc.Y          
##  [3] frequency.BodyAcc.Z           frequency.BodyAccJerk.X      
##  [5] frequency.BodyAccJerk.Y       frequency.BodyAccJerk.Z      
##  [7] frequency.BodyAccMag          frequency.BodyBodyAccJerkMag 
##  [9] frequency.BodyBodyGyroJerkMag frequency.BodyBodyGyroMag    
## [11] frequency.BodyGyro.X          frequency.BodyGyro.Y         
## [13] frequency.BodyGyro.Z          time.BodyAcc.X               
## [15] time.BodyAcc.Y                time.BodyAcc.Z               
## [17] time.BodyAccJerk.X            time.BodyAccJerk.Y           
## [19] time.BodyAccJerk.Z            time.BodyAccJerkMag          
## [21] time.BodyAccMag               time.BodyGyro.X              
## [23] time.BodyGyro.Y               time.BodyGyro.Z              
## [25] time.BodyGyroJerk.X           time.BodyGyroJerk.Y          
## [27] time.BodyGyroJerk.Z           time.BodyGyroJerkMag         
## [29] time.BodyGyroMag              time.GravityAcc.X            
## [31] time.GravityAcc.Y             time.GravityAcc.Z            
## [33] time.GravityAccMag           
## 33 Levels: frequency.BodyAcc.X frequency.BodyAcc.Y ... time.GravityAccMag
```

**Unique values of Activity Type**

```r
unique(means_df_long$activityType)
```

```
## [1] WALKING            WALKING_UPSTAIRS   WALKING_DOWNSTAIRS
## [4] SITTING            STANDING           LAYING            
## 6 Levels: LAYING SITTING STANDING WALKING ... WALKING_UPSTAIRS
```

**Summary of dataset**

```r
summary(means_df_long)
```

```
##     subject      activityCode             activityType
##  Min.   : 1.0   Min.   :1.0   LAYING            :990  
##  1st Qu.: 8.0   1st Qu.:2.0   SITTING           :990  
##  Median :15.5   Median :3.5   STANDING          :990  
##  Mean   :15.5   Mean   :3.5   WALKING           :990  
##  3rd Qu.:23.0   3rd Qu.:5.0   WALKING_DOWNSTAIRS:990  
##  Max.   :30.0   Max.   :6.0   WALKING_UPSTAIRS  :990  
##                                                       
##                     variable      mean.means      mean.std_devs   
##  frequency.BodyAcc.X    : 180   Min.   :-0.9976   Min.   :-0.998  
##  frequency.BodyAcc.Y    : 180   1st Qu.:-0.9314   1st Qu.:-0.971  
##  frequency.BodyAcc.Z    : 180   Median :-0.1297   Median :-0.919  
##  frequency.BodyAccJerk.X: 180   Mean   :-0.3090   Mean   :-0.660  
##  frequency.BodyAccJerk.Y: 180   3rd Qu.:-0.0119   3rd Qu.:-0.364  
##  frequency.BodyAccJerk.Z: 180   Max.   : 0.9745   Max.   : 0.687  
##  (Other)                :4860
```
