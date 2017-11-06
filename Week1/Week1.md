# Assignment Week 1
Kat  

>
## Step 1: Load the dataset into R & verify data

```r
library(UsingR)
```

```
## Loading required package: MASS
```

```
## Loading required package: HistData
```

```
## Loading required package: Hmisc
```

```
## Loading required package: lattice
```

```
## Loading required package: survival
```

```
## Loading required package: Formula
```

```
## Loading required package: ggplot2
```

```
## 
## Attaching package: 'Hmisc'
```

```
## The following objects are masked from 'package:base':
## 
##     format.pval, round.POSIXt, trunc.POSIXt, units
```

```
## 
## Attaching package: 'UsingR'
```

```
## The following object is masked from 'package:survival':
## 
##     cancer
```

```r
data(iris)
str(iris)
```

```
## 'data.frame':	150 obs. of  5 variables:
##  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
##  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
##  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
##  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
##  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
```

```r
summary(iris)
```

```
##   Sepal.Length    Sepal.Width     Petal.Length    Petal.Width   
##  Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100  
##  1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300  
##  Median :5.800   Median :3.000   Median :4.350   Median :1.300  
##  Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199  
##  3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800  
##  Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500  
##        Species  
##  setosa    :50  
##  versicolor:50  
##  virginica :50  
##                 
##                 
## 
```

```r
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

>## Step 2: Convert Iris to a data table


```r
#install.packages('data.table')
library(data.table)
DT <- as.data.table(iris)
print(DT)
```

```
##      Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
##   1:          5.1         3.5          1.4         0.2    setosa
##   2:          4.9         3.0          1.4         0.2    setosa
##   3:          4.7         3.2          1.3         0.2    setosa
##   4:          4.6         3.1          1.5         0.2    setosa
##   5:          5.0         3.6          1.4         0.2    setosa
##  ---                                                            
## 146:          6.7         3.0          5.2         2.3 virginica
## 147:          6.3         2.5          5.0         1.9 virginica
## 148:          6.5         3.0          5.2         2.0 virginica
## 149:          6.2         3.4          5.4         2.3 virginica
## 150:          5.9         3.0          5.1         1.8 virginica
```

>
## Step 3: Begin Outputting Summary Functions

```r
DT[,mean(Sepal.Length), by=Species]
```

```
##       Species    V1
## 1:     setosa 5.006
## 2: versicolor 5.936
## 3:  virginica 6.588
```

```r
DT[,mean(Sepal.Length), by=substring(Species,1,1)]
```

```
##    substring    V1
## 1:         s 5.006
## 2:         v 6.262
```

```r
DT[,.N, by=10*round(Sepal.Length*Sepal.Width/10)]
```

```
##    round   N
## 1:    20 117
## 2:    10  29
## 3:    30   4
```

```r
DT[,.N, by=10*round(Sepal.Length*Sepal.Width/10)]
```

```
##    round   N
## 1:    20 117
## 2:    10  29
## 3:    30   4
```

```r
DT[,.(Count=.N), by=.(Area=10*round(Sepal.Length*Sepal.Width/10))]
```

```
##    Area Count
## 1:   20   117
## 2:   10    29
## 3:   30     4
```

>
### Step 4: Chaining

```r
DT[,.(Sepal_length=median(Sepal.Length),
      Sepal_width=median(Sepal.Width),
      Petal_length=median(Petal.Length),
      Petal_width=median(Petal.Width)),
   by=Species][order(-Species)]
