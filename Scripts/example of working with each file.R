
# sample run script

files <- list.files("examples") %>%
  set_names(str_replace(., ".xls", ""))


ls <- files %>%
  map( ~ glue("examples/{.x}")) %>%
  map( ~ list(
    meta = process_meta(.x),
    data = process_data(.x)
  ))




process_meta <- function(file_path) {
  df <- file_path %>%
    read_excel(sheet = 1) %>%
    meta_clean()
}


process_data <- function(file_path) {
  df <- file_path %>%
    read_excel(sheet = 2) %>%
    remove_meta()

  original_nms <- colnames(df)
  new_nms <- clean_names_full(original_nms)

  list(data = df, original_nms = original_nms, new_nms = new_nms)
}


