setwd("~/R/eChecker/tractionCapacity")
source("fun.R")

# read calibration data
df1 <- readcsv("calvoor1_05_04.csv", compressed = T)
calBefore <- calibrate(df1)

df2 <- readcsv("calna1_05_04.csv", compressed = T)
calAfter <- calibrate(df2)

Pcal = (calAfter$Pmean + calBefore$Pmean) / 2
# check speed manually

# read test data
test <- readcsv("test1_05_04.csv", compressed = T)
#plot(test$ta, test$Pa1)

# check head and tail to look for start and stop time
selHead <- head(test, 10000)
plot(selHead$ta, selHead$Pa1) # 40 s

selTail <- tail(test, 10000)
plot(selTail$ta, selTail$Pa1) # 5230 s

# subset relevant data for motor power
sel <- subset(test, ta > 40 & ta < 5230)
plot(sel$ta, sel$Pa1)

# calculate traction energy/capacity
#plot(sel$ta, Pcal - sel$Pa1)
sel$Pmotor <- Pcal - sel$Pa1
sel$Emotor <- cumsum(sel$Pmotor * c(0.01, diff(sel$ta)))
Etot <- tail(sel$Emotor,1)
Ewh <- Etot / 3600 # Ewh 322 Wh

