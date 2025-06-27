install.packages("ggplot2")
library(ggplot2)
install.packages("ggpubr")
library(ggpubr)
library(readxl)
install.packages("data.table")
library(data.table)

# use the data
mydata <- data.frame(
  Years = c(2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024),
  Publications = c(3, 4, 9, 6, 6, 9, 12, 6, 12, 13, 15, 23, 39, 32, 47, 43, 47, 54, 61, 85, 149, 170, 151, 172, 188),
  Citations = c(0, 1, 2, 13, 24, 58, 65, 92, 112, 155, 190, 223, 288, 358, 538, 761, 825, 1142, 1211, 1651, 2301, 3013, 3490, 3851, 4679)
)

# seed settings
set.seed(123)
p <- ggplot() + 
  geom_point(data = mydata, aes(Years, Publications), fill="red", colour="red", size=1, shape=21) + 
  geom_smooth(data = mydata, aes(x=Years, y=Publications), method = "loess", se=T, size=2) + 
  ggtitle('A') + 
  scale_x_continuous(breaks=seq(8, 16, by=4), "Years") + 
  coord_cartesian(ylim = c(0, 200)) + 
  labs(y="Publications") + 
  theme(plot.background = element_rect(color = "black", size = 1)) +  
  theme_bw() + 
  theme(panel.grid = element_blank(), legend.title = element_blank())

# extract data from ggplot object
plot_data <- ggplot_build(p)$data[[2]]

# create data frame
df <- data.frame(
  x = plot_data$x,
  y = plot_data$y,
  ymin = plot_data$ymin,
  ymax = plot_data$ymax
)

# save data
write.csv(df, "D:/document/loess_curve.csv", row.names = FALSE)
