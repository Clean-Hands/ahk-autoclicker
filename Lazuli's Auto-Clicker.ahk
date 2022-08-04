#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance, force
#MaxThreadsPerHotkey 3

Gui, +AlwaysOnTop +ToolWindow
Gui, Color, Aqua
Gui, Font, q5
Gui, Add, Text, x5 y10 w135 +Right, Milliseconds between clicks:
Gui, Add, Edit, x+5 y7 w30 +Number +Limit vSleepTime gUpdate, 10
Gui, Add, Button, x226 y0 gMin, Minimize
Gui, Add, Text, x5 y35 w135 +Right, Number of clicks:
Gui, Add, Edit, x+5 y32 w30 +Number +Limit vNumClicks gUpdate, 50
Gui, Add, Button, x+2 y32 w100 h22 gStart vStart, Start (3 sec delay)
Gui, Add, Radio, x75 y65 vUseButton gUpdate, Use LMB
Gui, Add, Radio, x+5 gUpdate, Use RMB
Gui, Font, Bold Underline
Gui, Add, Checkbox, x88 y90 vToggle gUpdate, Toggle Clicking
Gui, Font, Norm
Gui, Add, Radio, x5 y110 vToggleRapid gUpdate, Toggle rapid clicking by pressing MMB
GuiControl, Disable, ToggleRapid
Gui, Add, Radio, x5 y+5 vToggleHold gUpdate, Toggle holding click by pressing MMB
GuiControl, Disable, ToggleHold
Gui, Submit
Gui, Show, x0 y865 AutoSize, Lazuli's Auto-Clicker v3
Return

GuiClose:
	ExitApp
	Return

Update:
	Gui, Submit , NoHide
	GuiControl, Disable%Toggle%, NumClicks
	GuiControl, Disable%Toggle%, Start
	GuiControl, Enable%Toggle%, ToggleRapid
	GuiControl, Enable%Toggle%, ToggleHold
	GuiControl, Disable%ToggleHold%, SleepTime
	If (Toggle = 0) {
		GuiControl, Enable, SleepTime
	}
	Return

Start:
	If (UseButton = 1 or UseButton = 2) {
		Count3 := 3
		Loop, 3 {
			MsgBox, 262144, Countdown, %Count3%, 1
			Count3--
		}
		If (UseButton = 1) {
			Gui, Color, Red
			Loop, %NumClicks% {
					Click
					Sleep, %SleepTime%
			}
			Gui, Color, Aqua
		} Else If (UseButton = 2) {
			Gui, Color, Red
			Loop, %NumClicks% {
					Click, Right
					Sleep, %SleepTime%
			}
			Gui, Color, Aqua
		} Else {
			Return
		}
	} Else {
		Return
	}
	Return

Min:
	Gui, Minimize
	Return

MButton::
If (Toggle = 1) {
	If (UseButton = 1) {
		If (ToggleRapid = 1) {
			ClickToggle := !ClickToggle
			Gui, Color, Red
			Loop {
				If (!ClickToggle)
					Break
				Click
				Sleep, %SleepTime%
			}
			Gui, Color, Aqua
		} Else If (ToggleHold = 1) {
			HoldToggle := !HoldToggle
			Gui, Color, Red
			Click, Down
			Loop {
				If (!HoldToggle) {
					Click, Up
					Break
				}
			}
			Gui, Color, Aqua
		} Else {
			Return
		}
	} Else If (UseButton = 2) {
		If (ToggleRapid = 1) {
			ClickToggle := !ClickToggle
			Gui, Color, Red
			Loop {
				If (!ClickToggle)
					Break
				Click, Right
				Sleep, %SleepTime%
			}
			Gui, Color, Aqua
		} Else If (ToggleHold = 1) {
			HoldToggle := !HoldToggle
			Gui, Color, Red
			Click, Down, Right
			Loop {
				If (!HoldToggle) {
					Click, Up, Right
					Break
				}
			}
			Gui, Color, Aqua
		} Else {
			Return
		}
	} Else {
		Return
	}
} Else {
	Return
}
Return

^!x:: ExitApp