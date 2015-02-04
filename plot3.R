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

## Create a DateTime variable for the X axis of the plot
febPower$DateTime <- strptime(paste(format(febPower$Date, "%m/%d/%Y"),format(febPower$Time,"%H:%M:%S")), "%m/%d/%Y %H:%M:%S")

## Open the png device with a size of 480px by 480px
png(file = "plot3.png",height = 480, width = 480)

## Create the plot of Sub metering for meters 1,2,3 as line graphs with differnt colors
with(febPower, plot(x = febPower$DateTime, y = febPower$Sub_metering_1, type = "n",xlab="", ylab = "Energy sub metering"))
points(x = febPower$DateTime, y = febPower$Sub_metering_1, type = "l", col="black")
points(x = febPower$DateTime, y = febPower$Sub_metering_2, type = "l", col="red")
points(x = febPower$DateTime, y = febPower$Sub_metering_3, type = "l", col="blue")

## Create the legend of Sub metering for meters 1,2,3 as line graphs with differnt colors
legend("topright",lwd=1,col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3") )

## Close the png device to write the file.
dev.off()