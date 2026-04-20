#lang racket

(struct exn:fail:numero-negativo exn:fail ())
(struct exn:fail:tipo-invalido exn:fail ())

(define (sumar-positivos a b)
  (cond
    [(not (and (number? a) (number? b)))
      (raise (exn:fail:tipo-invalido 
        "Error: Se detectó una entrada que no es un número." 
        (current-continuation-marks))
      )
    ]
    [(or (< a 0) (< b 0))
      (raise (exn:fail:numero-negativo 
        "Error: No se permiten números negativos en esta calculadora." 
        (current-continuation-marks))
      )
    ]
    [else (+ a b)]
  )
)

(define (calculadora)
  (displayln "--- Calculadora de Sumas Positivas ---")
  (display "Ingrese el primer número: ")
  (define input1 (read))
  (display "Ingrese el segundo número: ")
  (define input2 (read))

  (with-handlers 
      (
        [exn:fail:numero-negativo?
          (lambda (exn)
            (printf "NUMERO NEGATIVO: ~a\n" (exn-message exn))
          )
        ]
      
        [exn:fail:tipo-invalido? 
          (lambda (exn)
            (printf "TIPO INVÁLIDO: ~a\n" (exn-message exn))
          )
        ]
      )

    (let ([resultado (sumar-positivos input1 input2)])
      (printf "El resultado de la suma es: ~a\n" resultado)
      (displayln "Operación completada con éxito.")
    )
  )
)  

(calculadora)