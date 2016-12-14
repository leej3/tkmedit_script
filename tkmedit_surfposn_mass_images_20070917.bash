# tkmedit_surfposn_mass_images_20070917.bash
# mass images

subjectsdir=/brain-RAID2C/freesurfer_gw/MMIL_Download/20070917/Subjects
  scriptdir=/brain-RAID2C/freesurfer_gw/MMIL_Download/20070917/scripts


function onesubject() {
  sbjid=$1

  echo "========================================"
  echo "            "$sbjid
  echo "========================================"
  subjectdir=$subjectsdir"/FS_"$sbjid
  screencapdir=$subjectdir"/screencaps_surfpos"
  mkdir $screencapdir

  tkmedit "FS_"$sbjid T1.mgz  -tcl $scriptdir"/tkmedit_surfposn_makeimages.tcl"
}

onesubject 10419
onesubject 12009
onesubject 12378
[... etc ...]