```

```
##       Species Sepal_length Sepal_width Petal_length Petal_width
## 1:  virginica          6.5         3.0         5.55         2.0
## 2: versicolor          5.9         2.8         4.35         1.3
## 3:     setosa          5.0         3.4         1.50         0.2
```

> 
### Step 5:Subset of the data table


```r
DT[,lapply(.SD,mean),by=Species]
```

```
##       Species Sepal.Length Sepal.Width Petal.Length Petal.Width
## 1:     setosa        5.006       3.428        1.462       0.246
## 2: versicolor        5.936       2.770        4.260       1.326
## 3:  virginica        6.588       2.974        5.552       2.026
```

```r
DT[,lapply(.SD,max), by=Species]
```

```
##       Species Sepal.Length Sepal.Width Petal.Length Petal.Width
## 1:     setosa          5.8         4.4          1.9         0.6
## 2: versicolor          7.0         3.4          5.1         1.8
## 3:  virginica          7.9         3.8          6.9         2.5
```

```r
DT[,lapply(.SD, max), by=Species]
```

```
##       Species Sepal.Length Sepal.Width Petal.Length Petal.Width
## 1:     setosa          5.8         4.4          1.9         0.6
## 2: versicolor          7.0         3.4          5.1         1.8
## 3:  virginica          7.9         3.8          6.9         2.5
```

>
### Step 6: Additional Commands


```r
iris=as.data.table(iris)
DT1 <- iris[Species == "virginica"]
head(DT1)
```

```
##    Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
## 1:          6.3         3.3          6.0         2.5 virginica
## 2:          5.8         2.7          5.1         1.9 virginica
## 3:          7.1         3.0          5.9         2.1 virginica
## 4:          6.3         2.9          5.6         1.8 virginica
## 5:          6.5         3.0          5.8         2.2 virginica
## 6:          7.6         3.0          6.6         2.1 virginica
```

```r
DT2 <- iris[Species %in% c("viginica", "versicolor")]
setnames(iris, gsub("^Sepal[.]", "", names(iris)))
iris <- iris[, grep("^Petal", names(iris)) := NULL]
head(iris)
```

```
##    Length Width Species
## 1:    5.1   3.5  setosa
## 2:    4.9   3.0  setosa
## 3:    4.7   3.2  setosa
## 4:    4.6   3.1  setosa
## 5:    5.0   3.6  setosa
## 6:    5.4   3.9  setosa
```

```r
iris[Width*Length>20]
```

```
##     Length Width    Species
##  1:    5.4   3.9     setosa
##  2:    5.8   4.0     setosa
##  3:    5.7   4.4     setosa
##  4:    5.4   3.9     setosa
##  5:    5.7   3.8     setosa
##  6:    5.2   4.1     setosa
##  7:    5.5   4.2     setosa
##  8:    7.0   3.2 versicolor
##  9:    6.4   3.2 versicolor
## 10:    6.9   3.1 versicolor
## 11:    6.3   3.3 versicolor
## 12:    6.7   3.1 versicolor
## 13:    6.7   3.0 versicolor
## 14:    6.0   3.4 versicolor
## 15:    6.7   3.1 versicolor
## 16:    6.3   3.3  virginica
## 17:    7.1   3.0  virginica
## 18:    7.6   3.0  virginica
## 19:    7.3   2.9  virginica
## 20:    7.2   3.6  virginica
## 21:    6.5   3.2  virginica
## 22:    6.8   3.0  virginica
## 23:    6.4   3.2  virginica
## 24:    7.7   3.8  virginica
## 25:    7.7   2.6  virginica
## 26:    6.9   3.2  virginica
## 27:    7.7   2.8  virginica
## 28:    6.7   3.3  virginica
## 29:    7.2   3.2  virginica
## 30:    7.2   3.0  virginica
## 31:    7.4   2.8  virginica
## 32:    7.9   3.8  virginica
## 33:    7.7   3.0  virginica
## 34:    6.3   3.4  virginica
## 35:    6.9   3.1  virginica
## 36:    6.7   3.1  virginica
## 37:    6.9   3.1  virginica
## 38:    6.8   3.2  virginica
## 39:    6.7   3.3  virginica
## 40:    6.7   3.0  virginica
## 41:    6.2   3.4  virginica
##     Length Width    Species
```
>
## I will look at US Cereals and compare nutritional information

```r
library(MASS) 
data(UScereal)
head(UScereal)
```

```
##                           mfr calories   protein      fat   sodium
## 100% Bran                   N 212.1212 12.121212 3.030303 393.9394
## All-Bran                    K 212.1212 12.121212 3.030303 787.8788
## All-Bran with Extra Fiber   K 100.0000  8.000000 0.000000 280.0000
## Apple Cinnamon Cheerios     G 146.6667  2.666667 2.666667 240.0000
## Apple Jacks                 K 110.0000  2.000000 0.000000 125.0000
## Basic 4                     G 173.3333  4.000000 2.666667 280.0000
##                               fibre    carbo   sugars shelf potassium
## 100% Bran                 30.303030 15.15152 18.18182     3 848.48485
## All-Bran                  27.272727 21.21212 15.15151     3 969.69697
## All-Bran with Extra Fiber 28.000000 16.00000  0.00000     3 660.00000
## Apple Cinnamon Cheerios    2.000000 14.00000 13.33333     1  93.33333
## Apple Jacks                1.000000 11.00000 14.00000     2  30.00000
## Basic 4                    2.666667 24.00000 10.66667     3 133.33333
##                           vitamins
## 100% Bran                 enriched
## All-Bran                  enriched
## All-Bran with Extra Fiber enriched
## Apple Cinnamon Cheerios   enriched
## Apple Jacks               enriched
## Basic 4                   enriched
```

```r
summary(UScereal)
```

```
##  mfr       calories        protein             fat            sodium     
##  G:22   Min.   : 50.0   Min.   : 0.7519   Min.   :0.000   Min.   :  0.0  
##  K:21   1st Qu.:110.0   1st Qu.: 2.0000   1st Qu.:0.000   1st Qu.:180.0  
##  N: 3   Median :134.3   Median : 3.0000   Median :1.000   Median :232.0  
##  P: 9   Mean   :149.4   Mean   : 3.6837   Mean   :1.423   Mean   :237.8  
##  Q: 5   3rd Qu.:179.1   3rd Qu.: 4.4776   3rd Qu.:2.000   3rd Qu.:290.0  
##  R: 5   Max.   :440.0   Max.   :12.1212   Max.   :9.091   Max.   :787.9  
##      fibre            carbo           sugars          shelf      
##  Min.   : 0.000   Min.   :10.53   Min.   : 0.00   Min.   :1.000  
##  1st Qu.: 0.000   1st Qu.:15.00   1st Qu.: 4.00   1st Qu.:1.000  
##  Median : 2.000   Median :18.67   Median :12.00   Median :2.000  
##  Mean   : 3.871   Mean   :19.97   Mean   :10.05   Mean   :2.169  
##  3rd Qu.: 4.478   3rd Qu.:22.39   3rd Qu.:14.00   3rd Qu.:3.000  
##  Max.   :30.303   Max.   :68.00   Max.   :20.90   Max.   :3.000  
##    potassium          vitamins 
##  Min.   : 15.00   100%    : 5  
##  1st Qu.: 45.00   enriched:57  
##  Median : 96.59   none    : 3  
##  Mean   :159.12                
##  3rd Qu.:220.00                
##  Max.   :969.70
```

```r
str(UScereal)
```

```
## 'data.frame':	65 obs. of  11 variables:
##  $ mfr      : Factor w/ 6 levels "G","K","N","P",..: 3 2 2 1 2 1 6 4 5 1 ...
##  $ calories : num  212 212 100 147 110 ...
##  $ protein  : num  12.12 12.12 8 2.67 2 ...
##  $ fat      : num  3.03 3.03 0 2.67 0 ...
##  $ sodium   : num  394 788 280 240 125 ...
##  $ fibre    : num  30.3 27.3 28 2 1 ...
##  $ carbo    : num  15.2 21.2 16 14 11 ...
##  $ sugars   : num  18.2 15.2 0 13.3 14 ...
##  $ shelf    : int  3 3 3 1 2 3 1 3 2 1 ...
##  $ potassium: num  848.5 969.7 660 93.3 30 ...
##  $ vitamins : Factor w/ 3 levels "100%","enriched",..: 2 2 2 2 2 2 2 2 2 2 ...
```

```r
data <- UScereal
```

>
## Loading and looking at the data


```r
#Link to explanation of variables
# https://cran.r-project.org/web/packages/MASS/MASS.pdf
library(data.table)
setorder(data, -sugars)
head(data[,c(1,8)],n=10)
```

```
##                       mfr   sugars
## Post Nat. Raisin Bran   P 20.89552
## Oatmeal Raisin Crisp    G 20.00000
## Smacks                  K 20.00000
## Mueslix Crispy Blend    K 19.40299
## 100% Bran               N 18.18182
## Fruitful Bran           K 17.91045
## Golden Crisp            P 17.04546
## Cap'n'Crunch            Q 16.00000
## Fruity Pebbles          P 16.00000
## Raisin Bran             K 16.00000
```


>
## What are the mean values of across all nutrional content by Manufacturer? Which cereal manufacturer makes the least nutritious cereals overall?

#### Post has the most calories and sugar content in their cereals. It is also slightly higher in fat compared to the others as well as has the 2nd highest sodium content and 2nd highest carb content (24.28 compared with 24.45 for first).


```r
#G=General Mills, K=Kelloggs, N=Nabisco, P=Post, Q=Quaker Oats, R=Ralston Purina.

