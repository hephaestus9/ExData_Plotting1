#http://stackoverflow.com/questions/7597559/grep-in-r-with-a-list-of-patterns

#Set wd
setwd("C:\\Users\\jeramy\\Documents\\Coursera\\Exploratory Data Analysis")

#Get subset of data
text = grep(paste(c("^1/2/2007", "^2/2/2007"),collapse="|"), readLines("household_power_consumption.txt"), value=TRUE)
labels = readLines("household_power_consumption.txt", n=1)
text = paste(c(labels, text))
data = read.table(text=text, sep=";", header=TRUE)
remove(text)
remove(labels)

#Change Date column
data$Date = as.Date(data$Date, format=("%d/%m/%Y"))

#Space required for subset
subset_space_required = (nrow(data) * ncol(data) * 8) / (2^20)

#Create plot 4
png(file="plot4.png",width=480,height=480,res=90)
par(mfrow=c(2,2))
plot(as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"), as.double(data$Global_active_power), type="l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"), as.double(data$Voltage), type="l", xlab = "datetime", ylab = "Voltage")

plot(xrange, yrange, type="n", xlab = "", ylab = "Global Active Power (kilowatts)")

lines(as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"), as.double(data$Sub_metering_1), type="l", col="black")
lines(as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"), as.double(data$Sub_metering_2), type="l", col="red")
lines(as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"), as.double(data$Sub_metering_3), type="l", col="blue")
legend(x="topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, cex=0.75)

plot(as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"), as.double(data$Global_reactive_power), type="l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()