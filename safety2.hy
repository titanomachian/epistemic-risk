(setv worlds
  [{"id" "actual"      "p" True  "believes-p" True  "belief-form-same-as-actual" True  "closeness" 0}
   {"id" "near1"       "p" True  "believes-p" True  "belief-form-same-as-actual" True  "closeness" 1}
   {"id" "near2"       "p" False "believes-p" True  "belief-form-same-as-actual" False "closeness" 1} ;; Uh oh, a lucky true belief!
   {"id" "far1"        "p" False "believes-p" False "belief-form-same-as-actual" False "closeness" 10}])

(defn safe-world? [world]
  (and (= (get world "believes-p") True)
       (= (get world "p") True)
       (= (get world "belief-form-same-as-actual") True)))

(setv safe-nearby-worlds
  (list
    (gfor w worlds
          :if (<= (get w "closeness") 1)
          :if (safe-world? w)
          (get w "id"))))

(print safe-nearby-worlds)
