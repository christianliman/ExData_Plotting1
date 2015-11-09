# Loading and filtering the relevant data

household <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
household$Date <- as.Date(household$Date, "%d/%m/%Y")

household1 <- household[household$Date == as.Date("1/2/2007", "%d/%m/%Y"),]
household2 <- household[household$Date == as.Date("2/2/2007", "%d/%m/%Y"),]
household <- rbind(household1, household2)
remove(household1, household2)

household$Global_active_power <- as.numeric(as.character(household$Global_active_power))
household$Global_active_power_kw <- household$Global_active_power/500
household$DateTime <- paste(household$Date, household$Time)
household$DateTime <- strptime(household$DateTime, "%Y-%m-%d %H:%M:%S")

# Creating the plot

with(household, plot(DateTime, Global_active_power_kw, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

# Saving to a png file

dev.copy(png, "plot2.png")
dev.off()