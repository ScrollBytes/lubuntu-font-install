#!/bin/bash


## unzip "/home/username/Projects/LUBUNTU-FONT-INSTALLER/biorhyme.zip" -d "/home/username/Projects/LUBUNTU-FONT-INSTALLER/"


currentdate=$(date +"%m-%d-%y")
currenttime=$(date +"%H-%M-%S")
binfoldername="$currentdate-$currenttime"


## current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


## OVERALL LOOP CHECKING FOR A ZIP FOLDER, A TTF FILE OR AN OTF FILE each time it loops
FILES="$DIR/*"
for f in $FILES
do

	## echo "Ignoring $f file..."
  
  
  
	## if its a TTF font file
	if [[ $f == *".ttf"* ]] || [[ $f == *".TTF"* ]]
	then
	  
	  ## split filename into filename and extension
	  filename=$(basename "$f")
	  extension="${filename##*.}"
	  filename="${filename%.*}"
	  
	  # first, strip underscores
	  CLEAN=${filename//_/}
	  # next, replace spaces with underscores
	  CLEAN=${filename// /_}
	  # now, clean out anything that's not alphanumeric or an underscore
	  CLEAN=${filename//[^a-zA-Z0-9_]/}
	  # finally, lowercase with TR
	  CLEANFILENAME=`echo -n $CLEAN | tr A-Z a-z`
	  
	  echo "----------------"
	  echo "Working on "$filename"."$extension" - TTF font file..."
	  echo "----------------"
	  
	  echo $CLEANFILENAME
	  echo $extension
	  
	  ## create folder with same name as ttf file, but cleaned
	  mkdir -p "$DIR/$CLEANFILENAME"
	  
	  ## make font directory in Lubuntu fonts folder
	  echo "Creating Lubuntu font folder, need your password:"
	  sudo mkdir -p "/usr/share/fonts/truetype/$CLEANFILENAME"
	  
	  echo "----------------"				
	  echo "Copying "$filename"."$extension" font to folder ..."
	  echo "----------------"
	  
	  ## move fonts to newly created lubuntu font folder
	  sudo mv "$DIR/$CLEANFILENAME/"$filename"."$extension"" "/usr/share/fonts/truetype/$CLEANFILENAME"
	  
	  
	fi
	
	
	
	
	
	
	
	
	
	
	
	
	
	## if its an OTF font file
	if [[ $f == *".otf"* ]] || [[ $f == *".OTF"* ]]
	then
	
		## split filename into filename and extension
	    filename=$(basename "$f")
	    extension="${filename##*.}"
	    filename="${filename%.*}"
	  
	    # first, strip underscores
	    CLEAN=${filename//_/}
	    # next, replace spaces with underscores
	    CLEAN=${filename// /_}
	    # now, clean out anything that's not alphanumeric or an underscore
	    CLEAN=${filename//[^a-zA-Z0-9_]/}
	    # finally, lowercase with TR
	    CLEANFILENAME=`echo -n $CLEAN | tr A-Z a-z`
	  
	    echo "----------------"
	    echo "Working on "$filename"."$extension" - OTF font file..."
	    echo "----------------"
	  
	    echo $CLEANFILENAME
	    echo $extension
	  
	    ## create folder with same name as ttf file, but cleaned
	    mkdir -p "$DIR/$CLEANFILENAME"
	  
	    ## make font directory in Lubuntu fonts folder
	    echo "Creating Lubuntu font folder, need your password:"
	    sudo mkdir -p "/usr/share/fonts/opentype/$CLEANFILENAME"
		
		echo "----------------"			
	    echo "Copying "$filename"."$extension" font to folder ..."
		echo "----------------"
	  
	    ## move fonts to newly created lubuntu font folder
	    sudo mv "$DIR/$CLEANFILENAME/"$filename"."$extension"" "/usr/share/fonts/opentype/$CLEANFILENAME"
	  
	  
	fi
















	## if its a ZIP folder of fonts
	if [[ $f == *".zip"* ]]
	then
	  
		## split filename into filename and extension
	    filename=$(basename "$f")
	    extension="${filename##*.}"
	    filename="${filename%.*}"
	    
	    # first, strip underscores
	    CLEAN=${filename//_/}
	    # next, replace spaces with underscores
	    CLEAN=${filename// /_}
	    # now, clean out anything that's not alphanumeric or an underscore
	    CLEAN=${filename//[^a-zA-Z0-9_]/}
	    # finally, lowercase with TR
	    CLEANFILENAME=`echo -n $CLEAN | tr A-Z a-z`
	  
	    echo "----------------"
		echo "Working on ZIP folder - "$filename"."$extension" ..."
		echo "----------------"
		
		## create folder with same name as zip folder, but cleaned
		mkdir -p "$DIR/$CLEANFILENAME"
		
		## move zip to that folder
		mv "$f" "$DIR/$CLEANFILENAME"
		
		## unzip to that folder
		unzip "$DIR/$CLEANFILENAME/"$filename"."$extension"" -d "$DIR/$CLEANFILENAME"
		echo "Unzipped contents of "$filename"."$extension" to "$CLEANFILENAME" folder"
				
				
				## FIND AND INSTALL TTF FILES - IF THEY EXIST
				
				## for each file in newly created folder with unzipped contents, recursive through all directories in that folder
				for ttfonlyfile in $(find $DIR/$CLEANFILENAME -name '*.ttf' -or -name '*.TTF'); 
				do 
					
					## echo $ttfonlyfile;
					
					## add ttf fonts to array, if any.
					ttfinzip+=(''$ttfonlyfile'') ## double (') as it is a variable, else use single (') 
				
				done
				
				
				## If there are TTF fonts found then create lubuntu font folder and move fonts to that
				if [ ${#ttfinzip[@]} -eq 0 ]; then
					echo "No TTF fonts found in zip folder."
				else
					
					echo "----------------"
					echo ""${#ttfinzip[@]}" TTF fonts found!"
					echo "----------------"
					
					## make font directory in Lubuntu fonts folder
					echo "Creating Lubuntu font folder, need your password:"
					sudo mkdir -p "/usr/share/fonts/truetype/$CLEANFILENAME"
					
					echo "----------------"
					echo "Copying fonts to folder ..."
					echo "----------------"
					
					## loop ttf font array items
					for ttfitem in "${ttfinzip[@]}"
					do
					   :
					   # do whatever on $ttfitem
					   
					   ## move fonts to newly created lubuntu font folder
					   sudo mv "$ttfitem" "/usr/share/fonts/truetype/$CLEANFILENAME"
					   
					done
					## end loop
				
				fi ## end font amount check
				
				
				## END - FIND AND INSTALL TTF FILES - IF THEY EXIST
				
				
				
				
				
				
				
				
				
				
				
				## FIND AND INSTALL OTF FILES - IF THEY EXIST
				
				
				## for each file in newly created folder with unzipped contents, recursive through all directories in that folder
				for otfonlyfile in $(find $DIR/$CLEANFILENAME -name '*.otf' -or -name '*.OTF'); 
				do 
					
					## echo $otfonlyfile;
					
					## add otf fonts path to array, if any.
					otfinzip+=(''$otfonlyfile'') ## double (') as it is a variable, else use single (') 
				
				done
				
				
				## If there are TTF fonts found then create lubuntu font folder and move fonts to that
				if [ ${#otfinzip[@]} -eq 0 ]; then
					echo "No OTF fonts found in zip folder."
				else
					
					echo "----------------"
					echo ""${#otfinzip[@]}" OTF fonts found!"
					echo "----------------"
					
					## make font directory in Lubuntu fonts folder
					echo "Creating Lubuntu font folder, need your password:"
					sudo mkdir -p "/usr/share/fonts/opentype/$CLEANFILENAME"
					
					echo "----------------"
					echo "Copying fonts to folder ..."
					echo "----------------"
					
					## loop ttf font array items
					for otfitem in "${otfinzip[@]}"
					do
					   :
					   # do whatever on $otfitem
					   
					   ## move fonts to newly created lubuntu font folder
					   sudo mv "$otfitem" "/usr/share/fonts/opentype/$CLEANFILENAME"
					   
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






## after the loop completes ...




## Update font cache
echo "----------------"
echo "Updating font cache ..."
echo "----------------"
sudo fc-cache -f -v
echo "Font cache update complete."


## Finished
echo "----------------"
echo "Finished! You may need to restart currently open programs for new fonts to show up."
echo "----------------"
