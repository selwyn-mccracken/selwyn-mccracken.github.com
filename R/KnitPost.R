
KnitPost <- function(input, base.url="/") {
  opts_knit$set(base.url=base.url)
  
  fig.path <- paste0("figs/", sub(".Rmd$", "", basename(input)), "/")
  opts_chunk$set(fig.path=fig.path)
  opts_chunk$set(fig.cap="center")

  render_jekyll()
  knit(input, envir=parent.frame())
}

###

library(knitr)

setwd("../Rmd")

###

path <- "../../selwyn-mccracken.github.com"
input <- file.path(path, "Rmd", "2012-09-01-first-crack.Rmd")

KnitPost(input)
