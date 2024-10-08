library(shinytest2)

test_that("{shinytest2} recording: test_fig", {
  app <- AppDriver$new(app_dir = "results_app/", name = "test_fig", height = 1080, width =1920 , load_timeout = 100000, wait = T)
  # lvls <- ifelse(SCENARIO_INCREASE == 0.05, c("level1", "level2", "level3"), "level1")
  lvls <- "level1"
  if (SCENARIO_INCREASE == 0.05){
    lvls <- c("level1", "level2", "level3")
  }
  # 
  # lvls <- "level2"
  print(lvls)
  pw_lvl1 <- c("PA and AP", "RTI")
  pw_lvl2 <- c("PA", "PA and AP", "AP", "RTI")
  pw_lvl3 <- c("PA and AP", "AP", "PA", "RTI")
  for (in_m in c("Deaths", "Years of Life Lost (YLLs)")){
    for (in_lvl in lvls){
      for (in_str in c("None", "Sex", "Age Group")){
        for (in_per100 in c(FALSE, TRUE)){
          for (in_pathway in c("No", "Yes")){
            pw <- ""
            if (in_pathway == "No")
              pw <- c("PA", "AP", "RTI")
            else {
              if (in_lvl == "level1")
                pw <- pw_lvl1
              else if (in_lvl == "level2")
                pw <- pw_lvl2
              else
                pw <- pw_lvl3
            }
            app$set_inputs(in_measure = in_m, 
                           in_level = in_lvl, 
                           in_pathways = pw,
                           in_strata = in_str,
                           in_per_100k = in_per100, 
                           in_int_pathway = in_pathway, 
                           timeout_ = 1000000)
          }
        }
      }
    }
  }
  app$set_inputs(main_tab = 'Injury Risks')
  for (rt in c("Billion kms", "Population by 100k people", "100 million hours")){
    app$set_inputs(in_scens = c("Baseline", "CYC_SC", "CAR_SC", "BUS_SC"),
                   in_risk_type = rt,
                   in_inj_modes = "Total",
                   timeout_ = 1000000)
    app$set_inputs(in_scens = c("Baseline", "CYC_SC", "CAR_SC", "BUS_SC"),
                   in_risk_type = rt,
                   in_inj_modes = c("Active Travel (Walking And Cycling)", "Bus"
                                    , "Car", "Cycle", "Motorcycle", "Pedestrian", "Total"),
                   timeout_ = 1000000)

  }

})