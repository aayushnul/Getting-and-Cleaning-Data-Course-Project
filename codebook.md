#Variables and their descriptions
##Subject
subject-> ID of the 30 volunteers for the experiment
          (1-30)
##Activity
activity-> WALKING
        -> WALKING_UPSTAIRS
        ->...
        ->LAYING
        (1-6)

##Features
embedded accelerometer and gyroscope
3-axial linear acceleration and 3 axial angular velocity
3 signals used to denote 3-axial signals in X,Y and Z direction
the set of variables estimated from these signals are calculated with mean() and std() in the varible name itself


Thus total 68 combined variables were there and included measurement on body,gravity including for jerk for both frequency and time.


##The dataset summary can also be seen with 

```{r}
str(allDataMeans)
```
```{r}
summary(allDataMeans)
```
            

