
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

    

# Tell system to make four plots (2 by 2)
    par(mfrow = c(2,2))
    par(cex=.75)  # Change the font size
    
# Make plot - Row 1, Column 1: Global Active Power by Dat
    
    # convert variable to numeric
    power$globalActivePower <- as.numeric(power$globalActivePower)
    
    # create the plot structure, but put no points in
    plot(power$dateAndTime, power$globalActivePower, type="n", 
         ylab = "Global Active Power (kilowatts)", xlab ="")
    
    # draw lines for date and time and global active power
    lines(power$dateAndTime, power$globalActivePower) 


# Make plot - Row 1, Column 2 : Voltage by Day
    
    # convert variable to numeric
    power$voltage <- as.numeric(power$voltage)
    
    # create the plot structure, but put no points in
    plot(power$dateAndTime, power$voltage, type="n", 
          xlab ="datetime", ylab = "Voltage")
    
    # draw lines for date and time and global active power
    lines(power$dateAndTime, power$voltage) 
    

# Make plot - Row 2, Column 1  - SubMetering
    
    names(power)
    # convert variables to numeric
    power$subMeter1 <- as.numeric(power$subMeter1)
    power$subMeter2 <- as.numeric(power$subMeter2)
    power$subMeter3 <- as.numeric(power$subMeter3)

    # create the plot structure, but put no points in it
    plot(power$dateAndTime, power$subMeter1, type="n", 
         ylab = "Energy sub metering", xlab ="")
    legend("topright", pch="_", col = c("black", "red", "blue"), 
                    legend = c("Sub_metering 1", "Sub_metering 2", "Sub_metering 3"), bty = "n",
           cex=.5, pt.cex = 1.5)

    # draw lines for each submeter
        lines(power$dateAndTime, power$subMeter1) 
        lines(power$dateAndTime, power$subMeter2, col = "red") 
        lines(power$dateAndTime, power$subMeter3, col = "blue") 
    
    ?text
    ?legend
    
# Make plot - Row 2, Column 2 - Global Reactive Power
    
    # convert variable to numeric
    power$globalReactivePower <- as.numeric(power$globalReactivePower)
    
    # create the plot structure, but put no points in
    plot(power$dateAndTime, power$globalReactivePower, type="n", 
         xlab ="datetime", ylab = "Global_reactive_power")
    
    # draw lines for date and time and global active power
    lines(power$dateAndTime, power$globalReactivePower) 

# Save to png
dev.copy(png, width = 480, height = 480, file = "./Assignment 1/plot4.png")
dev.off()
