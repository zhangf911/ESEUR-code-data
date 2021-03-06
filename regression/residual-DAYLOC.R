#
# residual-DAYLOC.R, 18 Aug 16
# Data from:
# The {Linux} Kernel as a Case Study in Software Evolution
# Ayelet Israeli and Dror G. Feitelson
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 1)
pal_col=rainbow(2)

# Lines of code in each release
ll=read.csv(paste0(ESEUR_dir, "regression/Linux-LOC.csv.xz"), as.is=TRUE)
# Data of each release
ld=read.csv(paste0(ESEUR_dir, "regression/Linux-days.csv.xz"), as.is=TRUE)

loc_date=merge(ll, ld)

# Add column giving number of days since first release
loc_date$Release_date=as.Date(loc_date$Release_date, format="%d-%b-%Y")
start.date=loc_date$Release_date[1]
loc_date$Number_days=as.integer(difftime(loc_date$Release_date,
                                         start.date,
                                         units="days"))
# Order by days since first release
ld_ordered=loc_date[order(loc_date$Number_days), ]

# What is the latest version
n_Version=numeric_version(ld_ordered$Version)

# cummax does not work for numeric_version, so we
# have to track the latest version
greatest_version <<- n_Version[1]

keep_version=sapply(2:nrow(ld_ordered),
		function(X)
		{
		if (n_Version[X] > greatest_version)
		   {	
		   greatest_version <<- n_Version[X]
		   return(TRUE)
		   }
		return(FALSE)
		})

latest_version=ld_ordered[c(TRUE, keep_version), ]


m1=glm(LOC ~ Number_days, data=latest_version)

# m2=glm(LOC ~ Number_days+I(Number_days^2), data=latest_version)

plot(m1, which=1, caption="", sub.caption="", col=point_col)


plot(latest_version$Number_days, latest_version$LOC, col=point_col,
	xlab="Days", ylab="Total lines of code\n")

pred=predict(m1, type="response", se.fit=TRUE)
lines(latest_version$Number_days, pred$fit, col=pal_col[1])
lines(loess.smooth(latest_version$Number_days, latest_version$LOC, span=0.3),
		col=pal_col[2])

