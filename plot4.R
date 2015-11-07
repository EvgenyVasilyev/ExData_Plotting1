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

#plot4
png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2),mar=c(4,4,3,1), ps = 10, cex.lab=1, cex.axis=1, cex.main=1, cex.sub=1)
with(datacut,plot(datentime,Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)",xlab = "", col = "black"))
with(datacut,plot(datentime,Voltage, type = "l", ylab = "Voltage",xlab = " datetime", col = "black"))
with(datacut,{
    plot(datentime,Sub_metering_1, type = "l", ylab = "Energy sub metering",xlab = "", col = "black")    
    lines(datentime,Sub_metering_2, col = "red")
    lines(datentime,Sub_metering_3, col = "blue")
    legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n", col=c("black","red","blue"), lty= "solid")
})
with(datacut,plot(datentime,Global_reactive_power, type = "l", ylab = "Global_reactive_power",xlab = " datetime", col = "black"))
dev.off()