library(targets)
library(dplyr)
library(readr)
library(stringr)

source("./1_fetch/src/fetch_functions.R")
source("./2_process/src/process_functions.R")
source("./3_visualize/src/plot_functions.R")
tar_option_set(packages = c("tidyverse", "sbtools", "whisker"))

list(
  # Get the data from ScienceBase
  tar_target(
    model_RMSEs_csv,
    download_data(outdir="1_fetch/out",fname= "model_RMSE.csv",sb_id='5d925066e4b0c4f70d0d0599',item_name='me_RMSE.csv'),
    format = "file"
  ), 
  # Prepare the data for plotting
  tar_target(
    eval_data,
    process_data(data=eval_data,outdir='2_process/out', fname='model_summary_results.csv', 
                 colors=c('#1b9e77','#d95f02','#7570b3'),shapes=c(21,22,23)),
  ),
  # Create a plot
  tar_target(
    figure_1_png,
    make_plot(out_filepath = "3_visualize/out/figure_1.png", data = eval_data), 
    format = "file"
  ),
  # Save the processed data
  tar_target(
    model_summary_results_csv,
    write_csv(eval_data, file = "model_summary_results.csv"), 
    format = "file"
  ),
  # Save the model diagnostics
  tar_target(
    model_diagnostic_text_txt,
    generate_model_diagnostics(out_filepath = "model_diagnostic_text.txt", data = eval_data), 
    format = "file"
  )
)
