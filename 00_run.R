# Before ------------

# Answers
quarto::quarto_render("intro_to_r.qmd", output_file = "intro_to_r_answers.html",
                      cache_refresh = TRUE,
                      execute_params = list(answers = "visible"))

# No answers
quarto::quarto_render("intro_to_r.qmd", output_file = "index.html",
                      cache_refresh = TRUE,
                      execute_params = list(answers = "hidden"))



# PDF
pagedown::chrome_print("intro_to_r_answers.html",
                       output = "intro_to_r_answers.pdf",
                       extra_args = "--font-render-hinting=none")

pagedown::chrome_print("index.html",
                       output = "intro_to_r.pdf",
                       extra_args = "--font-render-hinting=none")

system(glue::glue("gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 ",
                  "-dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH ",
                  "-sOutputFile='intro_to_r_answers_sm.pdf' ",
                  "'intro_to_r_answers.pdf'"))

system(glue::glue("gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 ",
                  "-dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH ",
                  "-sOutputFile='intro_to_r_sm.pdf' ",
                  "'intro_to_r.pdf'"))


# After --------------

# Post answers

usethis::use_github_release()