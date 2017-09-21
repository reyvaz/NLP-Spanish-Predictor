# Contains the shinyUI (interface) portion of the shiny App for the Spanish 
# word predictor
# 
# Created on 2017 by Reynaldo Vazquez for the purpose of developing a Spanish 
# language word predictor.
# 
# Permission is granted to copy, use, or modify all or parts of this program and  
# accompanying documents for purposes of research or education, provided this 
# notice and attribution are retained, and changes made are noted.
# 
# This program and accompanying documents are distributed without any warranty,
# expressed or implied. They have not been tested to the degree that would be 
# advisable in important tasks. Any use of this program is entirely at the 
# user's own risk.
# 
library(shiny)
library(shinythemes)
library(shinyjs)
# The js code below is to detect user's keyboard presses to use as an input in 
# the server functions. Specifically, when a user presses ctr+[1-5] or 
# ctrl+shift+[1-5] it accepts it as a command to select an option
jscode <- "$(function(){ 
  var down = {};
  $(document).keydown(function(e) {
    down[e.which] = true;
      if (down[17] && down[16] && e.which == 49) {$('#button6').click()
        down = {}; return false;}
      else if (down[17] && e.which == 49) {$('#button3').click()
        down = {}; return false;}
      if (down[17] && down[16] && e.which == 50) {$('#button7').click()
        down = {}; return false;}
      else if (down[17] && e.which == 50) {$('#button2').click()
        down = {}; return false;}
      if (down[17] && down[16] && e.which == 51) {$('#button8').click()
        down = {}; return false;}
      else if (down[17] && e.which == 51) {$('#button1').click()
        down = {}; return false;}
      if (down[17] && down[16] && e.which == 52) {$('#button9').click()
        down = {}; return false;}
      else if (down[17] && e.which == 52) {$('#button4').click()
        down = {}; return false;}
      if (down[17] && e.which == 53) {$('#button5').click()
        down = {}; return false;}
    })
  })"

