if not A_IsAdmin
{
	try {
		Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
	} catch e {
		if A_Language = 0804
		{
			MsgBox SAI Auto Save Tool 需要管理员权限以控制 SAI 保存.
		}
		else if A_Language = 0411
		{
			MsgBox SAI Auto Save Toolは、SAIを保存するために、管理者特権を必要とする。
		}
		else if ((A_Language = 0404) or (A_Language = 0c04)) or ((A_Language = 1004) or (A_Language = 1404))
		{
			MsgBox SAI Auto Save Tool 需要管理員權限以操控 SAI 存儲.
		}
		else
		{
			MsgBox SAI Auto Save Tool needs Administrator Privilege to save.
		}
	}
	ExitApp
}
SCM01 := "设置保存频率"
TCM01 := "設定存儲頻率"
JPM01 := "保存間隔を設定しなさい"
ENM01 := "Set Interval"
SCM02 := "查看当前频率"
TCM02 := "查看當前頻率"
JPM02 := "現在の間隔を示しなさい"
ENM02 := "Show Interval"
SCM03 := "暂停自动保存"
TCM03 := "暫停自動存儲"
JPM03 := "自動保存を一時停止します"
ENM03 := "Pause Autosave"
SCM04 := "退出本工具"
TCM04 := "退出本工具"
JPM04 := "退出します"
ENM04 := "Exit"
SCG01 := "间隔分钟数："
TCG01 := "間隔分鐘數："
JPG01 := "間隔分："
ENG01 := "Interval Minutes: "
SCG02 := "确定"
TCG02 := "確認"
JPG02 := "確認"
ENG02 := "OK"
SC01 := "已启动."
TC01 := "已啟動."
JP01 := "スタートした。"
EN01 := "Launched."
SC02 := "SAI将在10秒后自动保存，按 ESC 取消..."
TC02 := "SAI將於10秒後自動存儲，按 ESC 取消..."
JP02 := "SAIは10秒の後でを保存します。キャンセルするために、ESCを押しなさい。"
EN02 := "SAI will save in 10 seconds. Press ESC to cancel."
SC03 := "自动保存已取消."
TC03 := "自動存儲已取消."
JP03 := "自動保存はキャンセルされた。"
EN03 := "Auto-saving has been cancelled."
SC04 := "正在保存..."
TC04 := "正在存儲..."
JP04 := "保存しています..."
EN04 := "SAI is saving..."
SC05 := "SAI将在下次作品修改后立刻保存。"
TC05 := "SAI將於下次作品修改后立即存儲。"
JP05 := "次回作品が改正していた後に、SAIはすぐに保存するでしょう。"
EN05 := "SAI will save once it has file changed."
SC06 := "SAI将在下次窗口激活时立刻保存。"
TC06 := "SAI將在下次窗口活動時立即存儲。"
JP06 := "次回SAIがアクティブにする時、SAIはすぐに保存するでしょう。"
EN06 := "SAI will save once it is activated."
SM01 := ENM01
SM02 := ENM02
SM03 := ENM03
SM04 := ENM04
SG01 := ENG01
SG02 := ENG02
S01 := EN01
S02 := EN02
S03 := EN03
S04 := EN04
S05 := EN05
S06 := EN06
if A_Language = 0804
{
	SM01 := SCM01
	SM02 := SCM02
	SM03 := SCM03
	SM04 := SCM04
	SG01 := SCG01
	SG02 := SCG02
	S01 := SC01
	S02 := SC02
	S03 := SC03
	S04 := SC04
	S05 := SC05
	S06 := SC06
}
if ((A_Language = 0404) or (A_Language = 0c04)) or ((A_Language = 1004) or (A_Language = 1404))
{
	SM01 := TCM01
	SM02 := TCM02
	SM03 := TCM03
	SM04 := TCM04
	SG01 := TCG01
	SG02 := TCG02
	S01 := TC01
	S02 := TC02
	S03 := TC03
	S04 := TC04
	S05 := TC05
	S06 := TC06
}
if A_Language = 0411
{
	SM01 := JPM01
	SM02 := JPM02
	SM03 := JPM03
	SM04 := JPM04
	SG01 := JPG01
	SG02 := JPG02
	S01 := JP01
	S02 := JP02
	S03 := JP03
	S04 := JP04
	S05 := JP05
	S06 := JP06
}
Menu, Tray, NoStandard
Menu, Tray, Add, %SM01%, BackToSetup
Menu, Tray, Add, %SM02%, ShowInterval
Menu, Tray, Add, %SM03%, PauseTool
Menu, Tray, Add, %SM04%, ExitNow
delayminutes := 5
firstStart := 1
paused := 0
bts := 0

