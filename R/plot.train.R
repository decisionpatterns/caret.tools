

# See ?plot.train

# tuning <- function(model) { 
# 
# dat <- model$results[ fit.rpart$results$Kappa > 0, ]
# 
# ggplot( data=dat
#   , aes_string( x=names(dat)[[1]], y='Kappa')) + 
#   geom_line() + geom_point() +
#   geom_line( aes(y=Kappa+KappaSD), color="grey") +
#   geom_line( aes(y=Kappa-KappaSD), color="grey") +
#   # geom_line( aes(y=Accuracy+AccuracySD), color="grey") +
#   scale_x_reverse() + scale_y_reverse() + 
#   geom_smooth(form=y~I(x^2)+x, method="glm", color="red", se=FALSE, linetype=2)
# 
# }