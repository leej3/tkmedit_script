# tkmedit_surfposn_mass_images_20070917.bash
# mass images

subjectsdir=$SUBJECTS_DIR
  scriptdir=~/Documents/code/freesurfer_images_with_tcl

function onesubject() {
  sbjid=$1

  echo "========================================"
  echo "            "$sbjid
  echo "========================================"
  export screencapdir=$subjectsdir"/screencaps_surfpos"
  mkdir -p $screencapdir

  tkmedit $sbjid T1.mgz  -tcl $scriptdir"/tkmedit_surfposn_makeimages.tcl"
}
