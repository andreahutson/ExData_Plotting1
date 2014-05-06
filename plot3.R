
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
    # convert variables to numeric
    power$subMeter1 <- as.numeric(power$subMeter1)
    power$subMeter2 <- as.numeric(power$subMeter2)
    power$subMeter3 <- as.numeric(power$subMeter3)

    ?pch
    # create the plot structure, but put no points in it
    plot(power$dateAndTime, power$subMeter1, type="n", 
         ylab = "Energy sub metering", xlab ="")
    legend("topright", pch="_", col = c("black", "red", "blue"), 
                    legend = c("Sub_metering 1", "Sub_metering 2", "Sub_metering 3"))

    # draw lines for each submeter
        lines(power$dateAndTime, power$subMeter1) 
        lines(power$dateAndTime, power$subMeter2, col = "red") 
        lines(power$dateAndTime, power$subMeter3, col = "blue") 
    

# Save to png
dev.copy(png, width = 480, height = 480, file = "./Assignment 1/plot3.png")
dev.off()
