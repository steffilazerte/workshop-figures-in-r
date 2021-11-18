library(tidyverse)
library(glue)

#remotes::update_packages(c("pagedown", "xaringan"))
#remotes::update_packages()

files <- tribble(~f,                                   ~nice,
                 "intro_to_r.Rmd",                   "Intro to R through Figures") %>%
  mutate(answers = 1:n() %in% 1:4)

files <- files %>%
  filter(answers == TRUE) %>%
  mutate(nice_file = glue("{nice} - answers")) %>%
  bind_rows(mutate(files, nice_file = nice)) %>%
  mutate(answers = str_detect(nice_file, "answers")) %>%
  arrange(nice)

if(!dir.exists("slides")) dir.create("slides")
file.copy(c("_rmd/global_styles.css", 
            "_rmd/pres_styles.css",
            "_rmd/macros.js",
            "_rmd/figures"),
          "slides/", recursive = TRUE)

# Check spelling
for(i in seq_len(nrow(files))) {
  
  # Clean Cache before each run
  unlink(list.files(pattern = "_cache", full.names = TRUE), recursive = TRUE)
  
  # Render HTML
  glue("Rscript -e ",
       "\"rmarkdown::render('_rmd/{files$f[i]}', ",
       "output_file = '{files$nice_file[i]}.html', ",
       "params = list(hide_answers = {!files$answers[i]}))\"") %>%
    system()
  
  file.copy(glue("_rmd/{files$nice_file[i]}.html"), "slides/", recursive = TRUE)
  file.copy(glue("_rmd/{files$nice_file[i]}_files"), "slides/", recursive = TRUE)
  
  # Create PDFS
  message("Save as PDF")
  pagedown::chrome_print(glue("slides/{files$nice_file[i]}.html"),
                         glue("slides/{files$nice_file[i]}.pdf"),
                         extra_args = "--font-render-hinting=none")
  
  # Reduce size (prepress = 300 dpi, printer = 300 dpi, ebook = 150 dpi, screen = 72dpi)
  message("Make Small")
  system(glue("gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 ",
              "-dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH ",
              "-sOutputFile='slides/{files$nice_file[i]}_sm.pdf' ",
              "'slides/{files$nice_file[i]}.pdf'"))
  
  file.remove(glue("slides/{files$nice_file[i]}.pdf"))
  file.rename(glue("slides/{files$nice_file[i]}_sm.pdf"),
              glue("slides/{files$nice_file[i]}.pdf"))
  
  unlink(list.files(pattern = "_cache", full.names = TRUE), recursive = TRUE)
}
