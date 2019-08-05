# VowelOnset.praat
# by Lisa Chang 2019.8.5

form Get durations of files
    sentence inputdir Type directory here
    sentence outputdir Type directory+filename here	
endform

headline$ = "'Filename' 'tab$' 'vowel onset time (s)'"
writeInfoLine: headline$
writeFileLine: outputdir$, headline$
strings = Create Strings as file list: "Filelist", inputdir$ + "/*.wav"
numberOfFiles = Get number of strings
for ifile to numberOfFiles
    selectObject: strings
    fileName$ = Get string: ifile
    Read from file: inputdir$ + "/" + fileName$ - "wav" + "TextGrid"
    vowel_onset = Get start time of interval: 1, 2
    resultline$ = "'fileName$' 'tab$' 'vowel_onset'"
    appendInfoLine: resultline$
    appendFileLine: outputdir$, resultline$
    Remove
endfor

appendInfoLine: "Done."
select all
Remove