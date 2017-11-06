library(DAAG)
library(ggplot2)

data(ais)

summary(ais)

#red blood cell count, in <i></i></p>

#bmi - Body Mass Index
#pcBfat - Percenty Body fat
#lbm - Lean Body Mass
#ht - height
#wt - weight
#sex - sex
#sport - sport 


as.data.frame(ais)

# average height of athlete by female/male
ais %>% group_by(sex) %>% summarize(m=mean(ht))

# number of people by sport & sex
ais %>% count(sport, sex, sort=TRUE)

# does height & weight differ for sports?

fmsport <- ais %>% group_by(sport, sex) %>% summarize(mht=mean(ht), mwt=mean(wt), mbmi=mean(bmi), mpcBfat=mean(pcBfat))
g <- ggplot(fmsport, aes(x=sport, y=mht, color=sex)) +
  geom_point() +
  xlab("Sport") +
  ylab("Mean Height")
g


h <- ggplot(fmsport, aes(x=sport, y=mwt, color=sex)) +
  geom_point() +
  xlab("Sport") +
  ylab("Mean Weight in KG")
h

m <- ggplot(fmsport, aes(x=sport, y=mbmi, color=sex)) +
  geom_point() +
  xlab("Sport") +
  ylab("Mean BMI")
m

t <- ggplot(fmsport, aes(x=sport, y=mpcBfat, color=sex)) +
  geom_point() +
  xlab("Sport") +
  ylab("Mean Body Fat %")
t