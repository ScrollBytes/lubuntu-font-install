#!/bin/bash


## current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

## OVERALL LOOP CHECKING FOR A ZIP FOLDER, A TTF FILE OR AN OTF FILE each time it loops

## this allows for-loop to process spaces in filenames - without this whole script will break at spaces.
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
## END - this allows for-loop to process spaces in filenames - without this whole script will break at spaces.

FILES="$DIR/*"
for f in $FILES
do

	## if its a ZIP folder of fonts
	if [[ $f == *".zip"* ]]
	then
	  
	    ## split filename into filename and extension
	    zipfilename=$(basename "$f")
	    zipextension="${zipfilename##*.}"
	    zipfilename="${zipfilename%.*}"

	  
	    echo "----------------"
		echo "Working on ZIP folder - "$zipfilename"."$zipextension" ..."
		echo "----------------"
		
		FOLDERNAME=${zipfilename//[^a-zA-Z0-9]/}
		FOLDERNAME=${FOLDERNAME// /}
		
		## create folder with same name as zip folder, but cleaned
		mkdir -p ""$DIR"/"$FOLDERNAME""
		
		
		## move zip to that folder
		mv ""$DIR"/"$zipfilename"."$zipextension"" ""$DIR"/"$FOLDERNAME""
		
		
		## unzip within that folder
		unzip ""$DIR"/"$FOLDERNAME"/"$zipfilename"."$zipextension"" -d ""$DIR"/"$FOLDERNAME""
				
				
				
				## FIND AND INSTALL TTF FILES - IF THEY EXIST
				
				## for each file in newly created folder with unzipped contents, recursive through all directories in that folder
				for ttfonlyfile in $(find ""$DIR"/"$FOLDERNAME"" -name '*.ttf' -or -name '*.TTF'); 
				do 
					
					echo "${ttfonlyfile}"
					fontfilename=$(basename ""${ttfonlyfile}"")
					fontextension="${fontfilename##*.}"
					fontfilename="${fontfilename%.*}"
					
					NEWFONTNAME=${fontfilename//[^a-zA-Z0-9]/}
					NEWFONTNAME=${NEWFONTNAME// /}
					
					mv ""$DIR"/"$FOLDERNAME"/"$fontfilename"."$fontextension"" ""$DIR"/"$FOLDERNAME"/"$NEWFONTNAME"."$fontextension""
					
					ttffontpath=""$DIR"/"$FOLDERNAME"/"$NEWFONTNAME"."$fontextension""
					
					## add ttf fonts to array, if any.
					ttfinzip+=(''$ttffontpath'') ## double (') as it is a variable, else use single (') 
				
				done
				
				
				## If there are TTF fonts found then create lubuntu font folder and move fonts to that
				if [ ${#ttfinzip[@]} -eq 0 ]; then
					echo "----------------"
					echo "No TTF fonts found in zip folder."
					echo "----------------"
				else
					
					echo "----------------"
					echo ""${#ttfinzip[@]}" TTF fonts found!"
					echo "----------------"
					
					## make font directory in Lubuntu fonts folder
					echo "Creating Lubuntu font folder, need your password:"
					sudo mkdir -p "/usr/share/fonts/truetype/"$FOLDERNAME""
					
					echo "----------------"
					echo "Copying fonts to folder ... /usr/share/fonts/truetype/"$FOLDERNAME" ..."
					echo "----------------"
					
					## loop ttf font array items
					for ttfitem in "${ttfinzip[@]}"
					do
					   :
					   # do whatever on $ttfitem
					   
					   ## move fonts to newly created lubuntu font folder
					   sudo mv "$ttfitem" "/usr/share/fonts/truetype/"$FOLDERNAME""
					   
					done
					## end loop
				
				fi ## end font amount check
				
				
				## END - FIND AND INSTALL TTF FILES - IF THEY EXIST
				
				
				
				
				
				
				
				
				
				
				
				## FIND AND INSTALL OTF FILES - IF THEY EXIST
				
				
				## for each file in newly created folder with unzipped contents, recursive through all directories in that folder
				for otfonlyfile in $(find ""$DIR"/"$FOLDERNAME"" -name '*.otf' -or -name '*.OTF'); 
				do 
					
					## echo $otfonlyfile;
					
					fontfilename=$(basename "$otfonlyfile")
					fontextension="${fontfilename##*.}"
					fontfilename="${fontfilename%.*}"
					
					NEWFONTNAME=${fontfilename//[^a-zA-Z0-9]/}
					NEWFONTNAME=${NEWFONTNAME// /}
					
					mv ""$DIR"/"$FOLDERNAME"/"$fontfilename"."$fontextension"" ""$DIR"/"$FOLDERNAME"/"$NEWFONTNAME"."$fontextension""
					
					otffontpath=""$DIR"/"$FOLDERNAME"/"$NEWFONTNAME"."$fontextension""
					
					
					
					## add otf fonts path to array, if any.
					otfinzip+=(''$otffontpath'') ## double (') as it is a variable, else use single (') 
				
				done
				
				
				## If there are TTF fonts found then create lubuntu font folder and move fonts to that
				if [ ${#otfinzip[@]} -eq 0 ]; then
					echo "----------------"
					echo "No OTF fonts found in zip folder."
					echo "----------------"
				else
					
					echo "----------------"
					echo ""${#otfinzip[@]}" OTF fonts found!"
					echo "----------------"
					
					## make font directory in Lubuntu fonts folder
					echo "Creating Lubuntu font folder, need your password:"
					sudo mkdir -p "/usr/share/fonts/opentype/"$FOLDERNAME""
					
					echo "----------------"
					echo "Copying fonts to folder ... /usr/share/fonts/opentype/"$FOLDERNAME" ..."
					echo "----------------"
					
					## loop ttf font array items
					for otfitem in "${otfinzip[@]}"
					do
					   :
					   # do whatever on $otfitem
					   
					   ## move fonts to newly created lubuntu font folder
					   sudo mv "$otfitem" "/usr/share/fonts/opentype/"$FOLDERNAME""
					   
					done
					## end loop
				
				fi ## end font amount check
				
				
				
				## END - FIND AND INSTALL OTF FILES - IF THEY EXIST
				
				
				
				## FINALLY - DELETE both arrays - VERY IMPORTANT
				unset ttfinzip
				unset otfinzip
				## end - clear both arrays
				
		
	  
		fi ## end - if it is zip folder








done
## end - OVERALL LOOP CHECKING FOR A ZIP FOLDER, A TTF FILE OR AN OTF FILE each time it loops



# restore $IFS - had changed it above to allow for-loop to process spaces in filenames - without this whole script will break at spaces.
IFS=$SAVEIFS
# end - restore $IFS


## after the loop completes ...




## Update font cache
echo "----------------"
echo "Updating font cache ..."
echo "----------------"
sudo fc-cache -f -v
echo "Font cache update complete."


## Move COMPLETED unzipped font folder to separate folder here
## make --installed-fonts-- folder if it does not exist
mkdir -p ""$DIR"/installed-fonts"
## move whole completed folder to it
mv ""$DIR"/"$FOLDERNAME"" ""$DIR"/installed-fonts"



## Finished
echo "----------------"
echo "Finished! You may need to restart currently open programs for new fonts to show up."
echo "----------------"
