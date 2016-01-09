#
# pub-fs-fp.R,  5 Jan 16
#
# Data from:
#
# Mark Staples and Rafal Kolanski and Gerwin Klein and Corey Lewis and June Andronick and Toby Murray and Ross Jeffery and Len Bass
# Formal Specifications Better Than Function Points for Code Sizing
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


bench=read.csv(paste0(ESEUR_dir, "communicating/pub-fs-fp.csv.xz"), as.is=TRUE)

pairs(bench[, -1], col="blue", cex.labels=1.4)
