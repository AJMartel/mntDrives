

#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>


Func Timecheck()
    $file1_2 = FileGetTime("C:\file1.txt", 0, 1)
    $file2_2 = FileGetTime("C:\file2.txt", 0, 1)
    If $file1_1 == $file1_2 Then
        ; Do something here if file 1 isn't modified within 5ins
    EndIf
    If $file2_1 == $file2_2 Then
        ; Maybe WinClose?
        WinClose("programhere")
        ; Maybe ProcessClose
        ProcessClose("process.exe")
        ; Launch your program...
        Run(...)
        ; Wait for process
        ProcessWait("process.exe")
        ; Wait for Program...
        WinWait("programhere")
        WinSetTitle("programhere", "", "newprogramhere")
        WinMove("newprogramheret", "", 0, 0, 800, 600, 1)
    EndIf
    $file1_1 = FileGetTime("C:\file1.txt", 0, 1)
    $file2_1 = FileGetTime("C:\file2.txt", 0, 1)
EndFunc

; Initial Launch, grab current GetTime
$file1_1 = FileGetTime("C:\file1.txt", 0, 1)
$file2_1 = FileGetTime("C:\file2.txt", 0, 1)

While 1
    Sleep(300000) ;5min
    Timecheck()
WEnd











; Assign the file path to a variable
Local $sFilePath = "C:\AutomationDevelopers\temp.txt"

;Open the file temp.txt in overwrite mode. If the folder C:\AutomationDevelopers does not exist, it will be created.
Local $hFileOpen = FileOpen($sFilePath, $FO_OVERWRITE + $FO_CREATEPATH)

;Display a message box in case of any errors.
If $hFileOpen = -1 Then
    MsgBox($MB_SYSTEMMODAL, "", "An error occurred when opening the file.")
EndIf

;Write a line of data to file by passing the previously opened file handle. Newline (@CRLF) will be automatically added.
FileWriteLine($hFileOpen, "This is the first line.")
FileWriteLine($hFileOpen, "This is the second line.")

;Close the handle returned by FileOpen.
FileClose($hFileOpen)