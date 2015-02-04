
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

## Open the png device with a size of 480px by 480px
png(file = "plot1.png",height = 480, width = 480)

## Create the histogram of Global Active Power
with(febPower, hist(febPower$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))

## Close the png device to write the file.
dev.off()