from google_images_download import google_images_download 
response = google_images_download.googleimagesdownload()  

# download images into tmp folder, we need to sort out
# right car pictures later and split into training and validation

# 100 png, jpg and bmp files

arguments = {
  "keywords": "BMW,AUDI",
  "limit": 100,
  "print_urls": False,
  "suffix_keywords": "car",
  "output_directory": "TMP",
   "format": "png"
}

response.download(arguments)   

arguments = {
  "keywords": "BMW,AUDI",
  "limit": 100,
  "print_urls": False,
  "suffix_keywords": "car",
  "output_directory": "TMP",
  "format": "jpg"
}

response.download(arguments)   

arguments = {
  "keywords": "BMW,AUDI",
  "limit": 100,
  "print_urls": False,
  "suffix_keywords": "car",
  "output_directory": "TMP",
  "format": "bmp"
}


response.download(arguments)  
