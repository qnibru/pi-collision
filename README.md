# pi-collision
This program has been made in lua with the framework Love2D. It computes pi decimals with the collision of 2 cubes.
Watch this video to understand :
https://youtu.be/HEfHFsfGXjs

----------------------------

Petit programme en lua et Love2D qui compte les décimales de pi avec les collisions de 2 cubes. 
Totalement inspiré par cette vidéo : 
https://youtu.be/HEfHFsfGXjs

À chaque clack entendu, on ajoute +1 à un compteur.
Quand les 2 cubes ne peuvent plus collisioner, le compteur affichera "3,14...".

Le nombre de collisions, et donc de décimales dépend de la masse du gros cube (qui doit être une puissance de 100). Le nombre de décimales est égal à la puissance de 100 qu'on choisit. Par exmeple, pour trouver 3 décimales, on mettra la masse du cube à 100^3.
On considère la collision "élastique" (https://en.wikipedia.org/wiki/Elastic_collision), donc qu'il n'y a aucune perte d'énergie, comme par exemple de la friction avec le sol ou l'air.

La formule qui correspond aux vitesses des 2 cubes après collision est la suivante :

v1 = ((m1-m2) / m1+m2 * u1) + (2*m2 / m1+m2 * u2)

et 

v2 = (2*m1 / m1+m2 * u1) + ((m2-m1) / m1+m2 * u2)

Avec :
  - m1 et m2 les masses des 2 cubes
  - u1 et u2 leur vitesse avant collision
  - v1 et v2 leur vitesse après collision