numData <- data[,1:9]
numData <- as.data.table(numData)
sumMFR <- numData[, lapply(.SD, mean), by=mfr]
setorder(sumMFR, -calories, -sugars)
sumMFR
```

```
##    mfr calories  protein       fat   sodium     fibre    carbo    sugars
## 1:   P 194.7578 4.698975 1.7820242 253.7316  5.375622 24.28115 12.711416
## 2:   N 160.2593 7.025479 1.0101010 131.3131 13.583597 24.45349  6.060606
## 3:   K 149.6710 3.918530 1.0234757 242.7893  5.068602 19.79582 10.798201
## 4:   G 137.7879 2.884848 1.7848485 240.3939  1.648485 17.69394 10.051515
## 5:   Q 135.8507 3.460697 1.9303483 201.4428  1.597015 17.38209  9.591045
## 6:   R 124.8521 2.602862 0.5970149 277.5027  2.356219 22.82303  4.973883
##       shelf
## 1: 2.444444
## 2: 1.666667
## 3: 2.285714
## 4: 2.136364
## 5: 2.400000
## 6: 1.400000
```

>
## What is the mean/median sugar content by manufacturer?
##### It looks like Post has the highest average sugar content in their cereals with 12.7 grams. Interestingly, the median sugar content goes up by about 2 grams when looking at the median, which makes me think they have at least 1 low sugar content cereal bringing their average down. 

```r
data <- as.data.table(data)
meanD <- setorder((data[, .(mean=mean(sugars)), by=mfr]), -mean)
meanD
```

```
##    mfr      mean
## 1:   P 12.711416
## 2:   K 10.798201
## 3:   G 10.051515
## 4:   Q  9.591045
## 5:   N  6.060606
## 6:   R  4.973883
```

```r
medianD <- setorder((data[, .(median=median(sugars)), by=mfr]), -median)
medianD
```

```
##    mfr    median
## 1:   P 12.121212
## 2:   G 12.000000
## 3:   K 12.000000
## 4:   Q 11.000000
## 5:   R  4.477612
## 6:   N  0.000000
```

>
## Which cereal manufacturer makes the relatively healthier cereal based on high protein, high fibre, low calories?

##### It seems that Nabisco makes the cereals with the highest average protein, highest fiber (13.5 g vs 5.35 for next highest), but on the higher side of calories. Sodium content is lowest among these cereals. Fat is second lowest (1.01 g vg .59 g for lowest, avg=1). Sugar content is on the lower than the average (6.606g vs 10.05 avg)

```r
setorder(sumMFR, -protein, -fibre, -calories)
sumMFR
```

```
##    mfr calories  protein       fat   sodium     fibre    carbo    sugars
## 1:   N 160.2593 7.025479 1.0101010 131.3131 13.583597 24.45349  6.060606
## 2:   P 194.7578 4.698975 1.7820242 253.7316  5.375622 24.28115 12.711416
## 3:   K 149.6710 3.918530 1.0234757 242.7893  5.068602 19.79582 10.798201
## 4:   Q 135.8507 3.460697 1.9303483 201.4428  1.597015 17.38209  9.591045
## 5:   G 137.7879 2.884848 1.7848485 240.3939  1.648485 17.69394 10.051515
## 6:   R 124.8521 2.602862 0.5970149 277.5027  2.356219 22.82303  4.973883
##       shelf
## 1: 1.666667
## 2: 2.444444
## 3: 2.285714
## 4: 2.400000
## 5: 2.136364
## 6: 1.400000
```


