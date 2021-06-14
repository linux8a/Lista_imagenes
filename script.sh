#!/bin/sh 
fecha=`date`
echo "# Lista de imagenes docker con sus tags" > README.md
echo "Actualizado: $fecha" >> README.md
for image in $(curl -L -s 'https://registry.hub.docker.com/v2/repositories/library/?page_size=2049'|jq '."results"[]["name"]' |sed 's/"//g');do
  echo "## $image" >> README.md
  echo "<details>" >> README.md
  echo "<summary> $image </summary>\n" >> README.md
  echo '```sh'>> README.md
        for tag in $(curl -L -s https://registry.hub.docker.com/v2/repositories/library/$image/tags/|jq '."results"[]["name"]' | sed 's/"//g');do
                
        echo "$image:$tag" >> README.md
                 
        done
  echo '```'>> README.md
  echo "</details>" >> README.md
  echo "\n" >> README.md
done

