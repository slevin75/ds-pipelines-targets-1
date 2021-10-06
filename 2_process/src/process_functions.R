
#function to process data for plotting and save formatted data


# Prepare the data for plotting
##shapes and colors are assumed to be the same length as the different model types here.  


process_data<-function(data,outdir, fname, colors,shapes){
 eval_data <- data %>%
  filter(str_detect(exper_id, 'similar_[0-9]+')) %>%
  mutate(col = case_when(
    model_type == 'pb' ~ colors[1],
    model_type == 'dl' ~colors[2],
    model_type == 'pgdl' ~ colors[3]
  ), pch = case_when(
    model_type == 'pb' ~ shapes[1],
    model_type == 'dl' ~ shapes[2],
    model_type == 'pgdl' ~ shapes[3]
  ), n_prof = as.numeric(str_extract(exper_id, '[0-9]+')))

 write_csv(eval_data, file = file.path(outdir, fname))

}  #end function