shinyUI(
  navbarPage(
      theme = shinytheme("cosmo"), inverse =FALSE, "predictor de palabras", 
      tabPanel("predictor", 
        tags$script(HTML("$(document).ready(function() {$('.btn').on('click', 
                         function(){$(this).blur()});})")),
        fluidPage(
          tags$style("body {background-color: #1c1b1a;}", 
                     type = "text/css", ".navbar{background-color:#1c1b1a; 
                     border-color:#1c1b1a;}"),
          tags$head(tags$style(HTML('.shiny-server-account {display: none;}
                                    .navbar-brand {display: none;}
                                    .navbar-header {display: none;}'))),
          tags$script(HTML(jscode)),
                      tags$head(tags$script(
                        'Shiny.addCustomMessageHandler("refocus",function(NULL) 
                        {document.getElementById("usertext").focus();});')),
          column(8, align="left", offset = 2, style = "padding:1.5em;",
                 useShinyjs(),
                 actionButton("optionMenu", "mostrar opciones", width = "24.7%",
                              style='padding:0px;min-width: 10em; 
                              color:white;height:27px; 
                              border:1px solid #404040;'),
                 hidden(actionButton("topHelp", "ocultar ayuda", width ="24.7%",
                              style='padding:0px;min-width: 10em; 
                              color:white; height:27px; 
                              border:1px solid #404040;')),
                 hidden(actionButton("currents", "solo siguiente",width="24.6%",
                              style='padding:0px;min-width: 10em; 
                              color:white; height:27px;
                              border:1px solid #404040;')),
                 hidden(actionButton("preds","mostrar menos", width = "24.6%",
                              style='padding:0px;min-width: 10em; 
                              color:white; height:27px; 
                              border:1px solid #404040;'))
                ),
          column(8, align="left", offset = 2, style = "padding:1.5em;",
                 h1("predictor de palabras", style='color: #e6e6e6'),
                 br(), br()),
          column(12, align="center", offset = 0,
                 textAreaInput("usertext", label = NULL, rows = "2",
                               resize = "vertical", 
                               placeholder = "escribe aquí")
                 ),
          column(8, align="center", offset = 2,
                 h6(htmlOutput("texthelp0"), 
                    style = 'font-size: 12px; font-family:Verdana'),
                 actionButton("button6", htmlOutput("text6"),
                              style='padding:2px;height:30px;
                              font-family:sans-serif;
                              border-color:#1c1b1a; color:#a6a6a6; 
                              font-size:14px;
                              background-color:#1c1b1a;
                              min-width: 0px'), 
                 hidden(div(id = "curr2", style = "display:inline", 
                            HTML("&nbsp;&nbsp;"),
                 actionButton("button7", htmlOutput("text7"), 
                              style='padding:2px;height:30px;
                              font-family:sans-serif;
                              border-color:#1c1b1a; 
                              color: #a6a6a6; font-size:14px;
                              background-color:#1c1b1a;
                              min-width: 0px'))), 
                 hidden(div(id = "curr3", style = "display:inline", 
                            HTML("&nbsp;&nbsp;"), 
                 actionButton("button8", htmlOutput("text8"), 
                              style='padding:2px;height:30px;
                              font-family:sans-serif;
                              border-color:#1c1b1a; color:#a6a6a6; 
                              font-size:14px;
                              background-color:#1c1b1a;
                              min-width:0px'))),
                hidden(div(id = "curr4", style = "display:inline", 
                           HTML("&nbsp;&nbsp;"), 
                actionButton("button9", htmlOutput("text9"), 
                              style='padding:2px;height:30px;
                              font-family:sans-serif;
                              border-color:#1c1b1a; color:#a6a6a6; 
                              font-size:14px;
                              background-color:#1c1b1a;
                              min-width:0px')))),
          column(8, align="center", offset = 2,
                 br(),
                 actionButton("reset", "borrar todo", width = "90",
                              style='padding:0px;min-width: 7em; 
                              color:#a6a6a6;
                              height:25px; border-color:#404040'),
                             useShinyjs(),
                 actionButton("centerHelp","ocultar ayuda",width="90",
                              style='padding:0px;min-width: 7em;
                              color:#a6a6a6;
                              height:25px; border-color:#404040'),
                 br(),br()), 
          column(8, align="center", offset = 2,
                 actionButton("button3", textOutput("text3"), width = "19.4%", 
                              style='padding:0px;height:30px;
                              font-family:sans-serif;
                              border-color:#004d00; min-width:115px'),
                 actionButton("button2", textOutput("text2"), width = "19.4%",
                              style='padding:0px;height:30px;
                              font-family:sans-serif;
                              border-color:#660033; min-width:115px'),
                 actionButton("button1", textOutput("text1"), width = "19.4%",
                              style='padding:0px;height:30px;
                              font-family:sans-serif;
                              border-color:#804000; min-width:115px'),
                 actionButton("button4", textOutput("text4"), width = "19.4%", 
                              style='padding:0px;height:30px;
                              font-family:sans-serif;
                              border-color:#193366; min-width:115px'),
                 actionButton("button5", textOutput("text5"), width = "19.4%",
                              style='padding:0px;height:30px;
                              font-family:sans-serif;
                              border-color:#4d0066; min-width: 115px'),
                 h6(htmlOutput("texthelp"), style = 'font-size: 12px; 
                    font-family:Verdana')),
          div(HTML("<html><head><style>
                   .dropbtn {
                   background-color: #4CAF50;
                   color: white;
                   padding: 5px 8px;
                   font-size: 14px;
                   border: none;
                   cursor: pointer;
                   }
                   
                   .dropdown {
                   position:fixed;
                   bottom:55px;
                   right:20px;
                   display: inline-block;
                   }
                   .dropdown-content {
                   display: none;
                   position: absolute;
                   background-color: #f9f9f9;
                   color: black;
                   min-width: 105px;
                   box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                   z-index: 1;
                   }
                   .dropdown-content a {
                   color: black;
                   padding: 3px 8px;
                   text-decoration: none;
                   display: block;
                   }
                   .dropdown-content a:hover {
                   background-color: #4CAF50;}
                   .dropdown:hover .dropdown-content {
                   display: block; 
                   }
                   .dropdown:hover .dropbtn {
                   background-color: #3e8e41;
                   }
                   </style>
                   </head>
                   <body contenteditable=\"false\">
                   <div class=\"dropdown\">
                   <button class=\"dropbtn\">other&nbsplanguage</button>
                   <div class=\"dropdown-content\">
                   <a href=\"https://rvaz.shinyapps.io/english_predictor\" 
                   style= \"color:black\">English&nbspapp</a>
                   <a href=\"https://rvaz.shinyapps.io/en_es_predictor/\" 
                   style= \"color:black\">Eng-Esp&nbspapp</a>
                   </div>
                   </div>
                   </body></html>")
          )
          )
        ),
      tabPanel("información", fluidPage(
        fluidPage(
          tags$style(HTML("A:link {COLOR: white; TEXT-DECORATION: none; 
                          font-weight: normal}A:visited {COLOR: white; 
                          TEXT-DECORATION: none; font-weight: normal}
                          A:hover {COLOR: gray; TEXT-DECORATION: none; 
                          font-weight: none}")),
          hidden(div(id = "english",
             HTML("<h1 id=\"CTop\" style=\"position: relative;
                  top:-2.4em\"></h1>"),
             HTML("<div style=\"position: fixed; z-index:5; margin-top: -0.5em; 
                  width: 70%; min-width: 180px;
                  background-color: rgba(219, 162, 5, 0.90);
                  color: white;
                  font-weight: bold;
                  font-size: large;
                  padding: 0.2em 0.7em;
                  border-radius: 0em 0.8em 0.8em 0em;\">
                  <a href=\"#Ins\">&nbsp;Using&nbsp;the&nbsp;App&nbsp;&nbsp;</a> 
                  <a href=\"#Alg\">&nbsp;Algorithms&nbsp;&nbsp;</a> 
                  <a href=\"#Corp\">&nbsp;Corpus&nbsp;&nbsp;</a> 
                  <a href=\"#Aut\">&nbsp;The&nbspAuthor&nbsp;&nbsp;</a> 
                  <a href=\"#CTop\">&nbsp;Top&nbsp;&nbsp;&nbsp;</a>
                  <a id=\"langEs\" href=\"#\" class=\"action-button shiny-bound-
                                                    input\">&nbsp;Español</a>
                  </div>"),
             HTML("<h1 id=\"Ins\"style=\"position:relative;top:-2.2em\"></h1>"),
             column(10, align="justify", offset = 1,
                    style = "background-color:#1c1b1a;
                    padding: 5em 1em 1em 1em;"
                    ),
             column(10, align="justify", offset = 1,
                    style = "background-color:#862d59;
                    padding: 2em 3% 2em 3%;",
                    h2("Using the App", style = 'color: white'),
                    p("The app takes Spanish text as input and automatically 
                      provides,", style="color: white"), 
                    tags$ol(
                        tags$li("Suggestions to complete the word being typed", 
                                style="color: white"), 
                        tags$li("Suggestions for the next word", 
                                style="color: white")
                        ),
                    p("To generate suggestions simply start typing in the text 
                      box", style="color: white"), 
                    tags$ol(
                        tags$li("Suggestions to complete the word being typed  
                                appear underlined beneath the single  
                                current-word prediction. Click on one 
                                to complete the word. Or simultaneously press 
                                ctrl+shift+[option order number],
                                i.e. ctrl+shift+1 for the first option from left 
                                to right", style="color: white"), 
                        tags$li("Suggestions for the next-word appear in 
                                highlighted buttons at the bottom of the app.
                                Click on one to paste at the end of the 
                                current text. Or simultaneously 
                                press ctrl+[option order number],
                                i.e. ctrl+1 for the option in the green 
                                button", style="color: white")
                        ),
                    p("Customizations", 
                      style="color: white"), 
                    tags$ol(
                        tags$li("Click on the \"mostrar opciones\" button to 
                                display options ", style="color: white"), 
                        tags$li("Click on the \"ocultar ayuda\" button to hide 
                                instructions, click again to undo", 
                                style="color: white"),
                        tags$li("Click on the \"solo siguientes\" 
                                button to remove current-word suggestions, 
                                click again to undo", style="color: white"),
                        tags$li("Click on the \"mostrar menos\" button  
                                to show only 3 next-word suggestions, 
                                click again to undo", style="color: white")
                        ),
                    HTML("<h1 id=\"Alg\" style=\"position: relative; 
                         top:-2em\"> </h1>")
                    ),
             column(10, align="justify", offset = 1,
                    style = "background-color:#1c1b1a;
                    padding: 5em 1em 1em 1em;"
                    ),
             column(10, align="justify", offset = 1,
                    style = "background-color:#4d3a7d;
                    padding: 2em 3% 2em 3%;",
                    h2("Algorithms", style = 'color: white'),
                    p("This app depends on two main algorithms, one for  
                      next-word suggestions, and one for current-word 
                      suggestions.",style="color: white"), 
                    p("The next-word predictor uses a Markov-chain ngram type 
                      algorithm. Monograms, bigrams, trigrams, and tetragrams  
                      are paired with a list of most likely to follow words  
                      according to the corpus.", style="color: white"), 
                    p("The algorithm starts by building the highest ngram  
                      possible from the last 4, 3, 2, or 1 input words in their  
                      input order.", style="color: white"), 
                    p("It then continues as follows, stopping anytime 5 unique 
                      suggestions have been found,", style="color: white"), 
                    tags$ol(
                        tags$li("Use the highest possible ngram as Markov  
                                state", style="color: white"), 
                        tags$li("Use the next highest, and so on, possible  
                                ngram as Markov state", style="color: white"), 
                        tags$li("Modify some spellings and repeat 1 and 2", 
                                style="color: white"), 
                        tags$li("Ignore last input word and repeat 1 and 2", 
                                style="color: white"), 
                        tags$li("Use a predefined set of generic suggested 
                                words", style="color: white") 
                        ),
                    p("The algorithm first preprocesses and translates the  
                      Markov state into a unique numeric code. Then, 
                      it matches the Markov state code with suggested-word 
                      codes. Finally, it converts those word codes into words
                      and provides them as suggestions.", style="color: white"), 
                    p("The current-word predictor uses the algorithm above,
                      ignoring the word being typed, to find the most likely 
                      words that follow the preceding words (if any). Once  
                      those words are found:", style="color: white"), 
                    tags$ol(
                      tags$li("The algorithm uses all characters of the word  
                              being typed as the current state", 
                              style="color: white"), 
                      tags$li("Transforms the current state in a way that 
                              would match diverse plausible spelling variants 
                              and correct some misspellings", 
                              style="color: white"), 
                      tags$li("Looks for matches in the most likely words to 
                              follow the preceding words", 
                              style="color: white"), 
                      tags$li("Looks for matches in a probability-ranked 
                              dictionary", style="color: white"), 
                      tags$li("Provides up to 4 completion and spelling  
                              suggestions for the word being typed", 
                              style="color: white")
                      ),
                    HTML("<h1 id=\"Corp\"style=\"position: relative; 
                         top:-2em\"></h1>")
                    ),
             column(10, align="justify", offset = 1,
                    style = "background-color:#1c1b1a;
                    padding: 5em 1em 1em 1em;"
                    ),
             column(10, align="justify", offset = 1,
                    style = "background-color:#1f3d7a;
                    padding: 2em 3% 2em 3%;",
                    h2("Corpus", style = 'color: white'),
                    p("To build the predictor the following corpora were used,", 
                      style="color: white"), 
                    tags$ol(
                        tags$li("About 10 percent of the Spanish Billion Words 
                                Corpus, compiled by Cristian Cardellino (March, 
                                2016) and downloaded on September 12, 2017. The 
                                compilation includes portions of the SenSem, 
                                Ancora Corpus, Tibidabo Treebank and IULA  
                                Spanish LSP Treebank, OPUS Project, Europarl,  
                                Wikipedia, Wikisource and Wikibooks", 
                                style="color: white"), 
                        tags$li("A partial Spanish Wikipedia dump containing  
                                updated articles. Downloaded on September
                                 12, 2017", style="color: white"), 
                        tags$li("A collection of recent and popular
                                Twitter posts in Spanish downloaded between 
                                September 12-14, 2017",
                                style="color: white")
                        ),
                    p("The raw corpora files were then preprocessed to remove 
                      elements not related to the corpus, 
                      separate hashtags, and few other transformations.", 
                      style="color: white"), 
                    p("A goal during preprocessing was to keep it minimal in  
                      order to maintain and capture as much information as 
                      possible about how Spanish is typed, including grammar,  
                      common misspellings, contractions, abbreviations, 
                      acronyms, and regional slang.", style="color: white"),
                    p("The final corpus used for the predictor contains ~200 
                      million words in a ~1.5 GiB file. It includes text from 
                      diverse Spanish speaking regions but mainly from Spain, 
                      Mexico, Argentina, and the United States",
                      style="color: white"),
                    HTML("<h1 id=\"Aut\" style=\"position: relative; 
                         top:-2em\"></h1>")
                    ),
             column(10, align="justify", offset = 1,
                    style = "background-color:#1c1b1a;
                    padding: 5em 1em 1em 1em;"
                    ),
             column(10, align="justify", offset = 1,
                    style = "background-color:#004d1a;
                    padding: 2em 3% 2em 3%;",
                    h2("About the Author", style = 'color: white'),
                    p("Reynaldo is a data scientist. He earned an M.A. in 
                      Economics from the University of California, Santa 
                      Barbara, where he also became a Ph.D. candidate. He 
                      graduated Suma Cum Laude with a B.A. in Applied Economics
                      from the CSU Los Angeles.", 
                      style="color: white"), 
                    p("Reynaldo has certifications on Data Science and 
                      Machine Learning from Johns Hopkins and Stanford, 
                      respectively. And long experience working with data and 
                      statistics, math, econometrics, and programming.",
                      style="color: white"), 
                    p("He has taught and done research at the University of 
                      California, with specialization in macroeconomics and 
                      public finance. He is fluent in English, Spanish, and 
                      Italian.", 
                      style="color: white"), 
                    h2("Contact:", style = 'color: white'),
                    p("To contact:", 
                      HTML("<a href=\"mailto:reynaldovg@gmail.com\">
                           <b>&nbsp;&nbsp;send&nbsp;a&nbsp;message&nbsp;
                           via&nbsp;email</b></a>"),style="color: white"),
                    p("To learn more, visit the following links,", 
                      style="color: white"),
                    HTML("<a href=\"https://rexvax.wordpress.com/\"target=
                         \"_blank\"><b>&nbsp;&nbsp;&nbsp;&nbsp;Personal&nbsp;
                         Site</b></a> "),br(),
                    HTML("<a href=\"https://www.linkedin.com/in/reynaldov/\"
                         target=\"_blank\"><b>&nbsp;&nbsp;&nbsp;
                         Linkedin&nbspProfile</b></a> "),br(),
                    HTML("<a href=\"https://github.com/reyvaz\"target=
                         \"_blank\"><b>&nbsp;&nbsp;&nbsp;&nbsp;GitHub</b></a>"),
                    br(),
                    h3("Thank you for visiting!", style = 'color: white'),
                    br()),
             column(10, align="justify", offset = 1,
                    style = "background-color:#1c1b1a;
                    padding: 35em 1em 5em 1em;",
                    br(),br(),hr(),br()
                    )
             )),
          div(id = "espanol",
               HTML("<h1 id=\"STop\"style=\"position:relative;
                    top:-2.4em\"></h1>"),
               HTML("
                  <div style=\"position: fixed; z-index:5; margin-top: -0.5em; 
                  width: 70%; min-width: 180px;
                  background-color: rgba(219, 162, 5, 0.90);
                  font-weight: bold;
                  font-size: large;
                  padding: 0.2em 0.7em;
                  border-radius: 0.0em 0.8em 0.8em 0.0em;\">
                  <a href=\"#SIns\">&nbsp;Instrucciones&nbsp;&nbsp;</a> 
                  <a href=\"#SAlg\">&nbsp;Algoritmos&nbsp;&nbsp;</a> 
                  <a href=\"#SCorp\">&nbsp;Corpus&nbsp;&nbsp;</a> 
                  <a href=\"#SAut\">&nbsp;Autor&nbsp;&nbsp;</a> 
                  <a href=\"#STop\">&nbsp;Top&nbsp;&nbsp;&nbsp;</a>
                  <a id=\"langEn\" href=\"#\" class=\"action-button shiny-bound-
                                                        input\">English&nbsp</a>
                  </div>"),
             HTML("<h1 id=\"SIns\" style=\"position:relative; 
                  top:-2.2em\"></h1>"),
             column(10, align="justify", offset = 1,
                    style = "background-color:#1c1b1a;padding: 5em 1em 1em 1em;"
                    ),
             column(10, align="justify", offset = 1,
                    style = "background-color:#862d59;
                    padding: 2em 3% 2em 3%;",
                    h2("Instrucciones", style = 'color: white'),
                    p("La aplicación admite texto y automáticamente provee:", 
                      style="color: white"), 
                    tags$ol(
                        tags$li("Sugerencias para completar la palabra en 
                                curso", style="color: white"), 
                        tags$li("Sugerencias para la siguiente palabra", 
                                style="color: white")
                    ),
                    p("Para generar sugerencias simplemente empieza a escribir  
                      dentro del espacio de texto", 
                      style="color: white"), 
                    tags$ol(
                        tags$li("Sugerencias para completar la palabra en curso 
                                aparecen subrayadas debajo del 
                                espacio de texto. Presiona en una opción para 
                                completar la palabra. O presiona 
                                ctrl+[numero de orden de la opción]. 
                                Ejem. ctrl+shift+1 para seleccionar 
                                la primera opción de izquierda a derecha", 
                                style="color: white"), 
                        tags$li("Sugerencias para la palabra siguiente aparecen 
                                en los botones de colores. Presiona en una 
                                opción para adherirla al final del texto. O
                                presiona ctrl+[numero de orden de la 
                                opción]. Ejem. ctrl+1 para seleccionar 
                                la primera opción de izquierda a derecha", 
                                style="color: white")
                    ),
                    p("Opciones", style="color: white"), 
                    tags$ol(
                        tags$li("Presiona en el botón \"mostrar opciones\" para 
                                ver las opciones", style="color: white"),
                        tags$li("Presiona en \"ocultar ayuda\" para ocultar 
                                las instrucciones. Repite para 
                                volver a mostrar la ayuda", 
                                style="color: white"),
                        tags$li("Presiona \"solo siguientes\" para ocultar
                                las sugerencias de la palabra en curso.
                                Repite para nuevamente 
                                mostrarlas",
                                style="color: white"),
                        tags$li("Presiona “mostrar menos” para mostrar 
                                solo 3 sugerencias de palabra siguiente. 
                                Repite para nuevamente mostrar 5",
                                style="color: white")
                        ),
                    HTML("<h1 id=\"SAlg\" style=\"position: relative; 
                         top:-2em\"> </h1>")
                    ),
             column(10, align="justify", offset = 1,
                    style = "background-color:#1c1b1a; 
                    padding: 5em 1em 1em 1em;"),
             column(10, align="justify", offset = 1,
                    style = "background-color:#4d3a7d;
                    padding: 2em 3% 2em 3%;",
                    h2("Algoritmos", style = 'color: white'),
                    p("La aplicación depende principalmente de 2 algoritmos. Uno  
                      para la palabra siguiente, y uno para la palabra en  
                      curso.", style="color: white"), 
                    p("El predictor de la palabra siguiente usa un algoritmo de 
                      n-gramas tipo cadena Markov. Monogramas, 
                      bigramas, trigramas y tetragramas se acompañan de 
                      palabras con la mayor probabilidad de proseguirlos de 
                      acuerdo al corpus. ", style="color: white"), 
                    p("El algoritmo empieza formando el n-grama más alto  
                      posible con las últimas 4, 3, 2 o 1 palabras recibidas en  
                      su orden original.", style="color: white"), 
                    p("Luego prosigue de la siguiente forma, interrumpiendose 
                      cuando haya encontrado 5 sugerencias únicas. ", 
                      style="color: white"), 
                    tags$ol(
                        tags$li("Usa el n-grama más alto como estado Markov", 
                                style="color: white"), 
                        tags$li("Usa el segundo, después tercero, etc. n-grama 
                              más alto como estado Markov", 
                                style="color: white"), 
                        tags$li("Hace ciertas modificaciones ortográficas  y 
                              repite pasos 1 y 2", style="color: white"), 
                        tags$li("Ignora la ultima palabra y repite pasos 1 y 2", 
                                style="color: white"), 
                        tags$li("Usa un complejo de palabras predefinidas", 
                                style="color: white")
                        ),
                    p("El algoritmo primero procesa y traduce el estado Markov  
                      en un código numérico único. Luego busca y almacena los  
                      códigos de sugerencias asignados a ese código. Al final, 
                      convierte los códigos de sugerencias en palabras. ", 
                      style="color: white"), 
                    p("El predictor de la palabra en curso utiliza el 
                      algoritmo anterior, ignorando la ultima palabra, 
                      para determinar las palabras mas comunes que prosiguen las
                      palabras anteriores. Ya que estas se hallan:", 
                      style="color: white"), 
                    tags$ol(
                      tags$li("El algoritmo usa todos los caracteres de
                              la palabra en curso como estado actual", 
                              style="color: white"), 
                      tags$li("Transforma el estado actual de forma que 
                              abarque diversas variantes ortográficas y 
                              corrija ciertos errores", 
                              style="color: white"), 
                      tags$li("Busca, entre las palabras mas comunes que  
                              siguen a las anteriores, las que coincidan 
                              con el estado actual", style="color: white"), 
                      tags$li("Busca entre palabras ponderadas 
                              de acuerdo a sus frecuencias en el corpus", 
                              style="color: white"), 
                      tags$li("Provee de 0 a 4 sugerencias", 
                              style="color: white")
                        ),
                    HTML("<h1 id=\"SCorp\"style=\"position: relative; 
                         top:-2em\"></h1>")
                    ),
             column(10, align="justify", offset = 1,
                    style = "background-color:#1c1b1a; 
                    padding: 5em 1em 1em 1em;"),
             column(10, align="justify", offset = 1,
                    style = "background-color:#1f3d7a; padding: 2em 3% 2em 3%;",
                    h2("Corpus", style = 'color: white'),
                    p("Para construir el predictor las siguientes fuentes fueron 
                      utilizadas,", style="color: white"), 
                    tags$ol(
                        tags$li("Aproximadamente el 10 por ciento del Spanish 
                                Billion  Words Corpus, recopilado por Cristian  
                                Cardellino (Marzo de 2016) y descargado en 
                                Septiembre 12 del 2017. La recopilación incluye:  
                                porciones del SenSem, Corpus Ancora, Tibidabo  
                                Treebank y IULA Spanish LSP Treebank, Proyecto  
                                OPUS, Europarl, Wikipedia, Wikisource y 
                                Wikibooks", style="color: white"), 
                        tags$li("Artículos actualizados de Wikipedia versión  
                                español descargados  el 12 de septiembre del 
                                2017", style="color: white"), 
                        tags$li("Una colección de estados populares y recientes  
                                de Twitter en castellano descargados entre el  
                                12 y el 14 de septiembre del 2017",
                                style="color: white")
                        ),
                    p("Dichas fuentes fueron después procesadas para eliminar 
                      elementos no relacionados con el corpus y separar  
                      hashtags, entre otras transformaciones.",  
                      style="color: white"),
                    p("El procesamiento se mantuvo intencionalmente al mínimo  
                      para así capturar el castellano tal y como es comúnmente  
                      escrito, incluyendo gramática,  errores ortográficos,  
                      abreviaciones, siglas, jerga y regionalismos.", 
                      style="color: white"),
                    p("El corpus procesado contiene ~200 millones de palabras en
                      un archivo de ~1.5 GiB. Y cuenta con texto de diversas
                      regiones de habla castellana pero mayormente de España,  
                      México, Argentina y Estados Unidos.", 
                      style="color: white"),
                    HTML("<h1 id=\"SAut\" style=\"position: relative; 
                         top:-2em\"></h1>")
                    ),
             column(10, align="justify", offset = 1,
                    style = "background-color:#1c1b1a; padding:5em 1em 1em 1em;"
             ),
             column(10, align="justify", offset = 1,
                    style = "background-color:#004d1a;
                    padding: 2em 3% 2em 3%;",
                    h2("Acerca del Autor", style = 'color: white'),
                    p("Reynaldo es un científico de datos, doctorando y master 
                      en economía por la Universidad de California, Santa 
                      Bárbara. Graduado Suma Cum Laude con  licenciatura en 
                      economía de la CSU, Los Ángeles. ", style="color: white"), 
                    p("Además de tener experiencia en 
                      estadística, matemáticas, econometría y programación, 
                      cuenta con certificaciones en data science por la 
                      Universidad de Johns Hopkins y en machine learning por la
                      Universidad de Stanford.", style="color: white"),
                    p("Anteriormente se ha desempeñado como catedrático e 
                      investigador en la Universidad de California, con 
                      especialidad en macroeconomía y finanzas públicas. 
                      Habla inglés, castellano e italiano. ", 
                      style="color: white"),
                    h2("Contacto:", style = 'color: white'),
                    p("Para contactar:", 
                      HTML("<a href=\"mailto:reynaldovg@gmail.com\">
                           <b>&nbsp;&nbsp;Envia email</b></a>"),
                           style="color: white"),
                    p("Para descubrir más, utiliza los enlaces siguientes:", 
                      style="color: white"),
                    HTML("<a href=\"https://rexvax.wordpress.com/\"target=
                         \"_blank\"><b>&nbsp;&nbsp;&nbsp;&nbsp;Sitio&nbsp;
                         Personal</b></a> "),br(),
                    HTML("<a href=\"https://www.linkedin.com/in/reynaldov/\"
                        target=\"_blank\"><b>&nbsp;&nbsp;&nbsp;
                         Perfíl&nbsp;Linkedin</b></a> "),br(),
                    HTML("<a href=\"https://github.com/reyvaz\"target=
                         \"_blank\"><b>&nbsp;&nbsp;&nbsp;&nbsp;GitHub</b></a>"),
                    br(),
                    h3("¡Gracias por tu visita!", style = 'color: white'),br()),
             column(10, align="justify", offset = 1,
                    style = "background-color:#1c1b1a;
                    padding: 35em 1em 5em 1em;",
                    br(),br(),hr(),br())
             )
           )
          )
        )
      )
  )