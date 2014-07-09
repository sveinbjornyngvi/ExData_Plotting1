#Activate library to format time.
library(chron)

#Read in data, convert date and time, subset the two dates, merge time and date and then remove the big dataset.
hpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings ="?")
hpc$Date <- as.Date(hpc$Date, format='%d/%m/%Y')
hpc$Time <- chron(times=hpc$Time)
hpc.df <- subset(hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02",])
hpc.df$datetime <- as.POSIXct(paste(hpc.df$Date, hpc.df$Time), format="%Y-%m-%d %H:%M:%S")
rm(hpc)

#Open png graphics device, plot Global Active Power against date and time and then close device.
png("plot2.png", width = 480, height = 480)
plot(hpc.df$datetime, hpc.df$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type = "n")
lines(hpc.df$datetime, hpc.df$Global_active_power)
dev.off()


