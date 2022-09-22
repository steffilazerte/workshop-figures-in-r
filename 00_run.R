# Answers
quarto::quarto_render("intro_to_r.qmd", 
                      execute_params = list(answers = "visible"))
file.rename("intro_to_r.html", "intro_to_r_answers.html")

# No answers
quarto::quarto_render("intro_to_r.qmd", 
                      execute_params = list(answers = "hidden"))



# PDF
pagedown::chrome_print("intro_to_r_answers.html",
                       output = "intro_to_r_answers.pdf",
                       extra_args = "--font-render-hinting=none")

pagedown::chrome_print("intro_to_r.html",
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
