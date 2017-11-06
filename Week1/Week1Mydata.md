# Data Analytics: Lab Week 1
Kat Bardash, 10.27.17  
####Note: Most exercises were done in 2 different ways, one using data.table, the other with either native R packages or with dplyr.
>
#### First I Will Load in Libraries

```r
library(data.table)
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:data.table':
## 
##     between, first, last
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```


> 
### Load Directly From a URL

>
## a. Read the csv file from the URL. Paste the command here.

```r
#data.table way of reading - allows urls

data <- fread("https://www.unsw.adfa.edu.au/australian-centre-for-cyber-security/cybersecurity/ADFA-NB15-Datasets/a%20part%20of%20training%20and%20testing%20set/UNSW_NB15_training-set.csv")

#native R

#data <- as.data.table(read.csv(url("https://www.unsw.adfa.edu.au/australian-centre-for-cyber-security/cybersecurity/ADFA-NB15-Datasets/a%20part%20of%20training%20and%20testing%20set/UNSW_NB15_training-set.csv")))
```

>
##b. Paste the internal structure of your object. 


```r
head(data)
```

```
##    id     dur proto service state spkts dpkts sbytes dbytes      rate sttl
## 1:  1 1.1e-05   udp       -   INT     2     0    496      0  90909.09  254
## 2:  2 8.0e-06   udp       -   INT     2     0   1762      0 125000.00  254
## 3:  3 5.0e-06   udp       -   INT     2     0   1068      0 200000.01  254
## 4:  4 6.0e-06   udp       -   INT     2     0    900      0 166666.66  254
## 5:  5 1.0e-05   udp       -   INT     2     0   2126      0 100000.00  254
## 6:  6 3.0e-06   udp       -   INT     2     0    784      0 333333.32  254
##    dttl      sload dload sloss dloss sinpkt dinpkt sjit djit swin stcpb
## 1:    0  180363632     0     0     0  0.011      0    0    0    0     0
## 2:    0  881000000     0     0     0  0.008      0    0    0    0     0
## 3:    0  854400000     0     0     0  0.005      0    0    0    0     0
## 4:    0  600000000     0     0     0  0.006      0    0    0    0     0
## 5:    0  850400000     0     0     0  0.010      0    0    0    0     0
## 6:    0 1045333312     0     0     0  0.003      0    0    0    0     0
##    dtcpb dwin tcprtt synack ackdat smean dmean trans_depth
## 1:     0    0      0      0      0   248     0           0
## 2:     0    0      0      0      0   881     0           0
## 3:     0    0      0      0      0   534     0           0
## 4:     0    0      0      0      0   450     0           0
## 5:     0    0      0      0      0  1063     0           0
## 6:     0    0      0      0      0   392     0           0
##    response_body_len ct_srv_src ct_state_ttl ct_dst_ltm ct_src_dport_ltm
## 1:                 0          2            2          1                1
## 2:                 0          2            2          1                1
## 3:                 0          3            2          1                1
## 4:                 0          3            2          2                2
## 5:                 0          3            2          2                2
## 6:                 0          2            2          2                2
##    ct_dst_sport_ltm ct_dst_src_ltm is_ftp_login ct_ftp_cmd
## 1:                1              2            0          0
## 2:                1              2            0          0
## 3:                1              3            0          0
## 4:                1              3            0          0
## 5:                1              3            0          0
## 6:                1              2            0          0
##    ct_flw_http_mthd ct_src_ltm ct_srv_dst is_sm_ips_ports attack_cat label
## 1:                0          1          2               0     Normal     0
## 2:                0          1          2               0     Normal     0
## 3:                0          1          3               0     Normal     0
## 4:                0          2          3               0     Normal     0
## 5:                0          2          3               0     Normal     0
## 6:                0          2          2               0     Normal     0
```

```r
str(data)
```

