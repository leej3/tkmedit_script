# tkmedit_surfposn_makeimages.tcl

set subject    [GetSubjectName 0]
#set subjectdir [GetSubjectDir  0]  # FS bug -- this returns path to main volume, not SubjectDir

global env
set subjectsdir $env(SUBJECTS_DIR)
set subjectdir "${subjectsdir}/${subject}"

set    imagedir $env(screencapdir)

puts "Subject    : $subject"
puts "Subject Dir: $subjectdir"

#----------------------------------
# Notes
#----------------------------------
# 0 Main vertices 
# 1 Inflated vertices 
# 2 White vertices 
# 3 Pial vertices 
# 4 Orig vertices 

#-------------------------------------
# Load T1.mgz to main volume -- already done by original shell command

#-------------------------------------
# Load surfaces:
# 
#LoadMainSurface [0=main; 1=Aux] [filename] 

puts "Load main surfaces"
LoadMainSurface      0 lh.white
LoadPialSurface      0 lh.pial
LoadOriginalSurface  0 lh.orig

puts "Load aux surfaces"
LoadMainSurface      1 rh.white
LoadPialSurface      1 rh.pial
LoadOriginalSurface  1 rh.orig

puts "SetDisplayFlags"
# SetDisplayFlag  2 1
SetDisplayFlag    4 1
SetDisplayFlag    5 1
SetDisplayFlag    6 1
SetDisplayFlag   22 1

#---------------------------
proc do_one_view {orient  slicenum} {
#---------------------------
global imagedir
global subject

  switch -exact -- $orient {
    0 { set viewname cor }
    1 { set viewname axl }
    2 { set viewname sag }
  }

  set slicestr [format "%03d" $slicenum]

  SetOrientation $orient
  SetSlice $slicenum

  puts "RedrawScreen"
  RedrawScreen
  RedrawAll
  RedrawScreen
  RedrawAll
  RedrawScreen
  RedrawAll
  RedrawScreen
  RedrawAll

  # Use braces to avoid tcl's utterly brain-dead catenation inadequacies...
  set imagepath "${imagedir}/${subject}_${viewname}_${slicestr}.tif"

  puts "SaveTIFF ${imagepath}"
  SaveTIFF $imagepath
}

#-----------------------------
# coronal
#-----------------------------
foreach slicenum { 95 120 150 160 170 200 } {
  do_one_view 0 $slicenum
}

#-----------------------------
# axial
#-----------------------------
foreach slicenum { 120 150 160 170 180 190 } {
  do_one_view 1 $slicenum
}

puts "QuitMedit"
QuitMedit

# exit(0)

#=============================================