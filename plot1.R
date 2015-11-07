##downloading date
linktofile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filenm <- "household_power_consumption.txt"
download.file(linktofile,"data.zip")
unzip("data.zip")
##reading and preparing data
data <- read.table(filenm, sep = ";",header = TRUE, na.strings="?")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
datacut <- data[(data$Date >= as.Date("2007-02-01", format = "%Y-%m-%d") & (data$Date <= as.Date("2007-02-02", format = "%Y-%m-%d"))),]
datentime <- paste(datacut$Date, datacut$Time, sep = " ")
datentime <- strptime(datentime,"%Y-%m-%d %H:%M:%S")
datacut <- cbind(datacut,datentime)

#plot1
png("plot1.png", width = 480, height = 480, units = "px")
with(datacut, hist(Global_active_power, col = "red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()