

#function to download raw data from Science Base

download_data<-function(outdir,fname,sb_id,item_name){
  data_file <- file.path( outdir, 'model_RMSEs.csv')
  item_file_download(sb_id, names = item_name, destinations = data_file, overwrite_file = TRUE)
  data<-read.csv(data_file)

}


