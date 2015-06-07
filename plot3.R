library(dplyr)

#Reading data

setwd("C:/Users/Maciek/Desktop/Coursera/Exploratory data analysis")
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")

#Converting and removing NAs

converted<-mutate(data,Date=as.character(Date),Time=as.character(Time))
shortened<-converted[complete.cases(converted),]

#Subsetting for selected dates

selected<-filter(shortened,Date=="1/2/2007"|Date=="2/2/2007")

#Adding additional day time column

selected<-mutate(selected, Datetime=paste(selected$Date, selected$Time))

#Converting Date, Time, DateTime to Posixlt

selected$Date=strptime(selected$Date,"%e/%m/%Y")
selected$Time=strptime(selected$Time,"%H:%M:%S")                      
selected$Datetime=strptime(selected$Datetime,"%e/%m/%Y %H:%M:%S")
data.final<-selected

#Creating plot

png(filename="plot3.png",)

with(data.final,{
     plot(Datetime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=" ")
     lines(Datetime,Sub_metering_2,type="l",col="red")
     lines(Datetime,Sub_metering_3,type="l",col="blue")
     legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1",
      "Sub_metering_2","Sub_metering_3"))
})
          
dev.off()