ShowSetup:
Gui, Setup:Add, Text, yp+10 x105 w100, %SG01%
Gui, Setup:Add, Text, vMinuteText xp+100 w50, %delayminutes%
Gui, Setup:Add, Slider, x10 w300 TickInterval5 Page5 center vMinuteSlider gMinuteSlider Range0-60 altsubmit, %delayminutes%
Gui, Setup:Add, Button, gOK vOK x110 h30 w100 center, %SG02%
Gui, Setup:Show, , Setup SAI Auto Save Tool
Menu, Tray, Disable, %SM01%
Menu, Tray, Disable, %SM03%
MinuteSlider := delayminutes
finish := 0
goto GuiCloseUnexcepted
ExitApp

BackToSetup:
bts := 1
return

PauseTool:
if paused = 0
{
	Menu, Tray, Disable, %SM01%
	Menu Tray, Check, %SM03%
	paused := 1
	Suspend On
	Pause On
}
else
{
	Menu, Tray, Enable, %SM01%
	Menu Tray, Uncheck, %SM03%
	paused := 0
	Suspend Off
	Pause Off
}
return

MinuteSlider:
gui, Setup:submit, nohide
guicontrol, Setup:,MinuteText, %MinuteSlider%
if MinuteSlider <= 0
{
	GuiControl, Disable, OK
}
if MinuteSlider > 0
{
	GuiControl, Enable, OK
}
return

OK:
finish := 1
bts := 0
delayminutes := MinuteSlider
Menu, Tray, Enable, %SM01%
Menu, Tray, Enable, %SM03%
Gui, Setup:destroy
return

ShowInterval:
MsgBox %SG01%%delayminutes%
return

GuiCloseUnexcepted:
WinWaitClose, Setup SAI Auto Save Tool
Menu, Tray, Enable, %SM01%
Menu, Tray, Enable, %SM03%
if (finish = 1) or (bts = 1)
{
	if bts = 1
	{
		bts = 0
	}
	Gui, Setup:destroy
	goto GuiClose
}
else if bts = 0
{
	ExitApp
}
return

GuiClose:
if delayminutes = 0
{
	MsgBox Error
	ExitApp
}
TrayTip, SAI Auto Save Tool, %S01%, 1
savedelay := delayminutes * 120
if firstStart = 1
{
	a := savedelay + 5
	firstStart := 0
}
d := 0
s := 0
n := 0
loop{
	if bts = 1
	{
		break
	}
	if (WinActive("ahk_class sfl_window_class") or WinActive("ahk_class sflRootWindow")) or (WinActive("ahk_exe sai.exe") or WinActive("ahk_exe sai2.exe"))
	{
		if a >= %savedelay%
		{
			if d = 0
			{
				TrayTip, SAI Auto Save Tool, %S02%, 10
				KeyWait, ESC, D T10
				if ErrorLevel = 0
				{
					a := 0
					TrayTip, SAI Auto Save Tool, %S03%, 2, 16
				}
				else
				{
					d := 1
				}
			}
			if d = 1
			{
				if (WinActive("ahk_class sfl_window_class") or WinActive("ahk_class sflRootWindow")) or (WinActive("ahk_exe sai.exe") or WinActive("ahk_exe sai2.exe"))
				{
					t := ""
					t1 := ""
					t2 := ""
					t3 := ""
					t4 := ""
					WinGetTitle, t1, ahk_class sfl_window_class
					WinGetTitle, t2, ahk_exe sai.exe
					WinGetTitle, t3, ahk_class sflRootWindow
					WinGetTitle, t4, ahk_exe sai2.exe
					t := t1 . t2 . t3 . t4
					IfInString, t, (*)
					{
						a := 0
						d := 0
						s := 0
						n := 0
						SendEvent ^s
						TrayTip, SAI Auto Save Tool, %S04%, 3, 64
					}
					else
					{
						if n = 0
						{
							n := 1
							TrayTip, SAI Auto Save Tool, %S05%, 3, 16
						}
					}
				}
				else if (WinExist("ahk_class sfl_window_class") or WinExist("ahk_class sflRootWindow")) or (WinExist("ahk_exe sai.exe") or WinExist("ahk_exe sai2.exe"))
				{
					if s = 0
					{
						s := 1
						TrayTip, SAI Auto Save Tool, %S06%, 3, 16
					}
				}
			}
		}
	}
	Sleep, 500
	if (WinExist("ahk_class sfl_window_class") or WinExist("ahk_class sflRootWindow")) or (WinExist("ahk_exe sai.exe") or WinExist("ahk_exe sai2.exe"))
	{
		si := ""
		si1 := ""
		si2 := ""
		si3 := ""
		si4 := ""
		WinGetTitle, si1, ahk_class sfl_window_class
		WinGetTitle, si2, ahk_exe sai.exe
		WinGetTitle, si3, ahk_class sflRootWindow
		WinGetTitle, si4, ahk_exe sai2.exe
		si := si1 . si2 . si3 . si4
		IfInString, si, (*)
		{
			a := a + 1  ; Only calculate when it's needed.
		}
	}
	if a >= 30000
	{
		a := savedelay + 5
	}
}
if bts = 1
{
	goto ShowSetup
}

ExitNow:
ExitApp