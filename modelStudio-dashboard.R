# load the explainer from the pickle file
library(reticulate)
explainer <- py_load_object("xgboost-explainer.pkl", pickle = "pickle")

# pick observations and adjust their labels
set.seed(0)
local_obs <- explainer$data[sample(1:nrow(explainer$data), 5), ]
rownames(local_obs) <- paste("id:", rownames(local_obs),
                             "| pred:", 
                             round(explainer$predict(local_obs), 4))

# make a studio for the model
library(modelStudio)
ms <- modelStudio(explainer, local_obs, B = 15)
ms
