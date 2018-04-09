from google_images_download import google_images_download 

response = google_images_download.googleimagesdownload()  

arguments = {
  "keywords":"BMW,AUDI",
  "limit":100,
  "print_urls":True,
  "size":"medium"
}

response.download(arguments)   #passing the arguments to the function
