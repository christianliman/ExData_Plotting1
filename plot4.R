# Loading and filtering the relevant data

household <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
household$Date <- as.Date(household$Date, "%d/%m/%Y")

household1 <- household[household$Date == as.Date("1/2/2007", "%d/%m/%Y"),]
household2 <- household[household$Date == as.Date("2/2/2007", "%d/%m/%Y"),]
household <- rbind(household1, household2)
remove(household1, household2)

household$Global_active_power_kw <- as.numeric(household$Global_active_power)/500
household$DateTime <- paste(household$Date, household$Time)
household$DateTime <- strptime(household$DateTime, "%Y-%m-%d %H:%M:%S")
household$Global_reactive_power_kw <- as.numeric(household$Global_reactive_power)/500

# Creating the plot

par(mfrow = c(2, 2))
with(household, {
  plot(DateTime, Global_active_power_kw, type = "l", xlab = "", ylab = "Global Active Power")
  plot(DateTime, Voltage, type = "l", xlab = "datetime")
  with(household, {
    plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(DateTime, Sub_metering_2, col = "red")
    lines(DateTime, Sub_metering_3, col = "blue")
    legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex = 0.75)
  })
  plot(DateTime, Global_reactive_power_kw, type = "l", xlab = "datetime")
})

# Saving to a png file

dev.copy(png, "plot4.png")
dev.off()