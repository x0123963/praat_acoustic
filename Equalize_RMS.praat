# Modify RMS to match neighboring sounds
# Lisa Chang 2023.01.04
# Adapted from Huiwen Goy (June 2012)

form Equalize RMS levels
comment Original soundfiles
sentence Directory C:\Users\USER\Praat
comment Save new files to
sentence Newdirectory C:\Users\USER\
comment Append suffix
sentence Suffix _equalRMS
comment label of the interval to be changed
sentence Label1 rel
comment label of the target RMS
sentence Label2 rest
endform

Create Strings as file list... list 'directory$'/*.wav
number_of_files = Get number of strings

for ifile to number_of_files
	# load .wav and .TextGrid files
	select Strings list
	current_file$ = Get string... ifile
	sound = Read from file... 'directory$'/'current_file$'
	filename$ = left$(current_file$, length(current_file$)-4)
	grid_file$ = filename$+".TextGrid"
	grid = Read from file... 'directory$'/'grid_file$'
	writeInfoLine: filename$

	# Get intervals of original and target RMS
	number_of_intervals = Get number of intervals... 3
	for iinterval to number_of_intervals
		name$ = Get label of interval... 3 iinterval
		if name$ = label1$
			index1 = iinterval
			original_start_time = Get start time of interval...  3 index1
			original_end_time = Get end time of interval... 3 index1
			select sound
			original_RMS = Get root-mean-square... original_start_time original_end_time
			appendInfoLine: "Original RMS: ", original_RMS
			select grid
		endif
		if name$ = label2$
			index2 = iinterval
			target_start_time = Get start time of interval... 3 index2
			target_end_time = Get end time of interval... 3 index2
			select sound
			target_RMS = Get root-mean-square... target_start_time target_end_time
			appendInfoLine: "New RMS: ", target_RMS
			select grid
		endif
	endfor

	# Change the RMS
	select sound
	Formula (part)... original_start_time original_end_time 1 1 self * target_RMS/original_RMS
	newfilename$ = "'filename$'" + "'suffix$'"
	Write to WAV file... 'newdirectory$'/'newfilename$'.wav
endfor
			