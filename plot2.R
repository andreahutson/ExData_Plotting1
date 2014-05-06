
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
    
# Paste date and time together
    power$DateTime <- paste(power$Date, power$Time)
    power$dateAndTime <- as.POSIXlt(power$DateTime, format="%d/%m/%Y %H:%M")

# Make plot
    par(mfrow = c(1,1))
    par(cex=1)  # Change the font size
    # convert variable to numeric
    power$globalActivePower <- as.numeric(power$globalActivePower)
    
    # create the plot structure, but put no points in
    plot(power$dateAndTime, power$globalActivePower, type="n", 
         ylab = "Global Active Power (kilowatts)", xlab ="")

    # draw lines for date and time and global active power
    lines(power$dateAndTime, power$globalActivePower) 
    

# Save to png
dev.copy(png, width = 480, height = 480, file = "./Assignment 1/plot2.png")
dev.off()
