#
# data_all_Blob_merge.R, 13 Jul 16
#
# Data from:
#
# Impacts and detection of design smells
# Abdou Maiga
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library(lme4)
library(car)


# No information on the order in which questions were answered.
# Is the large difference seen a result of ordering or anti-patterns???
# Author did not respond to any of the emails asking about the
# order in which subjects solved problems.
# Subject,AP,System,QTYPE,Time,Answer,Effort,SE,Java,Eclipse
blob=read.csv(paste0(ESEUR_dir, "experiment/data_all_Blob_merge.csv.xz"), as.is=TRUE)


# blob_mod=glm(Time ~ ., data=blob)
# t=stepAIC(blob_mod)

# blob_mod=lmer(Time ~ (AP+System+QTYPE+Answer+Effort+SE+Java+Eclipse+Subject)^2, data=blob)

#library("lmerTest")
# t=step(blob_mod)

# Cannot use Subject as the random effect because all the explanatory
# variables are categorical and multiply up the number of random effects
# table(blob$Subject, blob$QTYPE)
# table(blob$Subject, blob$AP)
blob_mod=lmer(Time ~ AP+ QTYPE+Java+ (AP | Subject), data=blob)

# blob_gmod=glm(Time ~ AP+ Java, data=blob)
blob_mod=lmer(Time ~ AP+ Java+(1 | Subject), data=blob)

summary(blob_mod)

Anova(blob_mod)

# Only AP is significant TODO probit because answer is ordinal???
# blob_mod=lmer(Answer ~ AP+ (AP | Subject), data=blob)


SC=read.csv(paste0(ESEUR_dir, "experiment/data_all_SC_merge.csv.xz"), as.is=TRUE)


SC_mod=lmer(Time ~ AP+ (1 | Subject), data=SC)
summary(SC_mod)

Anova(blob_mod)

