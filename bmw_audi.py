from google_images_download import google_images_download 

response = google_images_download.googleimagesdownload()  

arguments = {
  "keywords": "BMW,AUDI",
  "limit": 100,
  "print_urls": True,
  "size": "medium",
  "output_directory": "training",
   "format": "gif"
}

response.download(arguments)   #passing the arguments to the function

arguments = {
  "keywords": "BMW,AUDI",
  "limit": 50,
  "print_urls": True,
  "size": "medium",
  "output_directory": "validation",
  "format": "jpg"
  
}

response.download(arguments)   #passing the arguments to the function
