# Exploratory Data Analysis
# plot2.R

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

# Make another DateTime column by pasting the Date and Time columns.
# Convert this new DateTime column to POSIXct and put in desired format:
twoDays$DateTime <- as.POSIXct(paste(twoDays$Date, twoDays$Time), format="%d/%m/%Y %H:%M:%S")       

# Convert the rest of the columns to numeric
for (i in 3:9) {
    twoDays[, i] <- as.numeric(twoDays[, i])
}

#****************************** Plot 2 *************************************************************

library(datasets)
with(twoDays, plot(DateTime, Global_active_power,  type = "n", xlab = "", ylab="Global Active Power (kilowatts)")) 
with(twoDays, lines(DateTime, Global_active_power))

# save plot to png:
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()

