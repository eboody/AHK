#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
roamtemplates := "C:\Users\ebood\OneDrive\Documents\Code\Roam Templates\"

    :*:@@::eboodnero@gmail.com
	:*:!!::4807 Vanalden Ave. Tarzana, CA 91356
	

	:?*:---::{Alt down}{Numpad0}{Numpad1}{Numpad5}{Numpad1}{Alt up}
	::thatd::that'd
	::itd::it'd
	::hed::he'd
	::i::I
	:*:dont::don't
	:*:wasnt::wasn't
	:*:theyre::they're
	:*:couldnt::couldn't
	:*:youve::you've
	::youre::you're
	:*:youll::you'll
	:*:theyll::they'll
	::whats::what's
	:*:thats::that's
	::im::I'm
	::ill::I'll
	:*:isnt::isn't
	::doesnt::doesn't
	:*:theyve::they've
	:*:wouldnt::wouldn't
	:*:lets::let's
	:*:theres::there's
	:*:itll::it'll
	::its::it's
	::wouldve::would've
	::heres::here's
	::didnt::didn't
	::shouldnt::shouldn't
	::id::
		IfWinNotActive, ahk_exe Code.exe 
		{
			sendraw, I'd
			Send, {space}
		}
		Else
			send, id{space}			
	::ive::I've
	::hadnt::hadn't
	::arent::aren't
	::werent::weren't
	::havent::haven't
	::mightve::might've
	::youd::you'd
	::thered::there'd
	::weve::we've
	::hes::he's
	::youtube::YouTube
	::thatll::that'll
	::hasnt::hasn't
	::wont::won't
	::cant::can't
	::thisll::this'll
	::shes::she's
	::wed::we'd
	::whens::when's
	^2:: Send {U+2082}
	
    :*?:/deg::
	Send {U+00B0}
	return

	:*:///::
	Send /**/{Left 2}
	return

	:*:/spenda::
	{	
		MouseMove, 465, 80
		Clipboard := "We built a web-tool that could help you"
		Send ^v
		Sleep 100
		Send {Tab 4}
		FileRead, Clipboard, %roamtemplates%spendabit.txt
		Send ^v
		Sleep 100
		Clipboard := "https://calendly.com/eboodnero/15min"
	}

    :*:/ifroam::
		Send, IfWinActive, ahk_id `%ROAMUID`% {Enter}{{}{Enter}{}}return{Up}
	return

    :*:/worksheet::
		IfWinActive ahk_id %ROAMUID%
 		{
			FileRead, Clipboard, %roamtemplates%Worksheet.txt
			Send ^v
		}
	return


	:*:/context::
		IfWinActive ahk_id %ROAMUID%
 		{
			FileRead, Clipboard, %roamtemplates%Context.txt
			Send ^v
		}
	return

	:*:/tracker::
		IfWinActive ahk_id %ROAMUID%
		{
		FileRead, Clipboard, %roamtemplates%Tracker Table.txt
			send, ^v
		}
	return

	:*:/proj::
		IfWinActive ahk_id %ROAMUID%
		{
			send, **Tags:** {#}[[Projects]] +{Enter}**Goals:** +{Enter}**Due Date:**  
			Sleep, 50
			FileRead, Clipboard, %roamtemplates%Project.txt
			send, ^v
		}
	return

	:*:/daily::
		IfWinActive ahk_id %ROAMUID%
		{
			FileRead, Clipboard, %roamtemplates%daily.txt
			send, ^v
		}
	return

	:*:/subproj::
		IfWinActive ahk_id %ROAMUID%
		{
			send, **Tags:** {#}[[Sub-Projects]] +{Enter}**Goals:** +{Enter}**Due Date:**
			Sleep 300
			Send ^{End}{Enter}
			Sleep 100
			SendRaw ========================================================
			; Send 
			; Send {Enter} - # #[[Notes]]
			; FileRead, Clipboard, %roamtemplates%Project.txt
			; send, ^v
		}
	return

	:*:/video::
	IfWinActive, ahk_id %ROAMUID% 
	{
		FileRead, Clipboard, %roamtemplates%Video.txt
		Send, ^v
	}return

	:*:/prosp::
	IfWinActive, ahk_id %ROAMUID% 
	{
		Send, **Site:** +{Enter}**Category:** +{Enter}**Email:** +{Enter}**Status:**
		Sleep, 50
		FileRead, Clipboard, %roamtemplates%Prospect.txt
		Send, ^v
	}return

	:*:/art::
	IfWinActive ahk_id %ROAMUID%
	{
		FileRead, Clipboard, %roamtemplates%Article.txt
		Send, ^v
	}
	return
	:*:/weeklyr::
	IfWinActive ahk_id %ROAMUID%
	{
		FileRead, Clipboard, %roamtemplates%Weekly Review.txt
		send, ^v
	}
	return
	:*:===::
		IfWinActive ahk_id %ROAMUID%
		{
			SendRaw, ========================================================
		}
	return
	:?B0*:#::
		IfWinActive ahk_id %ROAMUID%
		{
			Send, [[]]
		}	
	return
	:*:![::
		IfWinActive ahk_id %ROAMUID%
		{
			Send, {!}[]()
		}
	return

	:*:/yout::
		tempClip := ClipboardAll
		Clipboard := "{{youtube: " . Clipboard . "}}"
		Sleep 25
		Send, ^v
		Sleep 25
		Clipboard := tempClip
	return
	   :*:/img::
		tempClip := ClipboardAll
		Clipboard := "![](" . Clipboard . ")"
		Sleep 25
		Send, ^v
		Sleep 25
		Clipboard := tempClip
	Return