```
## Classes 'data.table' and 'data.frame':	82332 obs. of  45 variables:
##  $ id               : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ dur              : num  1.1e-05 8.0e-06 5.0e-06 6.0e-06 1.0e-05 3.0e-06 6.0e-06 2.8e-05 0.0 0.0 ...
##  $ proto            : chr  "udp" "udp" "udp" "udp" ...
##  $ service          : chr  "-" "-" "-" "-" ...
##  $ state            : chr  "INT" "INT" "INT" "INT" ...
##  $ spkts            : int  2 2 2 2 2 2 2 2 1 1 ...
##  $ dpkts            : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ sbytes           : int  496 1762 1068 900 2126 784 1960 1384 46 46 ...
##  $ dbytes           : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ rate             : num  90909 125000 200000 166667 100000 ...
##  $ sttl             : int  254 254 254 254 254 254 254 254 0 0 ...
##  $ dttl             : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ sload            : num  1.80e+08 8.81e+08 8.54e+08 6.00e+08 8.50e+08 ...
##  $ dload            : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ sloss            : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ dloss            : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ sinpkt           : num  0.011 0.008 0.005 0.006 0.01 ...
##  $ dinpkt           : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ sjit             : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ djit             : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ swin             : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ stcpb            :integer64 0 0 0 0 0 0 0 0 ... 
##  $ dtcpb            :integer64 0 0 0 0 0 0 0 0 ... 
##  $ dwin             : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ tcprtt           : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ synack           : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ ackdat           : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ smean            : int  248 881 534 450 1063 392 980 692 46 46 ...
##  $ dmean            : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ trans_depth      : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ response_body_len: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ ct_srv_src       : int  2 2 3 3 3 2 2 3 2 2 ...
##  $ ct_state_ttl     : int  2 2 2 2 2 2 2 2 2 2 ...
##  $ ct_dst_ltm       : int  1 1 1 2 2 2 2 1 2 2 ...
##  $ ct_src_dport_ltm : int  1 1 1 2 2 2 2 1 2 2 ...
##  $ ct_dst_sport_ltm : int  1 1 1 1 1 1 1 1 2 2 ...
##  $ ct_dst_src_ltm   : int  2 2 3 3 3 2 2 3 2 2 ...
##  $ is_ftp_login     : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ ct_ftp_cmd       : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ ct_flw_http_mthd : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ ct_src_ltm       : int  1 1 1 2 2 2 2 1 2 2 ...
##  $ ct_srv_dst       : int  2 2 3 3 3 2 2 3 2 2 ...
##  $ is_sm_ips_ports  : int  0 0 0 0 0 0 0 0 1 1 ...
##  $ attack_cat       : chr  "Normal" "Normal" "Normal" "Normal" ...
##  $ label            : int  0 0 0 0 0 0 0 0 0 0 ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

```r
summary(data)
```

```
##        id             dur              proto             service         
##  Min.   :    1   Min.   : 0.00000   Length:82332       Length:82332      
##  1st Qu.:20584   1st Qu.: 0.00001   Class :character   Class :character  
##  Median :41167   Median : 0.01414   Mode  :character   Mode  :character  
##  Mean   :41167   Mean   : 1.00676                                        
##  3rd Qu.:61749   3rd Qu.: 0.71936                                        
##  Max.   :82332   Max.   :59.99999                                        
##     state               spkts              dpkts         
##  Length:82332       Min.   :    1.00   Min.   :    0.00  
##  Class :character   1st Qu.:    2.00   1st Qu.:    0.00  
##  Mode  :character   Median :    6.00   Median :    2.00  
##                     Mean   :   18.67   Mean   :   17.55  
##                     3rd Qu.:   12.00   3rd Qu.:   10.00  
##                     Max.   :10646.00   Max.   :11018.00  
##      sbytes             dbytes              rate                sttl    
##  Min.   :      24   Min.   :       0   Min.   :      0.0   Min.   :  0  
##  1st Qu.:     114   1st Qu.:       0   1st Qu.:     28.6   1st Qu.: 62  
##  Median :     534   Median :     178   Median :   2650.2   Median :254  
##  Mean   :    7994   Mean   :   13234   Mean   :  82410.9   Mean   :181  
##  3rd Qu.:    1280   3rd Qu.:     956   3rd Qu.: 111111.1   3rd Qu.:254  
##  Max.   :14355774   Max.   :14657531   Max.   :1000000.0   Max.   :255  
##       dttl            sload               dload         
##  Min.   :  0.00   Min.   :0.000e+00   Min.   :       0  
##  1st Qu.:  0.00   1st Qu.:1.120e+04   1st Qu.:       0  
##  Median : 29.00   Median :5.770e+05   Median :    2113  
##  Mean   : 95.71   Mean   :6.455e+07   Mean   :  630547  
##  3rd Qu.:252.00   3rd Qu.:6.514e+07   3rd Qu.:   15858  
##  Max.   :253.00   Max.   :5.268e+09   Max.   :20821108  
##      sloss              dloss              sinpkt        
##  Min.   :   0.000   Min.   :   0.000   Min.   :    0.00  
##  1st Qu.:   0.000   1st Qu.:   0.000   1st Qu.:    0.01  
##  Median :   1.000   Median :   0.000   Median :    0.56  
##  Mean   :   4.754   Mean   :   6.309   Mean   :  755.39  
##  3rd Qu.:   3.000   3rd Qu.:   2.000   3rd Qu.:   63.41  
##  Max.   :5319.000   Max.   :5507.000   Max.   :60009.99  
##      dinpkt              sjit                djit               swin      
##  Min.   :    0.00   Min.   :      0.0   Min.   :     0.0   Min.   :  0.0  
##  1st Qu.:    0.00   1st Qu.:      0.0   1st Qu.:     0.0   1st Qu.:  0.0  
##  Median :    0.01   Median :     17.6   Median :     0.0   Median :255.0  
##  Mean   :  121.70   Mean   :   6363.1   Mean   :   535.2   Mean   :133.5  
##  3rd Qu.:   63.14   3rd Qu.:   3219.3   3rd Qu.:   128.5   3rd Qu.:255.0  
##  Max.   :57739.24   Max.   :1483830.9   Max.   :463199.2   Max.   :255.0  
##      stcpb                dtcpb                 dwin      
##  Min.   :         0   Min.   :         0   Min.   :  0.0  
##  1st Qu.:         0   1st Qu.:         0   1st Qu.:  0.0  
##  Median :  27852605   Median :  28477324   Median :255.0  
##  Mean   :1084641551   Mean   :1073464670   Mean   :128.3  
##  3rd Qu.:2171288916   3rd Qu.:2144195214   3rd Qu.:255.0  
##  Max.   :4294949667   Max.   :4294880717   Max.   :255.0  
##      tcprtt             synack             ackdat            smean       
##  Min.   :0.000000   Min.   :0.000000   Min.   :0.00000   Min.   :  24.0  
##  1st Qu.:0.000000   1st Qu.:0.000000   1st Qu.:0.00000   1st Qu.:  57.0  
##  Median :0.000551   Median :0.000441   Median :0.00008   Median :  65.0  
##  Mean   :0.055925   Mean   :0.029256   Mean   :0.02667   Mean   : 139.5  
##  3rd Qu.:0.105541   3rd Qu.:0.052596   3rd Qu.:0.04882   3rd Qu.: 100.0  
##  Max.   :3.821465   Max.   :3.226788   Max.   :2.92878   Max.   :1504.0  
##      dmean         trans_depth        response_body_len   ct_srv_src    
##  Min.   :   0.0   Min.   :  0.00000   Min.   :      0   Min.   : 1.000  
##  1st Qu.:   0.0   1st Qu.:  0.00000   1st Qu.:      0   1st Qu.: 2.000  
##  Median :  44.0   Median :  0.00000   Median :      0   Median : 5.000  
##  Mean   : 116.3   Mean   :  0.09428   Mean   :   1595   Mean   : 9.547  
##  3rd Qu.:  87.0   3rd Qu.:  0.00000   3rd Qu.:      0   3rd Qu.:11.000  
##  Max.   :1500.0   Max.   :131.00000   Max.   :5242880   Max.   :63.000  
##   ct_state_ttl     ct_dst_ltm     ct_src_dport_ltm ct_dst_sport_ltm
##  Min.   :0.000   Min.   : 1.000   Min.   : 1.000   Min.   : 1.000  
##  1st Qu.:1.000   1st Qu.: 1.000   1st Qu.: 1.000   1st Qu.: 1.000  
##  Median :1.000   Median : 2.000   Median : 1.000   Median : 1.000  
##  Mean   :1.369   Mean   : 5.745   Mean   : 4.929   Mean   : 3.663  
##  3rd Qu.:2.000   3rd Qu.: 6.000   3rd Qu.: 4.000   3rd Qu.: 3.000  
##  Max.   :6.000   Max.   :59.000   Max.   :59.000   Max.   :38.000  
##  ct_dst_src_ltm    is_ftp_login        ct_ftp_cmd       ct_flw_http_mthd 
##  Min.   : 1.000   Min.   :0.000000   Min.   :0.000000   Min.   : 0.0000  
##  1st Qu.: 1.000   1st Qu.:0.000000   1st Qu.:0.000000   1st Qu.: 0.0000  
##  Median : 3.000   Median :0.000000   Median :0.000000   Median : 0.0000  
##  Mean   : 7.456   Mean   :0.008283   Mean   :0.008381   Mean   : 0.1297  
##  3rd Qu.: 6.000   3rd Qu.:0.000000   3rd Qu.:0.000000   3rd Qu.: 0.0000  
##  Max.   :63.000   Max.   :2.000000   Max.   :2.000000   Max.   :16.0000  
##    ct_src_ltm       ct_srv_dst     is_sm_ips_ports    attack_cat       
##  Min.   : 1.000   Min.   : 1.000   Min.   :0.00000   Length:82332      
##  1st Qu.: 1.000   1st Qu.: 2.000   1st Qu.:0.00000   Class :character  
##  Median : 3.000   Median : 5.000   Median :0.00000   Mode  :character  
##  Mean   : 6.468   Mean   : 9.164   Mean   :0.01113                     
##  3rd Qu.: 7.000   3rd Qu.:11.000   3rd Qu.:0.00000                     
##  Max.   :60.000   Max.   :62.000   Max.   :1.00000                     
##      label       
##  Min.   :0.0000  
##  1st Qu.:0.0000  
##  Median :1.0000  
##  Mean   :0.5506  
##  3rd Qu.:1.0000  
##  Max.   :1.0000
```

>
##2.a How many tcp, udp, sctp, and arp packets are there in the data set? 
##b. Count occurances of all 131 unique members of this field.


```r
#data.table method to get list of counts of all packet types
data2 <- as.data.table(data)

