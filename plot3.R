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

#plot3
png("plot3.png", width = 480, height = 480, units = "px")
with(datacut,{
    plot(datentime,Sub_metering_1, type = "l", ylab = "Energy sub metering",xlab = "", col = "black")    
    lines(datentime,Sub_metering_2, col = "red")
    lines(datentime,Sub_metering_3, col = "blue")
    legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty="solid")
})
dev.off()