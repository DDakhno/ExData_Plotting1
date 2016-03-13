##Generic part
Sys.setlocale(category = "LC_ALL", locale = "us")
setwd("H:\\Coursera\\John Hopkins University\\Data Science Specialization\\Exploratory Data Analysis\\SourceCode\\ExData_Plotting1")

##Cleaning up the field
pngname = "plot3.png"
unlink(pngname)

rawdatafile <- "rawdata.zip"

##Time saving checks
if(!file.exists(rawdatafile)) {
    ##Download  and unzip raw data
    rawdataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    rawdata <- download.file(rawdataurl, destfile = rawdatafile, mode = "wb")
    unzip(rawdatafile)
} else { 
    paste("File",rawdatafile,"already exists!")
}

if(!file.exists("household_power_consumption.txt")) {
    unzip(rawdatafile)
} else {
    print("File household_power_consumption.txt already exists!")
}


##Reading the data
hhdata <- read.table("household_power_consumption.txt", na.strings = c("?"), header=TRUE, sep=";",colClasses=c("character", "character", "numeric", "numeric","numeric", "numeric", "numeric", "numeric", "numeric" ))                                                                                                 

##Subsetting the data to the relevant values
hhdata <- subset(hhdata, Date == "1/2/2007" | Date == "2/2/2007")


##Converting the Date and Time to POSIXlt
hhdata$DT <- strptime(paste(hhdata$Date,hhdata$Time), format = "%d/%m/%Y %H:%M:%S")


##Generating the PNG
par(mar = c(4, 5, 2, 1))
##...opening the device - in the script You probably don't have a screen device
png(filename = pngname,width = 480, height = 480)
##In a script we may produce the histogramm at once
with(hhdata, { plot(x = DT, y = Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
                lines(x = DT, y = Sub_metering_2, col = "red")
                lines(x = DT, y = Sub_metering_3, col = "blue")
})
legend("topright",  col = c("black","red", "blue"), lwd = 1, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##Closing the device, writing the file out
dev.off()
##Controlling if file exists
if (file.exists(pngname)) cat("Success creating file ",pngname,"!", sep ="")