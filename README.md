# pi-collision
Petit programme en lua et Love2D qui compte les décimales de pi avec les collisions de 2 cubes. 
Totalement inspiré par cette vidéo : youtu.be/HEfHFsfGXjs

À chaque clack entendu, on ajoute +1 à un compteur.
Quand les 2 cubes ne peuvent plus collisioner, le compteur affichera "3,14...".

Le nombre de collisions, et donc de décimales dépend de la masse du gros cube. Plus elle est importante, plus son inertie augmentera.
On considère la collision "élastique" (https://en.wikipedia.org/wiki/Elastic_collision), donc qu'il n'y a aucune perte d'énergie, comme par exemple de la friction avec le sol ou l'air.

La formule qui correspond aux vitesses des 2 cubes après collision est la suivante :

v1 = ((m1-m2) / m1+m2 * u1) + (2*m2 / m1+m2 * u2)

et 

v2 = (2*m1 / m1+m2 * u1) + ((m2-m1) / m1+m2 * u2)

Avec :
  - m1 et m2 les masses des 2 cubes
  - u1 et u2 leur vitesse avant collision
  - v1 et v2 leur vitesse après collision
