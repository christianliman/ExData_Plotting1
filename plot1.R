# Loading and filtering the relevant data

household <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
household$Date <- as.Date(household$Date, "%d/%m/%Y")

household1 <- household[household$Date == as.Date("1/2/2007", "%d/%m/%Y"),]
household2 <- household[household$Date == as.Date("2/2/2007", "%d/%m/%Y"),]
household <- rbind(household1, household2)
remove(household1, household2)

household$Global_active_power <- as.numeric(household$Global_active_power)
household$Global_active_power_kw <- household$Global_active_power/500

# Creating the plot

hist(household$Global_active_power_kw, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

# Saving to a png file

dev.copy(png, "plot1.png")
dev.off()