npak <- data2[, .('Number of Rows' =.N), by=proto]
npak
```

```
##         proto Number of Rows
##   1:      udp          29418
##   2:      arp            987
##   3:      tcp          43095
##   4:     igmp             30
##   5:     ospf            676
##  ---                        
## 127: sccopmce             32
## 128:     iplt             32
## 129:     pipe             32
## 130:      sps             32
## 131:       ib             31
```

```r
#to see all 132 rows
# print(npak, nrow=132)

# data.table get specific packets
npakS <- data2[proto=="tcp" | proto=="udp" | proto=="sctp" | proto=="arp" , .('Number of Rows' =.N), by=proto]
npakS
```

```
##    proto Number of Rows
## 1:   udp          29418
## 2:   arp            987
## 3:   tcp          43095
## 4:  sctp            324
```

```r
# using %in%
npakS <- subset(data2, proto %in% c('tcp', "udp", "sctp", "arp"))
npakS
```

```
##           id      dur proto service state spkts dpkts sbytes dbytes
##     1:     1 0.000011   udp       -   INT     2     0    496      0
##     2:     2 0.000008   udp       -   INT     2     0   1762      0
##     3:     3 0.000005   udp       -   INT     2     0   1068      0
##     4:     4 0.000006   udp       -   INT     2     0    900      0
##     5:     5 0.000010   udp       -   INT     2     0   2126      0
##    ---                                                             
## 73820: 82328 0.000005   udp       -   INT     2     0    104      0
## 73821: 82329 1.106101   tcp       -   FIN    20     8  18062    354
## 73822: 82330 0.000000   arp       -   INT     1     0     46      0
## 73823: 82331 0.000000   arp       -   INT     1     0     46      0
## 73824: 82332 0.000009   udp       -   INT     2     0    104      0
##                rate sttl dttl       sload   dload sloss dloss      sinpkt
##     1:  90909.09020  254    0 180363632.0    0.00     0     0     0.01100
##     2: 125000.00030  254    0 881000000.0    0.00     0     0     0.00800
##     3: 200000.00510  254    0 854400000.0    0.00     0     0     0.00500
##     4: 166666.66080  254    0 600000000.0    0.00     0     0     0.00600
##     5: 100000.00250  254    0 850400000.0    0.00     0     0     0.01000
##    ---                                                                   
## 73820: 200000.00510  254    0  83200000.0    0.00     0     0     0.00500
## 73821:     24.41007  254  252    124104.4 2242.11     7     1    55.88005
## 73822:      0.00000    0    0         0.0    0.00     0     0 60000.72000
## 73823:      0.00000    0    0         0.0    0.00     0     0 60000.73200
## 73824: 111111.10720  254    0  46222220.0    0.00     0     0     0.00900
##        dinpkt       sjit     djit swin         stcpb         dtcpb dwin
##     1:    0.0    0.00000   0.0000    0  0.000000e+00  0.000000e+00    0
##     2:    0.0    0.00000   0.0000    0  0.000000e+00  0.000000e+00    0
##     3:    0.0    0.00000   0.0000    0  0.000000e+00  0.000000e+00    0
##     4:    0.0    0.00000   0.0000    0  0.000000e+00  0.000000e+00    0
##     5:    0.0    0.00000   0.0000    0  0.000000e+00  0.000000e+00    0
##    ---                                                                 
## 73820:    0.0    0.00000   0.0000    0  0.000000e+00  0.000000e+00    0
## 73821:  143.7 4798.13098 190.9808  255 5.299028e-315 1.622656e-314  255
## 73822:    0.0    0.00000   0.0000    0  0.000000e+00  0.000000e+00    0
## 73823:    0.0   10.95452   0.0000    0  0.000000e+00  0.000000e+00    0
## 73824:    0.0    0.00000   0.0000    0  0.000000e+00  0.000000e+00    0
##          tcprtt   synack   ackdat smean dmean trans_depth
##     1: 0.000000 0.000000 0.000000   248     0           0
##     2: 0.000000 0.000000 0.000000   881     0           0
##     3: 0.000000 0.000000 0.000000   534     0           0
##     4: 0.000000 0.000000 0.000000   450     0           0
##     5: 0.000000 0.000000 0.000000  1063     0           0
##    ---                                                   
## 73820: 0.000000 0.000000 0.000000    52     0           0
## 73821: 0.173208 0.100191 0.073017   903    44           0
## 73822: 0.000000 0.000000 0.000000    46     0           0
## 73823: 0.000000 0.000000 0.000000    46     0           0
## 73824: 0.000000 0.000000 0.000000    52     0           0
##        response_body_len ct_srv_src ct_state_ttl ct_dst_ltm
##     1:                 0          2            2          1
##     2:                 0          2            2          1
##     3:                 0          3            2          1
##     4:                 0          3            2          2
##     5:                 0          3            2          2
##    ---                                                     
## 73820:                 0          1            2          2
## 73821:                 0          1            1          2
## 73822:                 0          1            2          1
## 73823:                 0          1            2          1
## 73824:                 0          1            2          1
##        ct_src_dport_ltm ct_dst_sport_ltm ct_dst_src_ltm is_ftp_login
##     1:                1                1              2            0
##     2:                1                1              2            0
##     3:                1                1              3            0
##     4:                2                1              3            0
##     5:                2                1              3            0
##    ---                                                              
## 73820:                1                1              2            0
## 73821:                1                1              1            0
## 73822:                1                1              1            0
## 73823:                1                1              1            0
## 73824:                1                1              1            0
##        ct_ftp_cmd ct_flw_http_mthd ct_src_ltm ct_srv_dst is_sm_ips_ports
##     1:          0                0          1          2               0
##     2:          0                0          1          2               0
##     3:          0                0          1          3               0
##     4:          0                0          2          3               0
##     5:          0                0          2          3               0
##    ---                                                                  
## 73820:          0                0          2          1               0
## 73821:          0                0          3          2               0
## 73822:          0                0          1          1               1
## 73823:          0                0          1          1               1
## 73824:          0                0          1          1               0
##        attack_cat label
##     1:     Normal     0
##     2:     Normal     0
##     3:     Normal     0
##     4:     Normal     0
##     5:     Normal     0
##    ---                 
## 73820:     Normal     0
## 73821:     Normal     0
## 73822:     Normal     0
## 73823:     Normal     0
## 73824:     Normal     0
```

```r
# dplyr method
data_df <- as.data.frame(data)
data %>% filter(proto=="tcp" | proto=="udp" | proto=="sctp" | proto=="arp") %>% group_by(proto) %>% summarise(n=n())
```

```
## # A tibble: 4 x 2
##   proto     n
##   <chr> <int>
## 1   arp   987
## 2  sctp   324
## 3   tcp 43095
## 4   udp 29418
```

>##3. What is the mean packet size by protocol? Use the spkts variable. Only provide the first five from your console output.


```r
#data.table method
datMean <- data2[, .(mean=mean(spkts)), by=proto]

