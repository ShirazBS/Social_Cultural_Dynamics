globals [
  companies
  gender-ethnicity-scores
  white-male-vector
  white-female-vector
  black-male-vector
  black-female-vector
  latino-male-vector
  latino-female-vector
  asian-male-vector
  asian-female-vector
  other-male-vector
  other-female-vector
]

turtles-own [
  gender
  ethnicity
  vector
]

patches-own [
  company-category
  women-proportion
  ethnic-diversity
  mean-gender-ethnicity
]

to setup
  clear-all
  initialize-gender-ethnicity-vectors
  show white-male-vector
  show white-female-vector
  show black-male-vector
  show black-female-vector
  show latino-male-vector
  show latino-female-vector
  show asian-male-vector
  show asian-female-vector
  show other-male-vector
  show other-female-vector
  setup-world
  setup-companies
  reset-ticks
end

to setup-world
  set companies 100
  ask patches [
    let rnd random-float 100
    ifelse rnd < 5 [
      set company-category "diversity leaders"
      set pcolor red
      set-baseline 0.50 0.35
    ] [
      ifelse rnd < 5 + 28 [
        set company-category "fast movers"
        set pcolor orange
        set-baseline 0.32 0.23
      ] [
        ifelse rnd < 5 + 28 + 29 [
          set company-category "resting on laurels"
          set pcolor yellow
          set-baseline 0.26 0.15
        ] [
          ifelse rnd < 5 + 28 + 29 + 10 [
            set company-category "moderate movers"
            set pcolor green
            set-baseline 0.20 0.12
          ] [
            set company-category "laggards"
            set pcolor blue
            set-baseline 0.14 0.01
          ]
        ]
      ]
    ]
  ]
end

to set-baseline [women-proportion-base ethnic-diversity-base]
    set women-proportion women-proportion-base
    set ethnic-diversity ethnic-diversity-base
end


