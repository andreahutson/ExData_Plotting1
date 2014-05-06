# Get data
    powerall <- read.csv2("./Data/household_power_consumption.txt", sep = ";", skip = 66000, nrow = 3600,header=FALSE,
                          stringsAsFactors = FALSE)
    # Set column names
    colnames(powerall) <- c("Date", "Time", "globalActivePower", "globalReactivePower", "voltage", "globalIntensity", "subMeter1",
               "subMeter2", "subMeter3")
    # Make final data set
        power1 <- subset(powerall, powerall$Date ==  "1/2/2007")
        power2 <- subset(powerall, powerall$Date ==  "2/2/2007")
        power <- rbind (power1, power2)
    
    # Remove all other data
        rm (power1)
        rm (power2)
        rm (powerall)
    
# Ensure data is numeric
    power$globalActivePower <- as.numeric(power$globalActivePower)

# Make plot
    par(mfrow = c(1,1))
    par(cex=1)  # Change the font size
    hist(power$globalActivePower, col = "red", xlab = "Global Active Power (kilowatts)", 
         main = "Global Active Power")

# Make png file
    dev.copy(png, width = 480, height = 480, file = "./Assignment 1/plot1.png")
    dev.off()
