# GetDuration.praat
# by Lisa Chang 2018.8.7

form Get durations of files
    sentence inputdir Type directory here
    sentence outputdir Type directory+filename here	
endform

headline$ = "'Filename' 'tab$' 'Duration (s)'"
writeInfoLine: headline$
writeFileLine: outputdir$, headline$
strings = Create Strings as file list: "Filelist", inputdir$ + "/*.wav"
numberOfFiles = Get number of strings
for ifile to numberOfFiles
    selectObject: strings
    fileName$ = Get string: ifile
    Read from file: inputdir$ + "/" + fileName$
    dur = Get total duration
    resultline$ = "'fileName$' 'tab$' 'dur'"
    appendInfoLine: resultline$
    appendFileLine: outputdir$, resultline$
    Remove
endfor

appendInfoLine: "Done."
select all
Remove
