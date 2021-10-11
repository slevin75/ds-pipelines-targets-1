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
    download_data(outdir="1_fetch/out",fname= "model_RMSEs.csv",sb_id='5d925066e4b0c4f70d0d0599',item_name='me_RMSE.csv'),
    format = "file"
  ), 
  # Prepare the data for plotting 
  tar_target(
    eval_data,
    process_data(data=model_RMSEs_csv, 
                 colors=c('#1b9e77','#d95f02','#7570b3'),shapes=c(21,22,23)),
  ),
  # Save the processed data
  tar_target(
    model_summary_results_csv,
    write_csv_return_path(eval_data, outdir='2_process/out',fname="model_summary_results.csv"),
    format = "file"
  ),
  
  # Create a plot
  tar_target(
    figure_1_png,
    plot_data(eval_data = eval_data, outdir = "3_visualize/out",fname="figure_1.png",width=8,height=10,res=200,units="in" ), 
    format = "file"
  ),

  # Save the model diagnostics
  tar_target(
    model_diagnostic_text_txt,
    make_diagnostics_file(eval_data = eval_data, outdir="3_visualize/out" ,fname= "model_diagnostic_text.txt" ), 
    format = "file"
  )
)
