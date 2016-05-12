#' Caret ROC  
#' 
#' Create ROC object directly from a caret model
#' 
#' @param fit caret model fit
#' @param outcome string; outcome label
#' @param ... additional arguments passed to \code{\link[pROC]{roc}}
#' 
#' @details 
#' 
#' This returns an 'roc' object. Which you probably want to then pass to 
#' \code{\link[pROC]{plot}}.  
#' 
#' @return 
#' An object of class 'roc'
#' 
#' @seealso 
#'   \code{\link[pROC]{roc}} \cr
#'   \code{\link[pROC]{plot}} \cr
#'   
#' @examples  
#'   
#'   data(aSAH)
#'   ctrl <- trainControl( classProb=TRUE, savePrediction=TRUE )
#'   fit <- train( 
#'                outcome ~ gender + age + s100b + ndka, data=aSAH, method="rf"
#'                , trControl = ctrl 
#'               )
#'   
#'   roc.train(fit) %>% plot( print.auc=TRUE, grid=TRUE)
#'   
#' @import caret pROC

roc.train <- function( fit, outcome, ...  ) { 

  # IF OUTCOME IS NOT SPECIFIED USE THE MINORITY RESULT
  if( missing(outcome) ) { 
    outcome = 
      fit$trainingData$.outcome %>% table %>% sort %>% names %>% extract2(1)
      if( getOption('verbose') ) 
        warning( "Outcome was not specified, using:", outcome )
  }
  
  if( is.null(fit$pred) ) {
    warning(
      "There are no resampled predictions saved. You need to train your model ",
      "with a trainControl specifying 'classProb=TRUE' and 'savePredictions=TRUE'" 
    )
    return()
  
  }
    
  # TESTS
  if( fit$modelType != "Classification" ) 
    stop("ROC curves only apply to classification models")
  
  
  roc( fit$pred$obs, fit$pred[[outcome]], ... )
  
}
