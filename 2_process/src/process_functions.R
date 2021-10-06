
#function to process data for plotting and save formatted data


# Prepare the data for plotting
process_data<-function(data){
 eval_data <- data %>%
  filter(str_detect(exper_id, 'similar_[0-9]+')) %>%
  mutate(col = case_when(
    model_type == 'pb' ~ '#1b9e77',
    model_type == 'dl' ~'#d95f02',
    model_type == 'pgdl' ~ '#7570b3'
  ), pch = case_when(
    model_type == 'pb' ~ 21,
    model_type == 'dl' ~ 22,
    model_type == 'pgdl' ~ 23
  ), n_prof = as.numeric(str_extract(exper_id, '[0-9]+')))

 write_csv(eval_data, file = file.path('./2_process/out/model_summary_results.csv'))


}  #end function

# Save the processed data
readr::write_csv(eval_data, file = file.path(project_output_dir, 'model_summary_results.csv'))

