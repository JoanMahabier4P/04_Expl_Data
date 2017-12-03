# Exploratory Data Analysis
# plot4.R

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

#****************************** Plot 4 *************************************************************

library(datasets)

# create 4 plots (columnwise):
par(mfcol = c(2, 2), mar = c(5, 4, 2, 1)) 

# The first one is actually plot2 from this assignment:
with(twoDays, plot(DateTime, Global_active_power,  type = "n", xlab = "", ylab="Global Active Power (kilowatts)")) 
with(twoDays, lines(DateTime, Global_active_power))

# The second one (lower left) is actually plot3 from this assignment:
with(twoDays, plot(DateTime, Sub_metering_1,  type = "n", xlab = "", ylab="Energy sub metering")) 
with(twoDays, lines(DateTime, Sub_metering_1, col = "black"))
with(twoDays, lines(DateTime, Sub_metering_2, col = "red"))
with(twoDays, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.5)

# The third one (upper right) is similar to the first one, but is about Voltage:
with(twoDays, plot(DateTime, Voltage,  type = "n")) 
with(twoDays, lines(DateTime, Voltage))

# The last one (lower right) is similar to the first one, but is about Global_reactive_power:
with(twoDays, plot(DateTime, Global_reactive_power,  type = "n")) 
with(twoDays, lines(DateTime, Global_reactive_power))

# save plot to png:
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

