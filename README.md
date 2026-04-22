# Calculadora de Sumas Positivas

# Descripción

Este programa es una calculadora simple que pide dos números al usuario y entrega la suma de ambos. Su objetivo es demostrar el uso de excepciones personalizadas en Racket, que se lanzan cuando el usuario ingresa valores inválidos (como números negativos o entradas que no son números).

# Estructura de los archivos

taller-1-lps/
    src/
       main.rkt   
    README.md      

No se utilizan dependencias externas. El programa usa únicamente las bibliotecas estándar incluidas en la instalación base de Racket.

# Cómo usar el programa

# Ejecución

Desde la raíz del proyecto, ejecutar en terminal:

racket src/main.rkt

Si Racket no está en el PATH del sistema, usar la ruta completa al ejecutable. Por ejemplo, en Windows:

& "C:\Program Files\Racket\Racket.exe" src/main.rkt

# Interacción

El programa solicitará dos números de forma secuencial por terminal:

--- Calculadora de Sumas Positivas ---
Ingrese el primer número: 
Ingrese el segundo número: 

El usuario debe escribir un valor y presionar Enter para cada uno.

# Entradas aceptadas y resultados posibles

Dos números positivos (enteros o decimales) `5` y `3` = `El resultado de la suma es: 8`
Un número negativo (cualquiera de los dos) `-2` y `4` = Error: `NUMERO NEGATIVO`
Una entrada que no es número (texto, símbolo) `hola` y `4` = Error: `TIPO INVÁLIDO`

En los casos de error, el programa muestra el mensaje correspondiente y no se cierra forzosamente: termina de forma controlada después de manejar la excepción.

# Excepciones personalizadas

El programa define y utiliza dos excepciones personalizadas.

# 1. `exn:fail:numero-negativo`

-Nombre = `exn:fail:numero-negativo` 
-Hereda de = `exn:fail` (excepción de fallo estándar de Racket) 
-Componentes = Hereda `message` y `continuation-marks` de `exn:fail` 
-Gatillo = Se lanza cuando al menos uno de los dos números ingresados es menor que cero (`(< a 0)` o `(< b 0)`)
-Objetivo = Impedir que la calculadora opere con números negativos, ya que está diseñada exclusivamente para operandos positivos
-Funcionamiento = Es definida con `struct`, lanzada con `raise` dentro de la función `sumar-positivos`, y capturada con `with-handlers` usando el predicado `exn:fail:numero-negativo?` en la función principal `calculadora`
-Mensaje = `"Error: No se permiten números negativos en esta calculadora."`

# 2. `exn:fail:tipo-invalido`

-Nombre = `exn:fail:tipo-invalido` 
-Hereda de = `exn:fail` (excepción de fallo estándar de Racket) 
-Componentes = Hereda `message` y `continuation-marks` de `exn:fail` 
-Gatillo = Se lanza cuando al menos uno de los valores ingresados no es un número, evaluado con `(not (and (number? a) (number? b)))` 
-Objetivo = Garantizar que la operación de suma solo se realice con valores numéricos válidos |
-Funcionamiento = Es definida con `struct`, lanzada con `raise` dentro de la función `sumar-positivos`, y capturada con `with-handlers` usando el predicado `exn:fail:tipo-invalido?` en la función principal `calculadora`. Esta validación se realiza antes de la validación de negativos 
-Mensaje = `"Error: Se detectó una entrada que no es un número."` 

# Flujo de manejo de excepciones
```
calculadora()
    sumar-positivos(a, b)
        ¿a o b no es número?  =  raise exn:fail:tipo-invalido
        ¿a o b es negativo?   =  raise exn:fail:numero-negativo
        caso normal           =  retorna (+ a b)
    with-handlers captura la excepción y muestra el mensaje de error
```