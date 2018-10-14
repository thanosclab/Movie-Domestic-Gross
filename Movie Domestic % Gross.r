#Import the Data
mov <- read.csv(file.choose())

#Data Exploration
head(mov) #top rows
summary(mov) #column summaries
str(mov) #structure of the dataset

#Activate GGPlot2
#install.packages("ggplot2")
library(ggplot2)


ggplot(data=mov, aes(x=Day.of.Week)) + geom_bar()


#Now we need to filter our dataset to leave only the 
#Genres and Studios that we are interested in
#We will start with the Genre filter and use the Logical 'OR'
#operator to select multiple Genres:
filt <- (mov$Genre == "action") | (mov$Genre == "adventure") | (mov$Genre == "animation") | (mov$Genre == "comedy") | (mov$Genre == "drama")

#Now let's do the same for the Studio filter:
filt2 <- (mov$Studio == "Buena Vista Studios") | (mov$Studio == "WB") | (mov$Studio == "Fox") | (mov$Studio == "Universal") | (mov$Studio == "Sony") | (mov$Studio == "Paramount Pictures")
#or   filt2 <- mov$Studio %in% c("Buena Vista Studios", "WB", "Fox", "Universal", "Sony", "Paramount Pictures")

filt
filt2 

#Apply the row filters to the dataframe
mov2 <- mov[filt & filt2,]
mov2

#Prepare the plot's data and aes layers
#Note we did not rename the columns. 
#Use str() or summary() to fin out the correct column names
p <- ggplot(data=mov2, aes(x=Genre, y=Gross...US))
p #Nothing happens. We need a geom.

#Add a Point Geom Layer
p +  
  geom_point()

#Add a boxplot instead of the points
p + 
  geom_boxplot()

#Notice that outliers are part of the boxplot layer

#Add points
q <- p + 
  geom_jitter(aes(size=Budget...mill., colour=Studio)) +
  geom_boxplot(alpha=0.7, outlier.color = NA)
q


#Non-data ink
q <- q +
  xlab("Genre") + #x axis title
  ylab("Gross % US") + #y axis title
  ggtitle("Domestic Gross % by Genre") #plot title
q


#Theme
q <- q + 
  theme(
    #this is a shortcut to alter ALL text elements at once:
    text = element_text(family="Comic Sans MS"),
    
    #Axes titles:
    axis.title.x = element_text(colour="Blue", size=30),
    axis.title.y = element_text(colour="Blue", size=30),
    
    #Axes texts:
    axis.text.x = element_text(size=20),
    axis.text.y = element_text(size=20),  
    
    #Plot title:
    plot.title = element_text(colour="Black",
                              size=40),
    
    #Legend title:
    legend.title = element_text(size=20),
    
    #Legend text
    legend.text = element_text(size=12),
    
    text = element_text(family="Comic Sans MS")
  )
q

#this is how you can change individual legend titles:
q$labels$size = "Budget $M"
q

