# Servicios profesionales

En este ejercicio, se nos pide modelar empresas que ofrecen los servicios de profesionales que tienen contratados, a distintos tipos de solicitantes.


## Etapa 1 - profesionales y empresas

De cada **profesional** se debe poder obtener:
- en qué _universidad_ estudiaron, esto se debe asignar para cada profesional.
- sus _honorarios por hora_ de trabajo, cómo se determina depende del tipo de profesional.
- en qué _provincias_ puede trabajar, cómo se determina depende del tipo de profesional.

De cada **universidad** nos va a interesar: en qué provincia está, y qué honorarios por hora de trabajo recomienda para los profesionales.

Deben contemplarse distintos tipos de profesionales, de acuerdo a lo que se indica a continuación.
- **Profesionales vinculados a una universidad**:  
  pueden trabajar solamente en la provincia donde está la universidad, los honorarios son los que recomienda la universidad.
- **Profesionales asociados del Litoral**:
  pueden trabajar en Entre Ríos, Santa Fe y Corrientes, cobran 3000 pesos por hora de trabajo.
- **Profesionales libres**:
  se indica para cada uno en qué provincias pueden trabajar y los honorarios por hora, además de la universidad.
  
  
Cada **empresa de servicios** contrata a varios profesionales. Para cada una se indica un honorario de referencia.

A partir de este modelo, tiene que poder obtenerse para una empresa:
- el conjunto formado por sus _profesionales caros_.   
  O sea, aquellos cuyo honorario es mayor al honorario de referencia de la empresa.
- el conjunto de las _universidades formadoras_, o sea, las universidades donde estudiaron sus profesionales contratados, sin repetidos.
- el profesional _más barato_ (o sea, que sus honorarios son los más bajos).
- si una determinada _provincia está cubierta_ (o sea, que haya al menos un profesional que pueda trabajar en ella).
- cuántos (un número) de sus profesionales contratados estudió en una determinada universidad.
- **esta es más difícil**  
  dado un profesional, si es _poco atractivo_ para la empresa.  
  Esto es: si para cada provincia en la que puede trabajar el profesional, la empresa cuenta con otro que también puede cubrir esa provincia, y que cobra más barato. 


### Comentario que puede ayudar para la resolución  
Cada universidad debe acordarse provincia y honorarios recomendados, se le setean y listo.  
Por otro lado, _está mal_ que los profesionales vinculados se acuerden de qué provincias tienen habilitadas y cuáles son sus honorarios; le tienen que pedir estos datos a la Universidad.
  
De paso: **OJO** que la Universidad está en _una_ provincia, pero el profesional tiene que devolver una _colección_ de provincias. Un profesional vinculado devolverá una colección con un solo elemento.

<br>


## Test de la etapa 1

Tenemos estas universidades:
- de San Martín: está en la provincia de Buenos Aires, los honorarios recomendados son de 3500 pesos.
- de Rosario: está en la provincia de Santa Fe, los honorarios recomendados son de 2800 pesos.
- de Corrientes: está en la provincia de Corrientes, los honorarios recomendados son de 4200 pesos.
- de Hurlingham: está en la provincia de Buenos Aires, los honorarios recomendados son de 8800 pesos.

y estos profesionales
- Juana, vinculada, estudió en la Univ. de Rosario.
- Melina, asociada el Litoral, estudió en la Univ. de Corrientes.
- Rocío, libre, estudió en la Univ. de Hurlingham, honorarios 5000 pesos, puede trabajar en Santa Fe, Córdoba y Buenos Aires.
- Luciana, libre, estudió en la Univ. de Rosario, honorarios 3200 pesos, puede trabajar en Santa Fe y Entre Ríos.

Una empresa que contrate a estos cuatro profesionales, y cuyos honorarios de referencia son 3500 pesos, debe tener
- como _profesionales caros_, solamente a Rocío.
- como _universidades formadoras_, a las de Rosario, Corrientes y Hurlingham.
- como _profesional más barato_ a Juana.
- las provincias de Santa Fe y Córdoba están cubiertas, pero Misiones no.
- dos de sus profesionales estudiaron en Rosario, uno en Hurlingham, ninguno (o sea cero) en San Martín.  

Hacer los tests que sean necesarios para verificar esto. Se puede usar `fixture` para definir información que se usa en varios tests dentro de un _describe file_.

<br>

## Etapa 2 - cobros

Agregar al modelo la consecuencia de que un profesional cobre un importe de dinero, de acuerdo a estas reglas:
- los **profesionales vinculados** le donan la mitad a la universidad, y la otra mitad la gastan inmediatamente sin que quede registro en la aplicación. Hay que mantener el total recibido por donaciones de cada universidad.
- los **profesionales asociados** le dan todo lo que cobran a la _Asociación de Profesionales del Litoral_. Agregar un objeto que represente a esta Asociación, que mantiene el total recaudado.
- los **profesionales libres** se guardan todo lo que cobran. Debe mantenerse el total recaudado por cada uno. <br> Un profesional libre le puede _pasar_ una cantidad X de dinero a otro: se resta X del total recaudado, y el otro cobra X. P.ej. si `ruben` tiene 10000 de total recaudado, `nora` tiene 12000, y hacemos
  ```
  nora.pasarDinero(ruben,4000)
  ```
  entonces `nora` pasa a tener 8000, y `ruben` 14000 (porque cobró 4000).


<br>

## Etapa 3 - solicitantes

Los **solicitantes** pueden ser personas o instituciones. Nos interesa saber para cada solicitante si puede (o no) ser _atendido por un profesional_.  

De cada **persona** se debe indicar en qué provincia vive. Puede ser atendida por los profesionales que pueden trabajar en la provncia donde vive la persona.
Cada **institución** tiene una lista de universidades que reconoce. Puede ser atendida por los profesionales que estudiaron en alguna de las universidades reconocidas por la institución.

A una empresa se le tiene que poder preguntar si puede _satisfacer_ a un solicitante.
La condición para esto es que el solicitante pueda ser atendido por, al menos, uno de los profesionales contratados por la empresa. 


## Etapa 4 - registro de trabajos hechos
Agregar al modelo el registro de cada trabajo que una empresa de servicios hace para un determinado solicitante.
Para esto, agregarle a los objetos que representan empresas la capacidad de entender el mensaje `darServicio`. P.ej. si `laMejor` es una empresa y `mirna` una solicitante, entonces haciendo
```
laMejor.darServicio(mirna)
```
se indica que se le está dando a Mirna un servicio. Se asume que cada servicio insume una hora de tiempo de un profesional.
Debe pasar lo siguiente:
- si el solicitante puede ser atendido (etapa 3), entonces elegir uno cualquiera de los profesionales que puede atenderlo, hacer que ese profesional cobre (etapa 2) su honorario por hora (etapa 1), y agregar al solicitante al conjunto de _clientes_ de la empresa.
- caso contrario, lanzar un error.
  
Agregar la posibilidad de preguntarle a una empresa de servicios: cuántos clientes tiene, y si tiene o no como cliente a un determinado solicitante. 








