---
layout: post
title: "First crack..."
description: ""
category: r
tags: [knitr, jekyll, tutorial]
---
{% include JB/setup %}

Here's a couple of simple maps of New Zealand and the UK created with R's ggplot2 library, to test that I have everything set up correctly when producing blog content using [knitr](http://yihui.name/knitr/) and [RStudio](http://rstudio.org).   
This example has been adopted from the [ggplot 0.9.0 docs](
http://had.co.nz/ggplot2/docs/coord_map.html). 

RStudio has some nicely integrated [R markdown abilities](http://rstudio.org/docs/authoring/using_markdown), such as embedding R code and images, previewing html content and publishing content on [RPubs](http://rpubs.com/) if so desired.

However, I want to publish content on github which means working with Jekyll, so I followed Jason Fisher's excellent introduction to using R markdown + Knitr + Jekyll + Jekyllbootstrap [here](http://jfisher-usgs.github.com/r/2012/07/03/knitr-jekyll/) and getting Jekyll running on windows [here](http://jfisher-usgs.github.com/lessons/2012/05/30/jekyll-build-on-windows/). 



{% highlight r %}
library(ggplot2)
library(maps)
library(mapdata)
library(grid)
library(gridExtra)

# extract map data for New Zealand
nz <- data.frame(map("nz", plot = FALSE)[c("x", "y")])

# longitude and latitude coordinates for my home town.
hastings <- data.frame(x = 176.8333, y = -39.65)

# long + lat for Dunedin
dunedin = data.frame(x = 170.5, y = -45.89)

# set up NZ map and annotate with point and text
nzmap <- ggplot(nz, aes(x, y)) + geom_polygon(colour = "grey", fill = "white") + 
    # pinpoint Hastings
geom_point(data = hastings, aes(x, y, size = 3, colour = "red"), show_guide = FALSE) + 
    geom_text(data = hastings, aes(x, y), label = "Home ", size = 4, hjust = 1, 
        fontface = "bold") + # pinpoint Dunedin
geom_point(data = dunedin, aes(x, y, size = 3, colour = "red"), show_guide = FALSE) + 
    geom_text(data = dunedin, aes(x, y), label = "Went to     \nUniversity  &  \nmet my lovely\n wife here    ", 
        size = 4, fontface = "bold", hjust = 1) + # relabel the x and y axes
scale_y_continuous(name = "Latitude") + scale_x_continuous(name = "Longitude") + 
    coord_map(project = "azequalarea", orientation = c(-36.92, 174.6, 0))

# extract uk map data
uk <- data.frame(map("worldHires", "UK:Great Britain", plot = FALSE, xlim = c(-11, 
    3), ylim = c(49, 60.9))[c("x", "y")])
uk = uk[complete.cases(uk), ]  #drop blank rows to prevent the plot going nutty

# the position of London
london <- data.frame(x = 0.1062, y = 51.5171)

# set up uk map and annotate with point and text
ukmap <- ggplot(uk, aes(x, y), geom = "path") + geom_polygon(colour = "grey", 
    fill = "white") + # pinpoint London town
geom_point(data = london, aes(x, y, size = 3, colour = "red"), show_guide = FALSE) + 
    geom_text(data = london, aes(x, y), label = "Where I \ncurrently\nlive      ", 
        size = 4, fontface = "bold", hjust = 1.2) + scale_y_continuous(name = "Latitude") + 
    scale_x_continuous(name = "Longitude") + coord_map(project = "azequalarea", 
    orientation = c(51.5171, 0.1062, 0))

# use gridExtra's grid.arrange function to mimic base R's
# par(mfrow=c(1,2)) i.e. put plots side by side
sidebysideplot <- grid.arrange(nzmap, ukmap, ncol = 2)
{% endhighlight %}

![center](/figs/2012-09-01-first-crack/main.png) 

{% highlight r %}

{% endhighlight %}



{% highlight r %}
print(sidebysideplot)
{% endhighlight %}



{% highlight text %}
## NULL
{% endhighlight %}

