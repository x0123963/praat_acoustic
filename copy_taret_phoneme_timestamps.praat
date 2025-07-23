# CueRSA
# Copy timestamps of target phonemes to a new TextGrid
# Praat version 6.4.39
# (for subsequent acoustic analysis)
# Lisa Chang 2025.07.22

form: "Copy timestamps to a new TextGrid"
	sentence: "inputdir", "E:/ds004408/stimuli/"
	folder: "outputdir", "targetTextGrid"
	word: "target", "L"
endform

# Loop through stimuli
strings = Create Strings as file list: "Filelist", inputdir$ + "*.wav"
numberOfFiles = Get number of strings
for iFile to 2
	selectObject: strings
	wavName$ = Get string: iFile
	fileName$ = left$(wavName$,length(wavName$)-4)
	Read from file: inputdir$ + wavName$
	Read from file: inputdir$ + fileName$ + ".TextGrid"
	
	# Create a new TextGrid
	selectObject: "TextGrid " + fileName$
	Copy: fileName$ + "_target"
	Duplicate tier: 1, 3, target$

	# Loop through intervals to search for the target
	# Retain their timestamps along with their index
	# Erase others
	numberOfIntervals = Get number of intervals: 1
	for iInterval to numberOfIntervals
		iInterval$ = string$: iInterval
		current$ = Get label of interval: 1, iInterval
		if current$ = target$
			Set interval text: 3, iInterval, target$+"_"+iInterval$
		else
			Set interval text: 3, iInterval, ""
		endif
	endfor
	Remove tier: 1
endfor