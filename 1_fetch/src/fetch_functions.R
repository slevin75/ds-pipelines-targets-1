

#function to download raw data from Science Base

download_data<-function(){
  mendota_file <- file.path( '1_fetch/out/model_RMSEs.csv')
  item_file_download('5d925066e4b0c4f70d0d0599', names = 'me_RMSE.csv', destinations = mendota_file, overwrite_file = TRUE)
  data<-read.csv(mendota_file)

}


