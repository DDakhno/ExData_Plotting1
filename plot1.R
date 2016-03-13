##Generic part

Sys.setlocale(category = "LC_ALL", locale = "us")

##Cleaning up the field
pngname = "plot1.png"
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

##Generating the PNG
##...opening the device - in the script You probably don't have a screen device
png(filename = pngname,width = 480, height = 480)
##In a script we may produce the histogramm at once
hist(hhdata$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
##Closing the device, writing the file out
dev.off()
##Controlling if file exists
if (file.exists(pngname)) paste("Success creating file ",pngname,"!", sep ="")
