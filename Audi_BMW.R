library(keras)

######## Introduction #########################################################

## train an AUDI BMW classifier based on images that were downloaded using the 
## python package google-images-download. Note some images where not usable by keras

## Do the fast and easy way, create features from a pretrained network
## and use thos features in a dense network

######## conv base to create feutures ###############################

conv_base <- application_vgg16(
  weights = "imagenet",
  include_top = FALSE,
  input_shape = c(150, 150, 3)
)


######## extract freatures ######################################

train_dir <- file.path("downloads")
#validation_dir <- file.path(base_dir, "validation")
#test_dir <- file.path(base_dir, "test")

datagen <- image_data_generator(rescale = 1/255)
batch_size <- 20

extract_features <- function(directory, sample_count) {
  
  features <- array(0, dim = c(sample_count, 4, 4, 512))  
  labels <- array(0, dim = c(sample_count))
  
  generator <- flow_images_from_directory(
    directory = directory,
    generator = datagen,
    target_size = c(150, 150),
    batch_size = batch_size,
    class_mode = "binary"
  )
  
  i <- 0
  while(TRUE) {
    batch <- generator_next(generator)
    inputs_batch <- batch[[1]]
    labels_batch <- batch[[2]]
    features_batch <- conv_base %>% predict(inputs_batch)
    
    index_range <- ((i * batch_size)+1):((i + 1) * batch_size)
    features[index_range,,,] <- features_batch
    labels[index_range] <- labels_batch
    
    i <- i + 1
    if (i * batch_size >= sample_count)
      # Note that because generators yield data indefinitely in a loop, 
      # you must break after every image has been seen once.
      break
  }
  
  list(
    features = features, 
    labels = labels
  )
}

train <- extract_features(
  directory = train_dir, 
  sample_count = 120
)

table(train$labels)

############ reshape feautures ######################################

reshape_features <- function(features) {
  array_reshape(features, dim = c(nrow(features), 4 * 4 * 512))
}

train$features <- reshape_features(train$features)


########## train the model #############################################

model <- keras_model_sequential() %>% 
  layer_dense(
    units = 256, 
    activation = "relu", 
    input_shape = 4 * 4 * 512
  ) %>% 
  layer_dropout(
    rate = 0.5
  ) %>% 
  layer_dense(
    units = 1, activation = "sigmoid"
  )

model %>% compile(
  optimizer = optimizer_rmsprop(lr = 2e-5),
  loss = "binary_crossentropy",
  metrics = c("accuracy")
)

history <- model %>% 
  fit(
    train$features,
    train$labels,
    epochs = 30,
    batch_size = 20
    #,    validation_data = list(validation$features, validation$labels)
)

plot(history)







validation <- extract_features(validation_dir, 1000)
test <- extract_features(test_dir, 1000)