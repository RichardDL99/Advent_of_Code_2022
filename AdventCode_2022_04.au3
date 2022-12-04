#include <Constants.au3>
#include <Date.au3>
#include <Debug.au3>
#include <GuiConstantsEx.au3>
#include <Misc.au3>
#include "..\Includes\RDL_Functions.au3"
#Include <GuiToolBar.au3>
#include <FF.au3>
#endregion

AutoItSetOption("MustDeclareVars", 1)

Func FullyContained($sRng0, $sRng1, $iOpt)

	; opt 0 = superset either way
	;     1 = any overlap

	Local $isFullyCont = 0 ; also using that for overlap on 2nd pass
	Local $sAy
	Local $iR0S
	Local $iR0E
	Local $iR1S
	Local $iR1E

	$sAy = StringSplit($sRng0, "-", 3)
	;_DebugArrayDisplay($sAy)
	$iR0S = Int($sAy[0])
	$iR0E = Int($sAy[1])

	$sAy = StringSplit($sRng1, "-", 3)
	;_DebugArrayDisplay($sAy)
	$iR1S = Int($sAy[0])
	$iR1E = Int($sAy[1])

	; Is if the 1st range is full cont of  the 2nd?
  If $iR0S <= $iR1S And  $iR0E >= $iR1E Then
		$isFullyCont = 1
	EndIf

	; Is if the 2nd range is full cont of  the 1st?
  If $iR1S <= $iR0S And  $iR1E >= $iR0E Then
		$isFullyCont = 1
	EndIf


	If $iOpt = 1 Then
		; If overlap 1 start will be in 0 range
		If $iR1S >= $iR0S And $iR1S <= $iR0E Then $isFullyCont = 1
		; or         1 end will be in 0 range
		If $iR1E >= $iR0S And $iR1E <= $iR0E Then $isFullyCont = 1
	EndIf

	Return $isFullyCont
EndFunc


Local $sArray

CSVFile_to_Ary2D("C:\RDL\Processing\Advent_Code_2022_04\Data.csv", $sArray)

;CSVFile_to_Ary2D($sFileThe, ByRef $Array2D)

_ArrayDelete($sArray, UBound($sArray) - 1) ; last row is blank
_DebugArrayDisplay($sArray)


Local $iRow
Local $iCol
Local $iNofRows
Local $bGood
Local $sTmp
Local $iFullContCount
Local $iPass
Local $sMsg


; check all cells are num-num
$iNofRows = UBound($sArray)
For $iRow = 0 To $iNofRows - 1
	For $iCol = 0 To 1
		$sTmp = $sArray[$iRow][$iCol]

		$bGood = StringRegExp($sTmp, "[0-9]{1,2}-[0-9]{1,2}")
		If Not $bGood Then
			ConFmtWr(" %3d %2d %-12s %1d\n", $iRow, $iCol, $sTmp, $bGood)
		EndIf
	Next
Next


For $iPass = 0 To 1
	$sMsg = "Fully Contained "
	If $iPass = 1 Then $sMsg = "Overlapping     "
	$iFullContCount = 0
	For $iRow = 0 To $iNofRows - 1
		$iFullContCount += FullyContained($sArray[$iRow][0], $sArray[$iRow][1], $iPass)
		$sTmp = $sArray[$iRow][0] + " ~ " + $sArray[$iRow][1]
		;ConFmtWr(" %3d %2d\n", $iRow, $iFullContCount)
	Next
	ConFmtWr("%s %3d\n", $sMsg, $iFullContCount)
Next
