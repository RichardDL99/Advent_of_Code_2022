#include <Constants.au3>
#include <Date.au3>
#include <Debug.au3>
#include <GuiConstantsEx.au3>
#include <Misc.au3>
#include "..\..\Includes\RDL_Functions.au3"
#Include <GuiToolBar.au3>
#include <FF.au3>
#endregion

AutoItSetOption("MustDeclareVars", 1)



Func CommonChar2($s0, $s1)
	; find the common char
	; assuming same length and only 1 common char
	; assuming there is a common char
	Local $sCh
	Local $iIx

	For $iIx = 1 To StringLen($s0)
		$sCh = StringMid($s0, $iIx, 1)
		If StringInStr($s1, $sCh, 1) Then
			ExitLoop
		EndIf
	Next

	Return $sCh
EndFunc

Func CommonChar3($s0, $s1, $s2)
	; find the common char
	; assuming same length and only 1 common char
	; assuming there is a common char
	Local $sCh
	Local $iIx

	For $iIx = 1 To StringLen($s0)
		$sCh = StringMid($s0, $iIx, 1)
		If StringInStr($s1, $sCh, 1) And StringInStr($s2, $sCh, 1) Then
			ExitLoop
		EndIf
	Next

	Return $sCh
EndFunc


Func ChPrio($sCh)

	;Lowercase item types a through z have priorities 1 through 26.
	;Uppercase item types A through Z have priorities 27 through 52.
	Local $iPrio


	Switch Asc($sCh)
		Case Asc("a") To Asc("z")
			$iPrio = Asc($sCh) - Asc("a") + 1
		Case Asc("A") To Asc("Z")
			$iPrio = Asc($sCh) - Asc("A") + 27
	EndSwitch
	Return $iPrio
EndFunc


Local $sArray
Local $iRow
Local $iCol
Local $iNofRows
Local $bGood
Local $sTmp
Local $iFullContCount
Local $iPass
Local $sMsg
Local $sStr0
Local $sStr1
Local $iLen
Local $sChar
Local $iPrio




Local $iTotal
CSVFile_to_Ary2D("Data_03_02.csv", $sArray)
_DebugArrayDisplay($sArray)
_ArrayDelete($sArray, UBound($sArray) - 1)
_DebugArrayDisplay($sArray)



$iNofRows = UBound($sArray)
$iTotal = 0
For $iRow = 0 To $iNofRows - 1
	$sTmp = $sArray[$iRow][0]
	ConFmtWr(" %3d %2d %-40s  ", $iRow, 0, $sTmp)
	$iLen = StringLen($sTmp)
	$sStr0 = StringMid($sTmp, 1, $iLen / 2)
	$sStr1 = StringMid($sTmp, $iLen / 2 + 1)
	ConFmtWr("S0 ~%-20s~  ", $sStr0)
	ConFmtWr("S1 ~%-20s~  ", $sStr1)
	$sChar = CommonChar2($sStr0, $sStr1)
	$iPrio = ChPrio($sChar)
	$iTotal += $iPrio
	ConFmtWr("   %s  %2d  %6d\n", $sChar, $iPrio, $iTotal)
Next


Local $sTmp0
Local $sTmp1
Local $sTmp2


$iTotal = 0
For $iRow = 0 To $iNofRows - 1 Step 3
	$sTmp0 = $sArray[$iRow + 0][0]
	$sTmp1 = $sArray[$iRow + 1][0]
	$sTmp2 = $sArray[$iRow + 2][0]




	ConFmtWr("P2 %3d %2d %-40s  ", $iRow, 0, $sTmp0)
	;$iLen = StringLen($sTmp)
	;$sStr0 = StringMid($sTmp, 1, $iLen / 2)
	;$sStr1 = StringMid($sTmp, $iLen / 2 + 1)
	;ConFmtWr("S0 ~%-20s~  ", $sStr0)
	;ConFmtWr("S1 ~%-20s~  ", $sStr1)
	$sChar = CommonChar3($sTmp0, $sTmp1, $sTmp2)
	$iPrio = ChPrio($sChar)
	$iTotal += $iPrio
	ConFmtWr("   %s  %2d  %6d\n", $sChar, $iPrio, $iTotal)
Next


