#Script to plot the depth of the files

library(ggplot2)

#data <- read.csv ("hightemp_02.txt", header = F, sep = " ")
#data <- read.csv ("hightemp_02.txt", header = F, sep = " ")
#data <- read.csv ("normal_01.txt", header = F, sep = " ")
data <- read.csv ("normal_02.txt", header = F, sep = " ")
data <- as.data.frame(data) #We make sure the data are a data frame
data$V1 <- NULL #We eliminate the first column, which contains nothing

#We create a data frame with two columns, one for the base and one for the plot
results <- data.frame(matrix(ncol=2, nrow=0))
colnames(results) <- c("base", "depth")

#Plotting every base would not make sanse; therefore, we will get one value per 1000 bases
chunk <- seq(1, nrow(data), 1000)
chunk <- c(chunk, nrow(data))

#With every group of 1000 bases, we assign to the middle base the mean of the depth of all the bases
#This is not 100% accurate, but for the plor it will serve the purpose
for (i in 2:length(chunk)) {
  mean <- mean(data[chunk[i-1]:(chunk[i]-1),]$V3)
  base <- (data[chunk[i-1],1]+data[chunk[i],1])/2
  results[nrow(results)+1,] <- c(base, mean)
}
#We keep the last position
last <- data[nrow(data), 1]

#We create the plot
depth_plot <- ggplot(results, aes(x=results$base, y=results$depth)) +
  geom_line() +
  theme_minimal() +
  labs(x="Position",
       y="Depth") +
  theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        axis.title.x = element_text (size = 10, face = "bold", vjust = 0),
        axis.title.y = element_text (size = 10, face = "bold", vjust = 1.5),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.ticks = element_line(colour = "black", size=1),
        panel.border = element_rect(colour = "black", fill=NA, size=1)) +
  scale_y_continuous(breaks = seq(0, 240, by = 10)) + #210 instead of 240 for hightemp
  scale_x_continuous(breaks = seq(1, last, by = 150000)) +
  coord_cartesian(ylim = c(0,240), xlim = c(1,last)) #210 instead of 240 for hightemp
  
depth_plot
