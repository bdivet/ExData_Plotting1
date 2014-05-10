# download data from a file named household_power_consumption.txt located in a folder /coursera/ below the working directory
# only keep the fist 100000 rows to speed up the process 
exdata<-read.csv2("./coursera/household_power_consumption.txt",header=TRUE,nrows=100000,as.is=TRUE)
# convert columns classes from character to numeric 
exdata[,-c(1,2)]<-apply(exdata[,-c(1,2)],2, as.numeric)
# create proper R Date and time: RDate and RPOSIT
exdata<-transform(exdata,RDate=as.Date(Date,"%d/%m/%Y"));exdata<-transform(exdata,RPOSIT=strptime(paste(RDate,Time),"%Y-%m-%d %H:%M:%S"))
# only keep the 2 dates mentioned: 1st and 2nd of February 2007
exdata<-subset(exdata,RDate=="2007-02-01" | RDate=="2007-02-02")

# open the graphics device: plot4.png
png("plot4.png")
#plot with the required display. start by spliting the screen into 4 sub sections: 2x2
par(mfrow = c(2, 2))
#top left graph:  plot histogram with the required display Date:Time in x-axis, Global_active_power in y-axis
with(exdata,plot(RPOSIT,Global_active_power,ylab="Global Active Power (kilowatts)",xlab='',type='l'))
#top right graph:  plot histogram with the required display Date:Time in x-axis, Voltage in y-axis
with(exdata,plot(RPOSIT,Voltage,ylab="Voltage",xlab='datetime',type='l'))
#bottom left graph:  plot 3 sub_metering with different colors and add a legend
with(exdata,plot(RPOSIT,Sub_metering_1,ylab="Energy sub metering",xlab='',type='l',ylim=c(0,max(sapply(c(7:9),function(.x) max(exdata[,.x]))))))
with(exdata,lines(RPOSIT,Sub_metering_2,col='red'))
with(exdata,lines(RPOSIT,Sub_metering_3,col='blue'))
# add a legend
legend("topright",lty=1,legend =colnames(exdata)[c(7:9)],col=c('black','blue','red'),bty='n')
#bottom right graph:  plot histogram with the required display Date:Time in x-axis, Global_active_power in y-axis
with(exdata,plot(RPOSIT,Global_reactive_power,ylab="Global_active_power",xlab='datetime',type='l'))
# close the graphics device
dev.off()