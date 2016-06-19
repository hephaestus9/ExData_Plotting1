#Set wd
setwd("C:\\Users\\jeramy\\Documents\\Coursera\\Exploratory Data Analysis")

#Calculate an estimate for the size of the full data set in MB
full_dataset_space_required = (2075259 * 9 * 8) / (2^20)

#Read in data
data = read.table("household_power_consumption.txt", header=TRUE, sep=";")

#Change Date column
data$Date = as.Date(data$Date, format=("%d/%m/%Y"))

#Get subset of data
data_sub = subset(data, Date==as.Date("2007-02-01") | Date==as.Date("2007-02-02"))

#Space required for subset
subset_space_required = (nrow(data_sub) * ncol(data_sub) * 8) / (2^20)

#Free up memory
remove(data)
data = data_sub
remove(data_sub)

#Generate and Save Plots
png(file="plot1_.png",width=480,height=480,res=90)
hist(as.double(data$Global_active_power), xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
dev.off()

png(file="plot2_.png",width=480,height=480,res=90)
plot(as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"), as.double(data$Global_active_power), type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

png(file="plot3_.png",width=480,height=480,res=90)
xrange = range(as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"))
yrange = range(0,as.double(data$Sub_metering_1))

plot(xrange, yrange, type="n", xlab = "", ylab = "Global Active Power (kilowatts)")

lines(as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"), as.double(data$Sub_metering_1), type="l", col="black")
lines(as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"), as.double(data$Sub_metering_2), type="l", col="red")
lines(as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"), as.double(data$Sub_metering_3), type="l", col="blue")
legend(x="topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)
dev.off()

png(file="plot4_.png",width=480,height=480,res=90)
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
