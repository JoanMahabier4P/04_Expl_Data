# Exploratory Data Analysis
# plot1.R

#****************************** Preparations *************************************************************

# Clean up workspace
rm(list=ls())

# Set path
path <- getwd()
path

# Set file
file <- "/household_power_consumption.txt"
# Note the extra / at the beginning of the file. Without it the working directory and file will stick together like glue and you'll get: "cannot open file ....No such file or directory

columnTypes <- "character"
missingTypes <- c("NA","", "?") 

#****************************** Read data *************************************************************

readTable <- function(path.name, file.name, columnTypes, missingTypes) {
  read.table( paste(path.name, file.name, sep=""), 
              colClasses=columnTypes,
              header=TRUE,
              sep=";",
              na.strings=missingTypes)
}

completeData <- readTable(path, file, columnTypes, missingTypes) # 2075259 observations and 9 variables, that's a lot to read.

# Subset only the data from just the two dates in february rather than reading in the entire dataset. 
twoDays <- completeData[completeData$Date %in% c("1/2/2007", "2/2/2007"),]

#****************************** Conversion of columntypes ******************************************************

# For now all columntypes are "character".

# The Date and Time columms can remain "character" since they are not needed for the plot.

# The rest of the columns need a conversion to numeric:
for (i in 3:9) {
    twoDays[, i] <- as.numeric(twoDays[, i])
}


#****************************** Plot 1*************************************************************

library(datasets)
hist(twoDays$Global_active_power, main = "Global Active Power", xlab="Global Active Power (kilowatts)",col = "red")

# save plot to png:
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
