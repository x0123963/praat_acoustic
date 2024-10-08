# Measuring Harmonicity
# Lisa Chang September 6, 2024

Read Table from tab-separated file: "C:\Users\USER\OneDrive\桌面\onset.txt"
soundDir$ = "E:\PhonoVio\behavioral\"
outputDir$ = "C:\Users\USER\OneDrive\桌面\harmonicity.txt"
selectObject: "Table onset"

# Prepare for the result table
headline$ = "Filename" + tab$ + "HNR (dB)"
writeFileLine: outputDir$, headline$

numberofRows = Get number of rows
for r to numberofRows
	selectObject: "Table onset"
	fname$ = Get value: r, "NAME"
	
	# skip the singular items
	break = index_regex (fname$, "_")
	if mid$(fname$ , break-3, 3) == "Sin" and not mid$(fname$ , break+3, 1) == "C"
		value$ = "NA"
		resultline$ = "'fname$' 'tab$' 'value$'"
		appendFileLine: outputDir$, resultline$
	else
		sound = Read from file: soundDir$+fname$+".wav"
		selectObject: "Table onset"
		start = Get value: r, "fricative_onset"
		select sound
		end = Get total duration
		part = Extract part: start, end, "rectangular", 1, 0
		To Harmonicity (cc): 0.01, 75, 0.1, 1
		value = Get mean: 0, 0
		resultline$ = "'fname$' 'tab$' 'value'"
		appendFileLine: outputDir$, resultline$
		select all
		minusObject: "Table onset"
		Remove
	endif
endfor

writeInfoLine: "Done!"
