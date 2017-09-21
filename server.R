# Contains the shinyServer portion of the shiny App for the Spanish word 
# predictor. It requires shiny_predictor.R to load functions and required data.
# It also requires "shinyjs' package, which is loaded in the shinyUI.
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
source("predict_both.R")
shinyServer(
    function(input, output, session) {
        session$sendCustomMessage(type="refocus",message=list(NULL))
        n <- 0
        observeEvent(input$langEs, {
            toggle("espanol")
            toggle("english")
        })
        observeEvent(input$langEn, {
            toggle("espanol")
            toggle("english")
        })
        observeEvent(input$centerHelp, { 
            show("topHelp")
            hide("centerHelp")
            if ( h == 0){
                updateActionButton(session, "optionMenu", label ="más opciones")
            }
            if (n == 0) {
                updateActionButton(session, "centerHelp", label="mostrar ayuda")
                updateActionButton(session, "topHelp", label = "mostrar ayuda")
                hide("texthelp0")
                hide("texthelp")
                n <<- 1
            } else if (n == 1){
                updateActionButton(session, "centerHelp", label="ocultar ayuda")
                updateActionButton(session, "topHelp", label = "ocultar ayuda")
                show("texthelp0")
                show("texthelp")
                n <<- 0
            }
            session$sendCustomMessage(type="refocus",message=list(NULL))
        })
        h <- 0
        observeEvent(input$optionMenu, { 
            toggle("currents")
            toggle("preds")
            if (h == 0) {
                updateActionButton(session, "optionMenu", 
                                   label = "ocultar opciones")
                show("topHelp")
                h <<- 1
            } else if (h == 1){
                updateActionButton(session, "optionMenu", 
                                   label = "mostrar opciones")
                hide("topHelp")
                h <<- 0
            }
            session$sendCustomMessage(type="refocus",message=list(NULL))
        })
        tipN <- 0
        observeEvent(input$topHelp, { 
            hide("centerHelp")
            if (n == 0) {
                updateActionButton(session, "topHelp", label = "mostrar ayuda")
                updateActionButton(session, "centerHelp", label="mostrar ayuda")
                hide("texthelp0")
                hide("texthelp")
                n <<- 1
            } else if (n == 1){
                updateActionButton(session, "topHelp", label = "ocultar ayuda")
                updateActionButton(session, "centerHelp", label="ocultar ayuda")
                show("texthelp")
                if (k == 0) {
                    show("texthelp0")
                }
                showModal(modalDialog(title = "Instrucciones",
                    HTML("Para generar sugerencias simplemente empieza a 
                        escribir en el espacio de texto 
                <br><br> 
                Sugerencias para la <u>palabra actual</u> aparecen subrayadas
                debajo del espacio de texto. Presiona en una para completar la 
                palabra. O usa ctrl+shift+[numero de orden de la opción]. Ejem. 
                ctrl+shift+1 para la primera opción de izquierda a derecha. 
                <br><br> 
                Sugerencias para la <u>palabra siguiente </u> aparecen en los 
                botones de colores. Presiona en una para adherirla al texto. O 
                usa ctrl+[numero de orden de la opción]. Ejem. ctrl+1 
                para la primera opción de izquierda a derecha. 
                <br><br> 
                Nota: las opciones ctrl+ pueden no funcionar en algunos 
                sistemas")
                ))
                tipN <<- 1
                n <<- 0
            }
            session$sendCustomMessage(type="refocus",message=list(NULL))
        })
        j <- 0
        observeEvent(input$preds, { 
            toggle("button4")
            toggle("button5")
            if (j == 0) {
                updateActionButton(session, "preds", label = "mostrar más")
                j <<- 1
            } else if (j == 1){
                updateActionButton(session, "preds", label = "mostrar menos")
                j <<- 0
            }
            session$sendCustomMessage(type="refocus",message=list(NULL))
        })
        k <- 0
        observeEvent(input$currents, { 
            toggle("button6")
            toggle("button7")
            toggle("button8")
            if (k == 0) {
                updateActionButton(session, "currents", label ="también actual")
                hide("texthelp0")
                k <<- 1
            } else if (k == 1){
                updateActionButton(session, "currents", label ="solo siguiente")
                k <<- 0
                if (n == 0) {
                    show("texthelp0")
                }
            }
            session$sendCustomMessage(type="refocus",message=list(NULL))
        })
        pred_both <- reactive({
            req(input$usertext)
            hide("currents")
            hide("preds")
            updateActionButton(session, "optionMenu", label ="mostrar opciones")
            hide("topHelp")
            h <<- 0
            predict.both(input$usertext)
        })
        pred_next <- reactive({
            pred_both()$predictions
        })
        pred_current <- reactive({
            pred_both()$current
        })
        observeEvent(input$button1, {
            if (length(pred_next()) > 3 && tipN == 0) {
                showNotification("Tip: Prueba ctrl+[num]
                     para seccionar una opción de palabra siguiente (ejem. 
                     ctrl+1 para el botón verde).
                     O ctrl+shift+[num]
                     para seleccionar una opción de palabra actual.
                     (no esta disponible en algunas configuraciones)",
                                 duration = 20, type = "message")
                tipN <<- 1
            }
        })
        output$texthelp <- renderText({ 
            if (input$usertext == ""){
                show <- "<text style='color: white'>sugerencias de palabra 
                siguiente aparecerán aquí"
            } else {
                show <- "<text style='color:#737373'>presiona una opción para  
                adherir al texto"
            }
        })
        output$texthelp0 <- renderText({ 
            if (input$usertext == ""){
                show <- "<text style='color:#bfbfbf'>sugerencias para la 
                palabra en curso aparecerán aquí"
            } else if (length(pred_current())  < 1){
                show <- "<text style='color:#1c1b1a'>no se han encontrado 
                sugerencias para la palabra actual"
            } else {
                show <- "<text style='color:#737373'>presiona una opción 
                para completar la palabra"
            }
        })
        output$text1 <- renderText({ 
            pred_next()[1]
        })
        output$text2 <- renderText({ 
            pred_next()[2]
        })
        output$text3 <- renderText({ 
            pred_next()[3]
        })
        output$text4 <- renderText({ 
            pred_next()[4]
        })
        output$text5 <- renderText({
            show <- pred_next()[5]
        })
        output$text6 <- renderText({ 
            if (length(pred_current()) < 1){
                show <- ""
            } else {
                show <- paste("<u>",  pred_current()[1], "</u>")
            }
        })
        output$text7 <- renderText({ 
            show <- paste("<u>",  pred_current()[2], "</u>")
        })
        output$text8 <- renderText({ 
            show <- paste("<u>",  pred_current()[3], "</u>")
        })
        output$text9 <- renderText({ 
            show <- paste("<u>",  pred_current()[4], "</u>")
        })
        observeEvent(input$usertext, {
          if (length(pred_current()) < 2){
            hide("curr2"); hide("curr3"); hide("curr4");
          } else if (length(pred_current()) < 3){
            show("curr2"); hide("curr3"); hide("curr4");
          } else if (length(pred_current()) < 4){
            show("curr2"); show("curr3"); hide("curr4");
          } else {
            show("curr2"); show("curr3"); show("curr4");
          }
        })
        observeEvent(input$button6, {
            if (length(pred_current())  > 0){
                updateTextInput(session, "usertext", 
                      value = replace.last(input$usertext, pred_current()[1]))
            } 
            session$sendCustomMessage(type="refocus",message=list(NULL))
        })
        observeEvent(input$button7, {
            if (length(pred_current())  > 1){
                updateTextInput(session, "usertext", 
                      value = replace.last(input$usertext, pred_current()[2]))
            } 
            session$sendCustomMessage(type="refocus",message=list(NULL))
        })
        observeEvent(input$button8, {
            if (length(pred_current())  > 2){
                updateTextInput(session, "usertext", 
                      value = replace.last(input$usertext, pred_current()[3]))
            } 
            session$sendCustomMessage(type="refocus",message=list(NULL))
        })
        observeEvent(input$button9, {
          if (length(pred_current())  > 3){
            updateTextInput(session, "usertext", 
                            value = replace.last(input$usertext, pred_current()[4]))
          } 
          session$sendCustomMessage(type="refocus",message=list(NULL))
        })
        observeEvent(input$reset, {
            updateTextInput(session, "usertext", value = "")
            session$sendCustomMessage(type="refocus",message=list(NULL))
        })
        observeEvent(input$button1, {
            updateTextInput(session, "usertext", 
                      value = paste(input$usertext, pred_next()[1]))
            session$sendCustomMessage(type="refocus",message=list(NULL))
        })
        observeEvent(input$button2, {
            updateTextInput(session, "usertext", 
                      value = paste(input$usertext, pred_next()[2]))
            session$sendCustomMessage(type="refocus",message=list(NULL))
        })
        observeEvent(input$button3, {
            updateTextInput(session, "usertext", 
                     value = paste(input$usertext, pred_next()[3]))
            session$sendCustomMessage(type="refocus",message=list(NULL))
        })
        observeEvent(input$button4, {
            updateTextInput(session, "usertext", 
                     value = paste(input$usertext, pred_next()[4]))
            session$sendCustomMessage(type="refocus",message=list(NULL))
        })
        observeEvent(input$button5, {
            if (length(pred_next()) < 5){
                show <- ""
            } else {
                show <- pred_next()[5]
            }
            updateTextInput(session, "usertext", 
                            value = paste(input$usertext, show))
            session$sendCustomMessage(type="refocus",message=list(NULL))
        })
    }
)