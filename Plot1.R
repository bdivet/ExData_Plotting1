# download data from a file named household_power_consumption.txt located in a folder /coursera/ below the working directory
# only keep the fist 100000 rows to speed up the process 
exdata<-read.csv2("./coursera/household_power_consumption.txt",header=TRUE,nrows=100000,as.is=TRUE)
# convert columns classes from character to numeric 
exdata[,-c(1,2)]<-apply(exdata[,-c(1,2)],2, as.numeric)
# create proper R Date and time: RDate and RPOSIT
exdata<-transform(exdata,RDate=as.Date(Date,"%d/%m/%Y"));exdata<-transform(exdata,RPOSIT=strptime(paste(RDate,Time),"%Y-%m-%d %H:%M:%S"))
# only keep the 2 dates mentioned: 1st and 2nd of February 2007
exdata<-subset(exdata,RDate=="2007-02-01" | RDate=="2007-02-02")

# open the graphics device: plot1.png
png("plot1.png")
#plot histogram with the required display
with(exdata,hist(Global_active_power,col='red',xlab="Global Active Power (kilowatts)",main="Global Active Power"))
# close the graphics device
dev.off()