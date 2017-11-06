# Data Analytics: Assignment 2, Anova
Kat Bardash, 11.5.17  
>
# Initial Questions
##1.	What does an Analysis of Variance tell you? What types of questions does it answer?

>
##### Analysis of Variance helps you determine if your experiment results are significant and whether you can reject the null hypothesis. You do this by calculating the total variability by the Sum of Squares for all the values. Then the Sum of squares or variabilty per treatment. This allows you to calculate leftoever variability. From this you can divide each of the variability errors by their related degrees of freedom to get the mean squares for the treatment and for the error. Then you finally divide the treatment by the error (larger/small - hopefully your error is small!) to get the F value. Using an F table you can determine whether you can reject the null hypothesis at your appropriate significance level. You can estimate this from the curve or use R to find the exact P value of your F-statistic.

>
## 2. Analysis of Variance can answer the following questions:

>
###* Do three different menu items make any impact on sales?
>
###* Will green, black or no tea have any effect on weight loss?
>
###* Do difference soils improve plant growth?

>
##3.	What then is the significance of experimental design?

>
### Clearly it is important to think about the design of an experiment for analysis. In the case of the restaurant that wants to test menu items at each restaurant - the way the experiment is conducted will determine what kind of analysis can be done. If each restaurant varied the amount of time the menus were available or did not make all of them available then you would not be able to do the anova test. Thinking about the analysis will save time and hassle in the long run when trying to collect data and run numbers. Researchers should consider what the null hypothesis is so they can determine what it is they want to observe, determine which variables (factors, levels) to measure and control, and decide how treatments are to be randomly assigned. 


>
## Completely Randomized Tutorial & Kat's Interpretations 
#### website: http://www.r-tutor.com/elementary-statistics/analysis-variance/completely-randomized-design
  
> 
### Step 1: Create a table named fast-food-1.txt and read it into R. *My null hypothesis is that the means of the sales figures of the 3 menu items are not different.* My alternate hypothesis is that means of the sales figures of the 3 menu items are different. 


```r
library(knitr)
df1 = read.table("fastfood-1.txt", header=TRUE); kable(df1)
```



 Item1   Item2   Item3
------  ------  ------
    22      52      16
    42      33      24
    44       8      19
    52      47      18
    45      43      34
    37      32      39

> 
### Step 2: Concatenate the data rows and transpose (read across columns rather than down)


```r
r <- c(t(as.matrix(df1)))  # t() functions reads across columns rather than down
r
```

```
##  [1] 22 52 16 42 33 24 44  8 19 52 47 18 45 43 34 37 32 39
```

>
### Step 3: Assign new variables for treatment levels and number of observations


```r
f <- c("Item1", "Item2", "Item3") #treatments
k <-3 #treatments levels
n <-6 # number of observations
```

>
### Step 4: Create a vector of treatment factors that corresponds to each element of r in step 3 with the gl function


```r
tm <- gl(k,1,length=n*k, factor(f)) #generate factor levels functions, gl(n,k,length) - n=# of levels, k=# of reps (is that 1?), length=n*k
tm #has 18 levels, 6*3
```

```
##  [1] Item1 Item2 Item3 Item1 Item2 Item3 Item1 Item2 Item3 Item1 Item2
## [12] Item3 Item1 Item2 Item3 Item1 Item2 Item3
## Levels: Item1 Item2 Item3
```
>
### Step 5: Apply the anova function to a formula that describes the response r by the treatment factor tm and print out ANOVA table with summary function.

#### Looking at the table, we get df for the treament as k-1 (where k is 3 treatments). Total df were 18-1= 17 - 2(for treatment) = 15 df left for our error. Mean Sq is Sum sq/df for both. and F value is Mean Squares of Treatment/ Mean sqaures error. The p value can be calculated using pf(2.541, 2, 15). 

#### Since the p-value is 0.112, that means that we will NOT reject our null hypothesis that mean sales volume of the new menu items are all equal. Since we were looking for a 5% significance level, our F value of 2.54 is NOT outside of the normal variance that we can associate with this data.

```r
av=aov(r~tm)  #aov - fit of analysis of variance model,  aov(formula)
summary(av)
```

```
##             Df Sum Sq Mean Sq F value Pr(>F)
## tm           2  745.4   372.7   2.541  0.112
## Residuals   15 2200.2   146.7
```

>
### Exercise: Redo the data but read it along vertical columns instead of horizontal rows. I can do this by taking out the transpose function in step 2. I will use the variable df as above.


```r
df1 = read.table("fastfood-1.txt", header=TRUE); df1
```

```
##   Item1 Item2 Item3
## 1    22    52    16
## 2    42    33    24
## 3    44     8    19
## 4    52    47    18
## 5    45    43    34
## 6    37    32    39
```

>
### Step 2: Concatenate the data rows and transpose (read across columns rather than down)


```r
r <- c(as.matrix(df1))  # concatonate down 
r
```

```
##  [1] 22 42 44 52 45 37 52 33  8 47 43 32 16 24 19 18 34 39
```

>
### Step 3: Assign new variables for treatment levels and number of observations


```r
f <- c("Item1", "Item2", "Item3") #treatments
k <-3 #treatments levels
n <-6 # number of observations
```
>
### Step 4: Create a vector of treatment factors that corresponds to each element of r in step 3 with the gl function


```r
tm2 <- gl(k,6,length=n*k, factor(f)) #generate factor levels functions, gl(n,k,length) - n=# of levels, k=# of reps (repeat 6 time, for length of each item), length=n*k
tm2 #has 18 levels, 6*3
```

