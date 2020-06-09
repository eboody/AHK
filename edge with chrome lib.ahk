#NoEnv
SetBatchLines, -1
SetTitleMatchMode 2
#Include C:\Users\ebood\OneDrive\Documents\Code\AHK\Chrome.ahk										; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=42890
FileEncoding, UTF-8

; "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe"
;Run, "C:\Program Files (x86)\Microsoft\Edge Beta\Application\msedge.exe" " --remote-debugging-port=9222"
;Sleep 5000

url  := "https://www.autohotkey.com/boards/"
Chrome := new Chrome("","","","C:\Program Files (x86)\Microsoft\Edge Beta\Application\msedge.exe")

if (Chromes := Chrome.FindInstances("msEdge.exe"))
	ChromeInst := {"base": Chrome, "DebugPort": Chromes.MinIndex()}	; or if you know the port:  ChromeInst := {"base": Chrome, "DebugPort": 9222}
else
	msgbox That didn't work. Please check if Chrome is running in debug mode.`n(use, for example, http://localhost:9222/json/version )


; --- Connect to the page ---
if !(Page := ChromeInst.GetPage( ))		
{
	MsgBox, Could not retrieve page!
	ChromeInst.Kill()
}
else
	Page.WaitForLoad()

Page.Call("Page.navigate", {"url": url})			; Navigate to url
Page.WaitForLoad()
msgbox Close msgbox to exit script.
ExitApp