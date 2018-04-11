from google_images_download import google_images_download 
response = google_images_download.googleimagesdownload()  


arguments = {
  "keywords": "peugeot",
  "limit": 100,
  "print_urls": False,
  "suffix_keywords": "car",
  "output_directory": "TMP",
   "format": "png"
}

response.download(arguments)   

arguments = {
  "keywords": "peugeot",
  "limit": 100,
  "print_urls": False,
  "suffix_keywords": "car",
  "output_directory": "TMP",
  "format": "jpg"
}

response.download(arguments)   

arguments = {
  "keywords": "peugeot",
  "limit": 100,
  "print_urls": False,
  "suffix_keywords": "car",
  "output_directory": "TMP",
  "format": "bmp"
}


response.download(arguments)  
