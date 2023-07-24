library(tseries)

stereo <- read_excel("D:/datasets/Data Analysis and Decision Making Files/ExampleFiles/Chpt13/DataOnly/Stereo.xls", skip = 2)

# calculate mean of sales
stereo$SalesMean <- mean(stereo$Sales)

# subtract mean from original data points
stereo$Residuals <- stereo$Sales - stereo$SalesMean
#stereo$Sales <- as.factor(stereo$Sales)

# reassign binary 1 or 0 if residuals is above or below 0
stereo$Binary <- ifelse(stereo$Residuals >=0 ,1,0)

# create factor variable
stereo$Binary <- as.factor(stereo$Binary)

str(stereo)

# run runs test
# H0 is that time series is NOT random
# if p value is large, then we accept that series is NOT random
# if p value is small we reject H0 and conclude that the series is random

runs.test(stereo$Binary)