to setup-companies
  ask patches [
    sprout 70 [
      let total-men-proportion 1 - women-proportion
      let total-women-proportion women-proportion

      let global-white-men-proportion 0.5625
      let global-colored-men-proportion 0.1525
      let global-white-women-proportion 0.2225
      let global-colored-women-proportion 0.0625

   let white-men-proportion 0
      let colored-men-proportion 0
      let white-women-proportion 0
      let colored-women-proportion 0

      let denominator-men global-white-men-proportion + global-colored-men-proportion
      let denominator-women global-white-women-proportion + global-colored-women-proportion

      if denominator-men != 0 [
        set white-men-proportion (total-men-proportion * global-white-men-proportion) / denominator-men
        set colored-men-proportion (total-men-proportion * global-colored-men-proportion) / denominator-men
      ]

      if denominator-women != 0 [
        set white-women-proportion (total-women-proportion * global-white-women-proportion) / denominator-women
        set colored-women-proportion (total-women-proportion * global-colored-women-proportion) / denominator-women
      ]

      let latino-men-proportion (colored-men-proportion * 0.208)
      let asian-men-proportion (colored-men-proportion * 0.417)
      let black-men-proportion (colored-men-proportion * 0.333)
      let other-men-proportion (colored-men-proportion * 0.042)

      let latino-women-proportion (colored-women-proportion * 0.208)
      let asian-women-proportion (colored-women-proportion * 0.417)
      let black-women-proportion (colored-women-proportion * 0.333)
      let other-women-proportion (colored-women-proportion * 0.042)

      let gender-rnd random-float 1
      let eth-rnd random-float 1

      ifelse gender-rnd < white-women-proportion [
        set gender "female"
        set ethnicity "white"
        set color pink
        set shape "person"
      ] [
        ifelse gender-rnd < white-women-proportion + latino-women-proportion [
          set gender "female"
          set ethnicity "latino"
          set color orange
          set shape "person"
        ] [
          ifelse gender-rnd < white-women-proportion + latino-women-proportion + asian-women-proportion [
            set gender "female"
            set ethnicity "asian"
            set color yellow
            set shape "person"
          ] [
            ifelse gender-rnd < white-women-proportion + latino-women-proportion + asian-women-proportion + black-women-proportion [
              set gender "female"
              set ethnicity "black"
              set color violet
              set shape "person"
            ] [
              ifelse gender-rnd < white-women-proportion + latino-women-proportion + asian-women-proportion + black-women-proportion + other-women-proportion [
                set gender "female"
                set ethnicity "other"
                set color sky
                set shape "person"
              ] [
                ifelse gender-rnd < white-women-proportion + latino-women-proportion + asian-women-proportion + black-women-proportion + other-women-proportion + white-men-proportion [
                  set gender "male"
                  set ethnicity "white"
                  set color blue
                  set shape "person"
                ] [
                  ifelse gender-rnd < white-women-proportion + latino-women-proportion + asian-women-proportion + black-women-proportion + other-women-proportion + white-men-proportion + latino-men-proportion [
                    set gender "male"
                    set ethnicity "latino"
                    set color lime
                    set shape "person"
                  ] [
                    ifelse gender-rnd < white-women-proportion + latino-women-proportion + asian-women-proportion + black-women-proportion + other-women-proportion + white-men-proportion + latino-men-proportion + asian-men-proportion [
                      set gender "male"
                      set ethnicity "asian"
                      set color gray
                      set shape "person"
                    ] [
                      ifelse gender-rnd < white-women-proportion + latino-women-proportion + asian-women-proportion + black-women-proportion + other-women-proportion + white-men-proportion + latino-men-proportion + asian-men-proportion + black-men-proportion [
                        set gender "male"
                        set ethnicity "black"
                        set color red
                        set shape "person"
                      ] [
                        set gender "male"
                        set ethnicity "other"
                        set color magenta
                        set shape "person"
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
      assign-vector
    ]
  ]
end

to initialize-gender-ethnicity-vectors
  ; Initialize the vectors for each gender and ethnicity combination
  ; Representing gender and ethnicity in the order: [white, latino, black, asian, other]

  set white-male-vector   [0.2 0.2 0.2 0.2 0.2]  ; Male, White
  set white-female-vector [0.2 0.2 0.2 0.2 0.2]  ; Female, White

  set black-male-vector   [0.2 0.2 0.2 0.2 0.2]  ; Male, Black
  set black-female-vector [0.2 0.2 0.2 0.2 0.2]  ; Female, Black

  set latino-male-vector   [0.2 0.2 0.2 0.2 0.2] ; Male, Latino
  set latino-female-vector [0.2 0.2 0.2 0.2 0.2] ; Female, Latino

  set asian-male-vector   [0.2 0.2 0.2 0.2 0.2]  ; Male, Asian
  set asian-female-vector [0.2 0.2 0.2 0.2 0.2]  ; Female, Asian

  set other-male-vector   [0.2 0.2 0.2 0.2 0.2]  ; Male, Other
  set other-female-vector [0.2 0.2 0.2 0.2 0.2]  ; Female, Other
end

to assign-vector
  if gender = "male" [
    if ethnicity = "white" [ set vector white-male-vector ]
    if ethnicity = "latino" [ set vector latino-male-vector ]
    if ethnicity = "black" [ set vector black-male-vector ]
    if ethnicity = "asian" [ set vector asian-male-vector ]
    if ethnicity = "other" [ set vector other-male-vector ]
  ]
  if gender = "female" [
    if ethnicity = "white" [ set vector white-female-vector ]
    if ethnicity = "latino" [ set vector latino-female-vector ]
    if ethnicity = "black" [ set vector black-female-vector ]
    if ethnicity = "asian" [ set vector asian-female-vector ]
    if ethnicity = "other" [ set vector other-female-vector ]
  ]
end

to go
  if ticks mod 2 = 0 [
    analyze-turtles
    hire-new-turtle
  ]
  tick
end

;to analyze-turtles
;  ask patches [
;    let team-turtles turtles-here
;    let team-vectors [vector] of team-turtles
;    let total-vectors reduce [ [v1 v2] -> map [total -> total + item position v1 v2] v1] team-vectors
;    let mean-vector map [total -> total / count team-turtles] total-vectors
;    set mean-gender-ethnicity mean-vector
;  ]
;end

to analyze-turtles
  ask patches [
    let team-turtles turtles-here
    let team-vectors [vector] of team-turtles
    let total-vectors reduce [ [v1 v2] -> map [i -> (item i v1) + (item i v2)] n-values length v1 [i -> i]] team-vectors
    let mean-vector map [total -> total / count team-turtles] total-vectors
    set mean-gender-ethnicity mean-vector
  ]
end


to hire-new-turtle
  ask patches [
    ; Ensure there are turtles on the patch
    if any? turtles-here [
      ; Randomly select 10 candidate turtles from the entire population
      let candidates n-of 10 turtles
      let candidate-list sort candidates ; Convert to a list and sort for consistent indexing

      ; Calculate the probabilities for each candidate
      let probabilities []
      foreach candidate-list [
        candidate ->
        let dist euclidean-distance [vector] of candidate mean-gender-ethnicity
        let probability 1 - dist
        set probabilities lput probability probabilities
      ]

      ; Normalize the probabilities to sum to 1
      let total-sum sum probabilities
      let normalized-probabilities map [prob -> prob / total-sum] probabilities

      ; Generate a random number between 0 and 1
      let rand random-float 1

      ; Select a candidate based on the weighted probabilities
      let cumulative-sum 0
      let selected-candidate nobody
      foreach candidate-list [
        candidate ->
        let index position candidate candidate-list
        if selected-candidate = nobody and rand < cumulative-sum + item index normalized-probabilities [
          set selected-candidate candidate
        ]
        set cumulative-sum cumulative-sum + item index normalized-probabilities
      ]

      ; Replace a random turtle in the patch with the selected candidate
      ask one-of turtles-here [
        set gender [gender] of selected-candidate
        set ethnicity [ethnicity] of selected-candidate
        set vector [vector] of selected-candidate
        set color [color] of selected-candidate
        set shape [shape] of selected-candidate
      ]
    ]
  ]
end


to-report euclidean-distance [vec1 vec2]
  let squared-differences map [
    [[pair] ->
    let x item 0 pair
    let y item 1 pair
      report ((x - y) ^ 2)]
  ]
  (map list vec1 vec2)
  let sum-of-squared-differences sum squared-differences
  let dist sqrt sum-of-squared-differences
  report dist
end


; reporting the turtule coutn per company category - starting with diversity leaders
to-report women
  report turtles with [gender = "female"]
end

to-report white-women-representation-diversity-leaders
  report count women with [ethnicity = "white" and company-category = "diversity leaders"] / count women
end

to-report latino-women-representation-diversity-leaders
  report count women with [ethnicity = "latino" and company-category = "diversity leaders"] / count women
end

to-report black-women-representation-diversity-leaders
  report count women with [ethnicity = "black" and company-category = "diversity leaders"] / count women
end

to-report asian-women-representation-diversity-leaders
  report count women with [ethnicity = "asian" and company-category = "diversity leaders"] / count women
end

to-report other-women-representation-diversity-leaders
  report count women with [ethnicity = "other" and company-category = "diversity leaders"] / count women
end

to-report men
  report turtles with [gender = "male"]
end

to-report white-men-representation-diversity-leaders
  report count men with [ethnicity = "white" and company-category = "diversity leaders"] / count men
end

to-report latino-men-representation-diversity-leaders
  report count men with [ethnicity = "latino" and company-category = "diversity leaders"] / count men
end

to-report black-men-representation-diversity-leaders
  report count men with [ethnicity = "black" and company-category = "diversity leaders"] / count men
end

to-report asian-men-representation-diversity-leaders
  report count men with [ethnicity = "asian" and company-category = "diversity leaders"] / count men
end

to-report other-men-representation-diversity-leaders
  report count men with [ethnicity = "other" and company-category = "diversity leaders"] / count men
end

; fast movers


to-report white-women-representation-fast-movers
  report count women with [ethnicity = "white" and company-category = "fast movers"] / count women
end

to-report latino-women-representation-fast-movers
  report count women with [ethnicity = "latino" and company-category = "fast movers"] / count women
end

to-report black-women-representation-fast-movers
  report count women with [ethnicity = "black" and company-category = "fast movers"] / count women
end

to-report asian-women-representation-fast-movers
  report count women with [ethnicity = "asian" and company-category = "fast movers"] / count women
end

to-report other-women-representation-fast-movers
  report count women with [ethnicity = "other" and company-category = "fast movers"] / count women
end

to-report white-men-representation-fast-movers
  report count men with [ethnicity = "white" and company-category = "fast movers"] / count men
end

to-report latino-men-representation-fast-movers
  report count men with [ethnicity = "latino" and company-category = "fast movers"] / count men
end

to-report black-men-representation-fast-movers
  report count men with [ethnicity = "black" and company-category = "fast movers"] / count men
end

to-report asian-men-representation-fast-movers
  report count men with [ethnicity = "asian" and company-category = "fast movers"] / count men
end

to-report other-men-representation-fast-movers
  report count men with [ethnicity = "other" and company-category = "fast movers"] / count men
end

; resting on laurels

to-report white-women-representation-resting-on-laurels
  report count women with [ethnicity = "white" and company-category = "resting on laurels"] / count women
end

to-report latino-women-representation-resting-on-laurels
  report count women with [ethnicity = "latino" and company-category = "resting on laurels"] / count women
end

to-report black-women-representation-resting-on-laurels
  report count women with [ethnicity = "black" and company-category = "resting on laurels"] / count women
end

to-report asian-women-representation-resting-on-laurels
  report count women with [ethnicity = "asian" and company-category = "resting on laurels"] / count women
end

to-report other-women-representation-resting-on-laurels
  report count women with [ethnicity = "other" and company-category = "resting on laurels"] / count women
end

to-report white-men-representation-resting-on-laurels
  report count men with [ethnicity = "white" and company-category = "resting on laurels"] / count men
end

to-report latino-men-representation-resting-on-laurels
  report count men with [ethnicity = "latino" and company-category = "resting on laurels"] / count men
end

to-report black-men-representation-resting-on-laurels
  report count men with [ethnicity = "black" and company-category = "resting on laurels"] / count men
end

to-report asian-men-representation-resting-on-laurels
  report count men with [ethnicity = "asian" and company-category = "resting on laurels"] / count men
end

to-report other-men-representation-resting-on-laurels
  report count men with [ethnicity = "other" and company-category = "resting on laurels"] / count men
end

; moderate movers

to-report white-women-representation-moderate-movers
  report count women with [ethnicity = "white" and company-category = "moderate movers"] / count women
end

to-report latino-women-representation-moderate-movers
  report count women with [ethnicity = "latino" and company-category = "moderate movers"] / count women
end

to-report black-women-representation-moderate-movers
  report count women with [ethnicity = "black" and company-category = "moderate movers"] / count women
end

to-report asian-women-representation-moderate-movers
  report count women with [ethnicity = "asian" and company-category = "moderate movers"] / count women
end

to-report other-women-representation-moderate-movers
  report count women with [ethnicity = "other" and company-category = "moderate movers"] / count women
end

to-report white-men-representation-moderate-movers
  report count men with [ethnicity = "white" and company-category = "moderate movers"] / count men
end

to-report latino-men-representation-moderate-movers
  report count men with [ethnicity = "latino" and company-category = "moderate movers"] / count men
end

to-report black-men-representation-moderate-movers
  report count men with [ethnicity = "black" and company-category = "moderate movers"] / count men
end

to-report asian-men-representation-moderate-movers
  report count men with [ethnicity = "asian" and company-category = "moderate movers"] / count men
end

to-report other-men-representation-moderate-movers
  report count men with [ethnicity = "other" and company-category = "moderate movers"] / count men
end

; laggards

to-report white-women-representation-laggards
  report count women with [ethnicity = "white" and company-category = "laggards"] / count women
end

to-report latino-women-representation-laggards
  report count women with [ethnicity = "latino" and company-category = "laggards"] / count women
end

to-report black-women-representation-laggards
  report count women with [ethnicity = "black" and company-category = "laggards"] / count women
end

to-report asian-women-representation-laggards
  report count women with [ethnicity = "asian" and company-category = "laggards"] / count women
end

to-report other-women-representation-laggards
  report count women with [ethnicity = "other" and company-category = "laggards"] / count women
end

to-report white-men-representation-laggards
  report count men with [ethnicity = "white" and company-category = "laggards"] / count men
end

to-report latino-men-representation-laggards
  report count men with [ethnicity = "latino" and company-category = "laggards"] / count men
end

to-report black-men-representation-laggards
  report count men with [ethnicity = "black" and company-category = "laggards"] / count men
end

to-report asian-men-representation-laggards
  report count men with [ethnicity = "asian" and company-category = "laggards"] / count men
end

to-report other-men-representation-laggards
  report count men with [ethnicity = "other" and company-category = "laggards"] / count men
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
647
448
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
32
140
98
173
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
30
175
93
208
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
670
15
1405
600
Representation Over Time
ticks
proportions
0.0
200.0
0.0
1.0
false
true
"" ""
PENS
"White Women Diversity Leaders" 1.0 0 -2064490 true "plot white-women-representation-diversity-leaders" "plot white-women-representation-diversity-leaders\n"
"White Women Fast Movers" 1.0 0 -2064490 true "plot white-women-representation-fast-movers" "plot white-women-representation-fast-movers"
"White Women Resting on Laurels" 1.0 0 -2064490 true "plot white-women-representation-resting-on-laurels" "plot white-women-representation-resting-on-laurels"
"White Women Moderate Movers" 1.0 0 -2064490 true "plot white-women-representation-moderate-movers" "plot white-women-representation-moderate-movers"
"White Women Laggards" 1.0 0 -2064490 true "plot white-women-representation-laggards" "plot white-women-representation-laggards"
"Latino Women diversity Leaders" 1.0 0 -955883 true "plot latino-women-representation-diversity-leaders" "plot latino-women-representation-diversity-leaders"
"Latino Women Fast Movers" 1.0 0 -955883 true "plot latino-women-representation-fast-movers" "plot latino-women-representation-fast-movers"
"Latino Women Resting on Laurels" 1.0 0 -955883 true "plot latino-women-representation-resting-on-laurels" "plot latino-women-representation-resting-on-laurels"
"Latino Women Moderate Movers" 1.0 0 -955883 true "plot latino-women-representation-moderate-movers" "plot latino-women-representation-moderate-movers"
"Latino Women Laggards" 1.0 0 -955883 true "plot latino-women-representation-laggards" "plot latino-women-representation-laggards"
"Asian Women Diversity Leaders" 1.0 0 -1184463 true "plot asian-women-representation-diversity-leaders" "plot asian-women-representation-diversity-leaders"
"Asian Women Fast Movers" 1.0 0 -1184463 true "plot asian-women-representation-fast-movers" "plot asian-women-representation-fast-movers"
"Asian Women Resting on Laurels" 1.0 0 -1184463 true "plot asian-women-representation-resting-on-laurels" "plot asian-women-representation-resting-on-laurels"
"Asian Women Moderate Movers" 1.0 0 -1184463 true "plot asian-women-representation-moderate-movers" "plot asian-women-representation-moderate-movers"
"Asian Women Laggards" 1.0 0 -1184463 true "plot asian-women-representation-laggards" "plot asian-women-representation-laggards"
"Black Women Diversity Leaders" 1.0 0 -8630108 true "plot black-women-representation-diversity-leaders" "plot black-women-representation-diversity-leaders"
"Black Women Fast Movers" 1.0 0 -8630108 true "plot black-women-representation-fast-movers" "plot black-women-representation-fast-movers"
"Black Women Resting on Laurels" 1.0 0 -8630108 true "plot black-women-representation-resting-on-laurels" "plot black-women-representation-resting-on-laurels"
"Black Women Moderate Movers" 1.0 0 -8630108 true "plot black-women-representation-moderate-movers" "plot black-women-representation-moderate-movers"
"Black Women Laggards" 1.0 0 -8630108 true "plot black-women-representation-laggards" "plot black-women-representation-moderate-movers"
"Other Women Diversity Leaders" 1.0 0 -13791810 true "plot other-women-representation-diversity-leaders" "plot other-women-representation-diversity-leaders"
"Other Women Fast Movers" 1.0 0 -13791810 true "plot other-women-representation-fast-movers" "plot other-women-representation-fast-movers"
"Other Women Resting on Laurels" 1.0 0 -13791810 true "plot other-women-representation-resting-on-laurels" "plot other-women-representation-resting-on-laurels"
"Other Women Moderate Movers" 1.0 0 -13791810 true "plot other-women-representation-moderate-movers" "plot other-women-representation-moderate-movers"
"Other Women Laggards" 1.0 0 -13791810 true "plot other-women-representation-laggards" "plot other-women-representation-laggards"
"White Men Diversity Leaders" 1.0 0 -13345367 true "plot white-men-representation-diversity-leaders" "plot white-men-representation-diversity-leaders"
"White Men Fast Movers" 1.0 0 -13345367 true "plot white-men-representation-fast-movers" "plot white-men-representation-fast-movers"
"White Men Resting on Laurels" 1.0 0 -13345367 true "plot white-men-representation-resting-on-laurels" "plot white-men-representation-resting-on-laurels"
"White Men Moderate Movers" 1.0 0 -13345367 true "plot white-men-representation-moderate-movers" "plot white-men-representation-moderate-movers"
"White Men Laggards" 1.0 0 -13345367 true "plot white-men-representation-laggards" "plot white-men-representation-laggards"
"Latino Men Diversity Leaders" 1.0 0 -13840069 true "plot latino-men-representation-diversity-leaders" "plot latino-men-representation-diversity-leaders"
"Latino Men Fast Movers" 1.0 0 -13840069 true "plot latino-men-representation-fast-movers" "plot latino-men-representation-fast-movers"
"Latino Men Resting on Laurels" 1.0 0 -13840069 true "plot latino-men-representation-resting-on-laurels" "plot latino-men-representation-resting-on-laurels"
"Latino Men Moderate Movers" 1.0 0 -13840069 true "plot latino-men-representation-moderate-movers" "plot latino-men-representation-moderate-movers"
"Latino Men Laggards" 1.0 0 -13840069 true "plot latino-men-representation-laggards" "plot latino-men-representation-laggards"
"Asian Men Diversity Leaders" 1.0 0 -7500403 true "plot asian-men-representation-diversity-leaders" "plot asian-men-representation-diversity-leaders"
"Asian Men Fast Movers" 1.0 0 -7500403 true "plot asian-men-representation-fast-movers" "plot asian-men-representation-fast-movers"
"Asian Men Resting on Laurels" 1.0 0 -7500403 true "plot asian-men-representation-resting-on-laurels" "plot asian-men-representation-resting-on-laurels"
"Asian Men Moderate Movers" 1.0 0 -7500403 true "plot asian-men-representation-moderate-movers" "plot asian-men-representation-moderate-movers"
"Asian Men Laggards" 1.0 0 -7500403 true "plot asian-men-representation-laggards" "plot asian-men-representation-laggards"
"Black Men Diversity Leaders" 1.0 0 -2674135 true "plot black-men-representation-diversity-leaders" "plot black-men-representation-diversity-leaders"
"Black Men Fast Movers" 1.0 0 -2674135 true "plot black-men-representation-fast-movers" "plot black-men-representation-fast-movers"
"Black Men Resting on Laurels" 1.0 0 -2674135 true "plot black-men-representation-resting-on-laurels" "plot black-men-representation-resting-on-laurels"
"Black Men Moderate Movers" 1.0 0 -2674135 true "plot black-men-representation-moderate-movers" "plot black-men-representation-moderate-movers"
"Black Men Laggards" 1.0 0 -2674135 true "plot black-men-representation-laggards" "plot black-men-representation-laggards"
"Other Men Diversity Leaders" 1.0 0 -5825686 true "plot other-men-representation-diversity-leaders" "plot other-men-representation-diversity-leaders"
"Other Men Fast Movers" 1.0 0 -5825686 true "plot other-men-representation-fast-movers" "plot other-men-representation-fast-movers"
"Other Men Resting on Laurels" 1.0 0 -5825686 true "plot other-men-representation-resting-on-laurels" "plot other-men-representation-resting-on-laurels"
"Other Men Moderate Movers" 1.0 0 -5825686 true "plot other-men-representation-moderate-movers" "plot other-men-representation-moderate-movers"
"Other Men Laggards" 1.0 0 -5825686 true "plot other-men-representation-laggards" "plot other-men-representation-laggards"

SWITCH
15
105
187
138
blind-recruitment?
blind-recruitment?
1
1
-1000

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="frontline-team-sim" repetitions="10" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="200"/>
    <metric>white-women-representation-diversity-leaders</metric>
    <metric>white-women-representation-fast-movers</metric>
    <metric>white-women-representation-resting-on-laurels</metric>
    <metric>white-women-representation-moderate-movers</metric>
    <metric>white-women-representation-laggards</metric>
    <metric>latino-women-representation-diversity-leaders</metric>
    <metric>latino-women-representation-fast-movers</metric>
    <metric>latino-women-representation-resting-on-laurels</metric>
    <metric>latino-women-representation-moderate-movers</metric>
    <metric>latino-women-representation-laggards</metric>
    <metric>black-women-representation-diversity-leaders</metric>
    <metric>black-women-representation-fast-movers</metric>
    <metric>black-women-representation-resting-on-laurels</metric>
    <metric>black-women-representation-moderate-movers</metric>
    <metric>black-women-representation-laggards</metric>
    <metric>asian-women-representation-diversity-leaders</metric>
    <metric>asian-women-representation-fast-movers</metric>
    <metric>asian-women-representation-resting-on-laurels</metric>
    <metric>asian-women-representation-moderate-movers</metric>
    <metric>asian-women-representation-laggards</metric>
    <metric>other-women-representation-diversity-leaders</metric>
    <metric>other-women-representation-fast-movers</metric>
    <metric>other-women-representation-resting-on-laurels</metric>
    <metric>other-women-representation-moderate-movers</metric>
    <metric>other-women-representation-laggards</metric>
    <metric>white-men-representation-diversity-leaders</metric>
    <metric>white-men-representation-fast-movers</metric>
    <metric>white-men-representation-resting-on-laurels</metric>
    <metric>white-men-representation-moderate-movers</metric>
    <metric>white-men-representation-laggards</metric>
    <metric>latino-men-representation-diversity-leaders</metric>
    <metric>latino-men-representation-fast-movers</metric>
    <metric>latino-men-representation-resting-on-laurels</metric>
    <metric>latino-men-representation-moderate-movers</metric>
    <metric>latino-men-representation-laggards</metric>
    <metric>black-men-representation-diversity-leaders</metric>
    <metric>black-men-representation-fast-movers</metric>
    <metric>black-men-representation-resting-on-laurels</metric>
    <metric>black-men-representation-moderate-movers</metric>
    <metric>black-men-representation-laggards</metric>
    <metric>asian-men-representation-diversity-leaders</metric>
    <metric>asian-men-representation-fast-movers</metric>
    <metric>asian-men-representation-resting-on-laurels</metric>
    <metric>asian-men-representation-moderate-movers</metric>
    <metric>asian-men-representation-laggards</metric>
    <metric>other-men-representation-diversity-leaders</metric>
    <metric>other-men-representation-fast-movers</metric>
    <metric>other-men-representation-resting-on-laurels</metric>
    <metric>other-men-representation-moderate-movers</metric>
    <metric>other-men-representation-laggards</metric>
    <enumeratedValueSet variable="blind-recruitment?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
1
@#$#@#$#@