datMean[1:5,]
```

```
##    proto      mean
## 1:   udp  2.246278
## 2:   arp  1.161094
## 3:   tcp 32.953893
## 4:  igmp  2.000000
## 5:  ospf 38.464497
```

```r
#data.table method, using lapply
data2[, lapply(.SD, mean), by=proto, .SDcols=c("spkts")]
```

```
##         proto     spkts
##   1:      udp  2.246278
##   2:      arp  1.161094
##   3:      tcp 32.953893
##   4:     igmp  2.000000
##   5:     ospf 38.464497
##  ---                   
## 127: sccopmce  2.000000
## 128:     iplt  2.000000
## 129:     pipe  2.000000
## 130:      sps  2.000000
## 131:       ib  2.000000
```

```r
# dplyr method
mean_dt <- data %>% group_by(proto) %>% summarize(m=mean(spkts))
head(mean_dt, n=5)
```

```
## # A tibble: 5 x 2
##       proto     m
##       <chr> <dbl>
## 1       3pc     2
## 2       a/n     2
## 3 aes-sp3-d     2
## 4       any     2
## 5     argus     2
```

>
##4 Five protocols with the greatest mean packet size - descending order 


```r
#data.table method
setorder(datMean, -mean)
datMean[1:5,]
```

```
##    proto      mean
## 1:  ospf 38.464497
## 2:   tcp 32.953893
## 3:  sctp 23.104938
## 4:   pim  4.307692
## 5:   st2  4.000000
```

```r
#dplyr method
sorted <- arrange(mean_dt, desc(m))
sorted[1:5,]
```

```
## # A tibble: 5 x 2
##   proto         m
##   <chr>     <dbl>
## 1  ospf 38.464497
## 2   tcp 32.953893
## 3  sctp 23.104938
## 4   pim  4.307692
## 5   cbt  4.000000
```

>
## 5 Create a .txt or .csv with provided data and use read.csv(() or read.table to read your file into an object called "my_data". 


```r
data5<- read.table("./my_data.txt", sep=",", header=FALSE, nrow=3)
head(data5)
```

```
##   V1 V2 V3
## 1  1  2  3
## 2  4  5  6
## 3  7  8  9
```

>
## b &c. Write an apply() function to calculate sums by row, then by colum

```r
#by row
apply(data5, 1, mean)
```

```
## [1] 2 5 8
```

```r
#by column
apply(data5, 2, mean)
```

```
## V1 V2 V3 
##  4  5  6
```

>
## d. Write an apply function to calculate sums by row and column. **** Did not *****Use margin=c(1,2)*****

```r
rowSum <- apply(data5, 1, sum)
colSum <- apply(data5, 2, mean)

print(rbind(cbind(data5, Rtot=rowSum), Ctot=c(colSum, sum(colSum))))
```

```
##   V1 V2 V3 Rtot
## 1  1  2  3    6
## 2  4  5  6   15
## 3  7  8  9   24
## 4  4  5  6   15
```

```r
# replacing sum with simple function
#by row
apply(data5, 1, function(x) x+1)
```

```
##    [,1] [,2] [,3]
## V1    2    5    8
## V2    3    6    9
## V3    4    7   10
```

```r
#by column ** makes more sense
apply(data5, 2, function(x) x+1)
```

```
##      V1 V2 V3
## [1,]  2  3  4
## [2,]  5  6  7
## [3,]  8  9 10
```
