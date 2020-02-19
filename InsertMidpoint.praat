#Insert midpoint
#Lisa Chang 2019.11.22
#Insert the midpoint of the second interval at the second tier

form Where is your TextGrid files?
	sentence directory Type directory here
endform

strings = Create Strings as file list: "Filelist", directory$ + "\*.TextGrid"
numberOfFiles = Get number of strings

for ifile to numberOfFiles
	selectObject: strings
	fileName$ = Get string: ifile
	Read from file: directory$ + "\" + fileName$
	start = Get start time of interval: 1, 2
	end = Get end time of interval: 1, 2
	midpoint = (end+start)/2
	Insert point: 2, midpoint, "mid"
	Save as text file: directory$ + "\" + fileName$
	Remove
endfor

writeInfoLine: "Done."
select all
Remove