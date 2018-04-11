library(keras)
library(dplyr)
library(stringr)

## not all downloaded images from google-images-download are actualy 
## cars use a ## pretrained image classifier to filter on car images only

model_resnet = application_resnet50(weights = 'imagenet')

## loop through images and see if they keras can open them
## and get their top 3 class by using resnet50

#### AUDI ####
images = dir("TMP/AUDI car/")
img_path = file.path("TMP/AUDI car",images)

images_audi = tibble::tibble(
  images = img_path,
  openerror = TRUE,
  class = ""
)

for(i in 1:length(img_path))
{
  tryCatch({
    x = image_load(
      images_audi$images[i], 
      target_size = c(224,224)
    ) %>% 
    image_to_array()

    dim(x) = c(1, dim(x))
    x = imagenet_preprocess_input(x)
    preds = model_resnet %>% predict(x)
    images_audi$class[i] = paste(
      imagenet_decode_predictions(
        preds, top = 3
      )[[1]][,2],
      collapse = " "
    )
    images_audi$openerror[i] = FALSE
    },
    error=function(e) NA
  )
}


#### BMW #### 
images = dir("TMP/BMW car/")
img_path = file.path("TMP/BMW car",images)

images_BMW = tibble::tibble(
  images = img_path,
  openerror = TRUE,
  class = ""
)

for(i in 1:length(img_path))
{
  tryCatch({
    x = image_load(
      images_BMW$images[i], 
      target_size = c(224,224)
    ) %>% 
      image_to_array()
    
    dim(x) = c(1, dim(x))
    x = imagenet_preprocess_input(x)
    preds = model_resnet %>% predict(x)
    images_BMW$class[i] = paste(
      imagenet_decode_predictions(
        preds, top = 3
      )[[1]][,2],
      collapse = " "
    )
    images_BMW$openerror[i] = FALSE
  },
  error=function(e) NA
  )
}


#### peugeot #####
images = dir("TMP/peugeot car/")
img_path = file.path("TMP/peugeot car/",images)

images_peugeot = tibble::tibble(
  images = img_path,
  openerror = TRUE,
  class = ""
)

for(i in 1:length(img_path))
{
  tryCatch({
    x = image_load(
      images_peugeot$images[i], 
      target_size = c(224,224)
    ) %>% 
      image_to_array()
    
    dim(x) = c(1, dim(x))
    x = imagenet_preprocess_input(x)
    preds = model_resnet %>% predict(x)
    images_peugeot$class[i] = paste(
      imagenet_decode_predictions(
        preds, top = 3
      )[[1]][,2],
      collapse = " "
    )
    images_peugeot$openerror[i] = FALSE
  },
  error=function(e) NA
  )
}



######### put images in train and validation folders #########

## by putting images in train -> audi and train --> bmw
## we can use keras to create proper training and labels

images_audi_usefull = images_audi %>% 
  filter(!openerror) %>% 
  mutate(
    car = str_detect(class, "car") | str_detect(class, "wagon")
  ) %>% 
  filter(car)

for(i in 1:dim(images_audi_usefull)[1])
{
  if(runif(1) < 0.75)
  {
    file.copy(
      images_audi_usefull$images[i], 
      "training/audi"
    )
  }
  else{
    file.copy(
      images_audi_usefull$images[i], 
      "validation/audi"
    )
  }
}



images_BMW_usefull = images_BMW %>% 
  filter(!openerror) %>% 
  mutate(
    car = str_detect(class, "car") | str_detect(class, "wagon")
  ) %>% 
  filter(car)

for(i in 1:dim(images_BMW_usefull)[1])
{
  if(runif(1) < 0.75)
  {
    file.copy(
      images_BMW_usefull$images[i], 
      "training/bmw"
    )
  }
  else{
    file.copy(
      images_BMW_usefull$images[i], 
      "validation/bmw"
    )
  }
}



images_peugeot_usefull = images_peugeot %>% 
  filter(!openerror) %>% 
  mutate(
    car = str_detect(class, "car") | str_detect(class, "wagon")
  ) %>% 
  filter(car)

for(i in 1:dim(images_peugeot_usefull)[1])
{
  if(runif(1) < 0.75)
  {
    file.copy(
      images_peugeot_usefull$images[i], 
      "training/peugeot"
    )
  }
  else{
    file.copy(
      images_peugeot_usefull$images[i], 
      "validation/peugeot"
    )
  }
}