```
##  [1] Item1 Item1 Item1 Item1 Item1 Item1 Item2 Item2 Item2 Item2 Item2
## [12] Item2 Item3 Item3 Item3 Item3 Item3 Item3
## Levels: Item1 Item2 Item3
```

>
### Step 5: Apply the anova function to a formula that describes the response r by the treatment factor tm and print out ANOVA table with summary function. - Same result as the above, only down by column instead of row.


```r
av2=aov(r~tm2)  #aov - fit of analysis of variance model,  aov(formula)
summary(av2)
```

```
##             Df Sum Sq Mean Sq F value Pr(>F)
## tm2          2  745.4   372.7   2.541  0.112
## Residuals   15 2200.2   146.7
```

```r
summary(av)
```

```
##             Df Sum Sq Mean Sq F value Pr(>F)
## tm           2  745.4   372.7   2.541  0.112
## Residuals   15 2200.2   146.7
```

## *END OF OFFICIAL ASSIGMENT* 

>
## Randomized Block Design
#### Only one primary factor under consideration in the experiment. Similar test subjects are grouped into blocks. Each block is tested against all treatment levels of the primary factor at random order. 

#####Example: Fast food franchise testing marketing 3 new menu items. 6 restaurants are chosen randomly. Each Resaurant will test marketing all 3 items, but only one menu per week (3 weeks to complete). Testing order is also randomly assigned. 


```r
df2 = read.table("fastfood-2.txt", header=TRUE); df2 
```

```
##   Item1 Item2 Item3
## 1    31    27    24
## 2    31    28    31
## 3    45    29    46
## 4    21    18    48
## 5    42    36    46
## 6    32    17    40
```


```r
r = c(t(as.matrix(df2))) # response data
r
```

```
##  [1] 31 27 24 31 28 31 45 29 46 21 18 48 42 36 46 32 17 40
```


```r
# assign new variables for treatment levels and numberof control blocks

f = c("Item1", "Item2", "Item3")
k=3
n=6

#create a vector of treatment factors that corresponds to each element in r of step above with gl function
tm=gl(k, 1, n*k, factor(f))
tm
```

```
##  [1] Item1 Item2 Item3 Item1 Item2 Item3 Item1 Item2 Item3 Item1 Item2
## [12] Item3 Item1 Item2 Item3 Item1 Item2 Item3
## Levels: Item1 Item2 Item3
```

```r
blk=gl(n,k,k*n) #blocking factor, repeat each # 3 times, item 1 -1 , item 2 - 1, item 3-1, item 1-2, item 2-2, item 3-3, item 1-3, item 2-3, item 3-3
blk
```

```
##  [1] 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5 6 6 6
## Levels: 1 2 3 4 5 6
```

```r
av=aov(r~tm+blk)
summary(av)
```

```
##             Df Sum Sq Mean Sq F value Pr(>F)  
## tm           2  538.8  269.39   4.959 0.0319 *
## blk          5  559.8  111.96   2.061 0.1547  
## Residuals   10  543.2   54.32                 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
#### at p < 0.05 significance level, p-value of treatment 0.032 makes us reject null hypothesis that mean sales volumes of all new menu items are all equal. 

####We do not have to interpret the other interactions if the first is significant? *Not sure if this is true*
>
## Factorial Design
#### A fast food franchise is test marketing 3 new menu items in both East and West Coasts of continental United States. To find out if they the same popularity, 12 franchisee restaurants from each Coast are randomly chosen for participation in the study. In accordance with the factorial design, within the 12 restaurants from East Coast, 4 are randomly chosen to test market the first new menu item, another 4 for the second menu item, and the remaining 4 for the last menu item. The 12 restaurants from the West Coast are arranged likewise.


```r
df3 = read.csv("fastfood-3.csv")
df3
```

```
##    Item1 Item2 Item3
## E1    25    39    36
## E2    36    42    24
## E3    31    39    28
## E4    26    35    29
## W1    51    43    42
## W2    47    39    36
## W3    47    53    32
## W4    52    46    33
```

```r
r = c(t(as.matrix(df3))) # response data
r
```

```
##  [1] 25 39 36 36 42 24 31 39 28 26 35 29 51 43 42 47 39 36 47 53 32 52 46
## [24] 33
```

```r
f1 = c("Item1", "Item2", "Item3") # 1st factor levels 
f2 = c("East", "West")            # 2nd factor levels 
k1 = length(f1)          # number of 1st factors 
k2 = length(f2)          # number of 2nd factors 
n = 4                    # observations per treatment

tm1 <- gl(k1, 1, n*k1*k2, factor(f1))
tm1
```

```
##  [1] Item1 Item2 Item3 Item1 Item2 Item3 Item1 Item2 Item3 Item1 Item2
## [12] Item3 Item1 Item2 Item3 Item1 Item2 Item3 Item1 Item2 Item3 Item1
## [23] Item2 Item3
## Levels: Item1 Item2 Item3
```

```r
tm2 <- gl(k2,n*k1, n*k1*k2, factor(f2))
tm2
```

```
##  [1] East East East East East East East East East East East East West West
## [15] West West West West West West West West West West
## Levels: East West
```

```r
av=aov(r~tm1*tm2)
summary(av)
```

```
##             Df Sum Sq Mean Sq F value   Pr(>F)    
## tm1          2  385.1   192.5   9.554  0.00149 ** 
## tm2          1  715.0   715.0  35.481 1.23e-05 ***
## tm1:tm2      2  234.1   117.0   5.808  0.01132 *  
## Residuals   18  362.8    20.2                     
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
>
#### p-value for menu items is significant, reject null, p-value for location treatment - significant as well. Tm1:tm2 means there is possible interaction between sales volumes between coasts - people like different things by region.
