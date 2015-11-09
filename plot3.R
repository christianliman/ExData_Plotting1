# Loading and filtering the relevant data

household <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
household$Date <- as.Date(household$Date, "%d/%m/%Y")

household1 <- household[household$Date == as.Date("1/2/2007", "%d/%m/%Y"),]
household2 <- household[household$Date == as.Date("2/2/2007", "%d/%m/%Y"),]
household <- rbind(household1, household2)
remove(household1, household2)

household$Global_active_power <- as.numeric(household$Global_active_power)
household$Global_active_power_kw <- household$Global_active_power/500
household$DateTime <- paste(household$Date, household$Time)
household$DateTime <- strptime(household$DateTime, "%Y-%m-%d %H:%M:%S")


# Creating the plot and saving to a png file

png(file = "plot3.png", width = 480, height = 480)

with(household, {
  plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
  lines(DateTime, Sub_metering_2, col = "red")
  lines(DateTime, Sub_metering_3, col = "blue")
  })
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")


dev.off()