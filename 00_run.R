# Before ------------

# Answers
quarto::quarto_render("slides.qmd", output_file = "slides_answers.html",
                      cache_refresh = TRUE,
                      execute_params = list(answers = "visible"))

# No answers
quarto::quarto_render("slides.qmd", output_file = "index.html",  # So is main page
                      cache_refresh = TRUE,
                      execute_params = list(answers = "hidden"))



# PDF
pagedown::chrome_print("slides_answers.html",
                       output = "figures_in_r_slides_answers.pdf",
                       extra_args = "--font-render-hinting=none")

pagedown::chrome_print("index.html",
                       output = "figures_in_r_slides.pdf",
                       extra_args = "--font-render-hinting=none")

system(glue::glue("gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 ",
                  "-dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH ",
                  "-sOutputFile='figures_in_r_slides_answers_sm.pdf' ",
                  "'figures_in_r_slides_answers.pdf'"))

system(glue::glue("gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 ",
                  "-dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH ",
                  "-sOutputFile='figures_in_r_slides_sm.pdf' ",
                  "'figures_in_r_slides.pdf'"))

# After --------------

# Post answers

usethis::use_github_release()