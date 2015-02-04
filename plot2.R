## Load the required packages
library(graphics)
library(grDevices)

## Read in household power consumption data
powerConsumption <- read.table("../Assignment1Data/household_power_consumption.txt",sep = ";", stringsAsFactors = FALSE, header=TRUE)

## Convert the string date into a Date class
powerConsumption$Date <- as.Date(powerConsumption$Date, format = "%d/%m/%Y")

## Get the subset of only Feb 1st and 2nd of 2007 to analyze
febPower <- powerConsumption[format(powerConsumption$Date,"%m/%d/%Y") %in% c("02/01/2007","02/02/2007"),]

## Convert the string time to POSIXct
febPower$Time <- strptime(febPower$Time, "%H:%M:%S")

## Ensure Global_active_power is a numeric class
febPower$Global_active_power <- as.numeric(febPower$Global_active_power)

## Create a DateTime variable for the X axis of the plot
febPower$DateTime <- strptime(paste(format(febPower$Date, "%m/%d/%Y"),format(febPower$Time,"%H:%M:%S")), "%m/%d/%Y %H:%M:%S")

## Open the png device with a size of 480px by 480px
png(file = "plot2.png",height = 480, width = 480)

## Create the plot of Global Active Power over time as a line graph
with(febPower, plot(x = febPower$DateTime, y = febPower$Global_active_power, type = "l",xlab="", ylab = "Global Active Power (kilowatts)"))


## Close the png device to write the file.
dev.off()