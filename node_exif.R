latlon_exif <- read.csv("latlon_exif.csv")
date_exif <- read.csv("date_exif.csv")

# date_exif[date_exif[,4]==latlon_exif[2,4],4]

for (i in 1:nrow(latlon_exif)){

   jpeg(file = paste("./nodejpg/", as.character(latlon_exif[i,4]),".jpg", sep = ""),
         units = "px", quality = 75)
    
    plot(0, 0, xaxt='n', yaxt='n', ann=FALSE, type = "n")
    title(latlon_exif[i,4], line = -13, cex.main = 13)
  
   dev.off()

   exiftool_cmd <- paste("exiftool -GPSLongitudeRef=E -GPSLongitude=",latlon_exif[i,11],
                         " -GPSLatitudeRef=N -GPSLatitude=",latlon_exif[i,10]," ",
                         "./nodejpg/",latlon_exif[i,4],".jpg",sep='')
   system(exiftool_cmd)

   if(any(date_exif[,4]%in%latlon_exif[i,4])){
      exiftool_cmd <- paste("exiftool -alldates=",shQuote(
                      date_exif[which(date_exif[,4]%in%latlon_exif[i,4]),8])," ",
                            "./nodejpg/",latlon_exif[i,4],".jpg",sep='')

   } else {
     exiftool_cmd <- paste("exiftool -alldates=now"," ",
                           "./nodejpg/",latlon_exif[i,4],".jpg",sep='')
   }
   
   system(exiftool_cmd)
   
print(latlon_exif[i,4])   
}

system("./nodejpg/find . -name '*_original' -delete")
