ChatStartup:
#SingleInstance Off

SetBatchLines, -1
OnExit, ExitSub
If !FileExist(A_AppData "\Extras\User\redbutton.ico")
   UrlDownloadToFile, http://www.autohotkey.net/~dylan904/Images/redbutton.ico, %A_AppData%\Extras\User\redbutton.ico
Channel := "#yourchannel", pvtC := "PRIVMSG"
Gui, 80: Add, Edit, x10 y435 w550 vText -WantReturn
Gui, 80: Add, Button, x570 y434 w30 w20 gSendText vSender +Default, Send
Gui, 80: Add, Button, +BackgroundTrans x628 yp vCloseConvo gCloseConvo, Close Conversation
Gui, 80: Add, Button, y3 xm vonlinetab1 gButton1, Contractors
Gui, 80: Add, Button, yp xp+70 vonlinetab2 gButton2 Hidden, 
Gui, 80: Add, Button, yp xp+70 vonlinetab3 gButton3 Hidden, 
Gui, 80: Add, Button, yp xp+70 vonlinetab4 gButton4 Hidden, 
Gui, 80: Add, Button, yp xp+70 vonlinetab5 gButton5 Hidden, 
Gui, 80: Add, Button, yp xp+70 vonlinetab6 gButton6 Hidden, 
Gui, 80: Add, Button, yp xp+70 vonlinetab7 gButton7 Hidden, 
Gui, 80: +LastFound
hwndRich := WinExist()
Chat1 := RichEdit_Add(hwndRich, 10, 27, 600, 400, "MultiLine Border ReadOnly")
Chat2 := RichEdit_Add(hwndRich, 10, 27, 600, 400, "MultiLine Border Hidden ReadOnly")
Chat3 := RichEdit_Add(hwndRich, 10, 27, 600, 400, "MultiLine Border Hidden ReadOnly")
Chat4 := RichEdit_Add(hwndRich, 10, 27, 600, 400, "MultiLine Border Hidden ReadOnly")
Chat5 := RichEdit_Add(hwndRich, 10, 27, 600, 400, "MultiLine Border Hidden ReadOnly")
Chat6 := RichEdit_Add(hwndRich, 10, 27, 600, 400, "MultiLine Border Hidden ReadOnly")
Chat7 := RichEdit_Add(hwndRich, 10, 27, 600, 400, "MultiLine Border Hidden ReadOnly")
Loop, 7 
   RichEdit_SetCharFormat(Chat%A_Index%, "Segoe", "s9",,, "All")
Gui, 80: Default
GuiControlGet, OnlineTab1, Pos
Gui, 1: Default
Gui, 80: Add, Picture, +AltSubmit +backgroundtrans Hidden x%OnlineTab1X% y%OnlineTab1Y% h%OnlineTab1H% w%OnlineTab1W% vredbutton1 gbutton1, %A_AppData%\Extras\User\redbutton.ico
Gui, 80: Add, Picture, +AltSubmit +backgroundtrans Hidden x30 y3 vredbutton2 gbutton2, %A_AppData%\Extras\User\redbutton.ico
Gui, 80: Add, Picture, +AltSubmit +backgroundtrans Hidden x30 yp vredbutton3 gbutton3, %A_AppData%\Extras\User\redbutton.ico
Gui, 80: Add, Picture, +AltSubmit +backgroundtrans Hidden x30 yp vredbutton4 gbutton4, %A_AppData%\Extras\User\redbutton.ico
Gui, 80: Add, Picture, +AltSubmit +backgroundtrans Hidden x30 yp vredbutton5 gbutton5, %A_AppData%\Extras\User\redbutton.ico
Gui, 80: Add, Picture, +AltSubmit +backgroundtrans Hidden x30 yp vredbutton6 gbutton6, %A_AppData%\Extras\User\redbutton.ico
Gui, 80: Add, Picture, +AltSubmit +backgroundtrans Hidden x30 yp vredbutton7 gbutton7, %A_AppData%\Extras\User\redbutton.ico
Gui, 80: Add, ListView, y27 x620 w125 h300 NoSort gOnlineClick vOnlineUsers hwndhwndListView4, Online Users
UserTabCount := 1, CurrentTabList := "Contractors"
GoSub, Button1
While (NickName = ""){
    InputBox, NickName, Enter a nickname!, Enter a nickname to use.
	If (Errorlevel)
		ExitApp
}
Gui, 80: Default
LV_Modify(1, "Center")
Gui, 1: Default
ListView_HeaderFontSet(hwndListView4, "b")
Gui, 80: Show,, Contractor Chat
WantNick := NickName
StringReplace, NickName, NickName,%a_space%,_,All
WinSetTitle, Contractor Chat,, Contractor Chat - %WantNick%
RichEdit_SetText(Chat1, "Connecting...`r`n", "SELECTION", -1)
CONNECT(NickName, "dylan904", NickName, "", "irc.freenode.net", 6667)
ROMF("Message_Recieved")
JOIN(Channel)
SetTimer, JOIN, 20000
Return
 
JOIN:
JOIN(Channel)
Return
 
SendText:
Gui, 80: Default
GuiControlGet, Text
Gui, 1: Default
If (Trim(Text) = "")
    Return
Else IfInString, Text, QUIT :Ping timeout:
    Return
Else If (CurrentTabnum > 1)
    MSG(Addressing, ChatEncrypt(Text))
Else 
    MSG(Channel, ChatEncrypt(Text))
RichEdit_SetText(%CurrentUserTab%, "<" WantNick "> " Text "`r`n", "SELECTION", -1)
SendMessage, 0x115, 7, 0,, % "ahk_id " %CurrentUserTab%   ;WM_VSCROLL
ScrollPos := RichEdit_ScrollPos(Chat1)
If (ScrollPos != "0/0")
   RichEdit_ShowScrollBar(Chat1, "V", True)
GuiControl, 80: , Text
Return
 
ChatEncrypt(Data)
{
    Global Channel, NickName
    Data := CRC32(NickName) . "!" . Data
    Return Data
    Return 0
}
ChatDecrypt(Data)
{
    StringSplit, Data, Data, %A_Space%
    i := 4
    Data := ""
    While i <= Data0
    {   Data .= Data%i% . " "
        i++
    }
    Data := Trim(Data)
    who := SubStr(Data1, 2, InStr(Data1, "!") - 2)
    Header := SubStr(Data, 1, InStr(Data, "!"))
    If (Header = ":" . CRC32(who) . "!"){
        Message := SubStr(Data, InStr(Data, "!"))
        Return Message
    }
    Return 0
}
 
AscToHex(S) 
{
  Return S="" ? "":Chr((*&S>>4)+48) Chr((x:=*&S&15)+48+(x>9)*7) AscToHex(SubStr(S,2))
}
 
CRC32(x)
{
    x := AscToHex(x)
    L := StrLen(x)>>1          ; length in bytes
    StringTrimLeft L, L, 2     ; remove leading 0x
    L = 0000000%L%
    StringRight L, L, 8        ; 8 hex digits
    x = %x%%L%                 ; standard pad
    R =  0xFFFFFFFF            ; initial register value
    Loop Parse, x
    {
        y := "0x" A_LoopField   ; one hex digit at a time
        Loop 4 {
            R := (R << 1) ^ ( (y << (A_Index+28)) & 0x100000000)
            IfGreater R,0xFFFFFFFF
                R := R ^ 0x104C11DB7
        }
   }
   Return ~R                  ; ones complement is the CRC
}

Message_Recieved(Message)
{
    Global CurrentUserTab, Data, AlertingChat, redbutton1, redbutton2, redbutton3, redbutton4, redbutton5, redbutton6, redbutton7, CurrentTabNum, Chat1, Chat2, Chat3, Chat4, Chat5, Chat6, Chat7, Just4U, __WSA_ErrMsg
    If InStr(Message, "`r`n")
    {   Loop, PARSE, Message, `n, `r
            Message_Recieved(A_LoopField)
        Return
    }
    Global Channel, NickName, hChatControl1, hChatControl2, hChatControl3, hChatControl4, hChatControl5, hChatControl6, hChatControl7, WantNick, UserTabCount, ChosenUser, ChatCon
    StringSplit, Message, Message, %A_Space%
    who := SubStr(Message1, 2, InStr(Message1, "!") - 2)
    If(Message1 = "PING")
        SENDRAW("PONG " Message2)
    Else If(Message2 = "PING")
        SENDRAW("PONG " Message3)
    Else If(Message2 = 001)
        JOIN(Channel)
    Else If(Message2 = 433){
      SENDRAW("NICK " Message4 "_")
        NickName := Message4 . "_"
        JOIN(Channel)
    }
    IfInString, Message, QUIT :Ping timeout:
    {
		Control, Disable,, Sender
		RichEdit_SetText(Chat1, "`r`nRe-Connecting...`r`n", "SELECTION", -1)
        MsgBox, Your connection has timed out. Please wait until reconnected to continute with chat. This will take a moment. lone, receiving
    }
    If(Message2 = "JOIN"){
      Gui, ListView, OnlineUsers
        If (Who = NickName){
         If (ChatCon = 1){
            RichEdit_SetText(Chat1, "`r`nRe-Connected!`r`n`r`n", "SELECTION", -1)
                Control, Enable,, Sender
            }
         Else
            RichEdit_SetText(Chat1, "Connected!`r`n`r`n", "SELECTION", -1)
        }
        Else{
         RichEdit_SetText(Chat1, Who " has joined!`r`n", "SELECTION", -1)
            Data := Data ", " Who
        }
        Gui, 80: Default
        LV_Add("", Who)
      Gui, 1: Default
    }
    Else If(Message2 = 353){
        i := 6
        While i <= Message0
        {   Data .= Message%i% . " "
            i++
        }
        Data := SubStr(Data,2)
        StringReplace, Data, Data,%a_space%,`,%a_space%,ALL
        StringReplace, Data, Data,_,%a_space%,ALL
        StringReplace, Data, Data, %NickName%`,%a_space%
        StringReplace, Data, Data, @
        StringTrimRight, Data, Data, 2
    }
    Else If(Message2 = 366){
        If (Data = "" and ChatCon = 0)
         RichEdit_SetText(Chat1, WantNick ", You're all alone!`r`n", "SELECTION", -1)
        Else {
            Loop, Parse, Data, `,%A_Space%
            {
                If (A_LoopField != ""){
               Gui, 80: Default
               Gui, ListView, OnlineUsers
                    LV_Add("", A_LoopField)
               Gui, 1: Default
            }
            }
        }
        ChatCon := 1
    }
    Else If(Message2 = "PART" || Message2 = "QUIT"){   
        If (Who = NickName){
         RichEdit_SetText(Chat1, "You have left!`r`n`r`n", "SELECTION", -1)
            ChatCon := 0
        }
        Else{
         RichEdit_SetText(Chat1, Who " has left!`r`n", "SELECTION", -1)
         Gui, 80: Default
         Gui, ListView, OnlineUsers
         NumOfChatters := LV_GetCount()
            Loop, %NumOfChatters% {
            LV_GetText(A, A_Index)
            If (A = Who){
               LV_Delete(A_Index)
               break
            }
         }
         Gui, 1: Default
      }
    }
    If (ChatCon = 1){
       IfInString, Message, JOIN %Channel%
            return
        IfNotInString, Message, %Channel%
        {   IfInString, Message, %WantNick%
            {   DirMsg := 1
                Loop %UserTabCount% {
               Gui, 80: Default
                    GuiControlGet, SeeIfExist,, OnlineTab%A_Index%
               Gui, 1: Default
                    If (Who = SeeIfExist){
                        FoundSenderBTN := "OnlineTab" A_Index , DirNum := A_Index
                        Break
                    }
                }
            }
        }
    }
    Message := ChatDecrypt(Message)
    If (Message != 0){
        Message := SubStr(Message,2)
        IfInString, Message, %WantNick%
        {   SoundBeep
         Just4U := 1
            If (CurrentTabNum != 1)
                SetTimer, blinker1, 50
        }
        If (DirMsg = 1) {
            If (FoundSenderBTN = ""){
                ChosenUser := Who, AlertingChat := 1
                GoSub, ReceivedClick
                DirNum := UserTabCount
            }
            DirMsg := 0, AlertingChat := 0
            SoundBeep
         RichEdit_SetText(Chat%DirNum%, "<" Who , "SELECTION", -1)
         TxtLenATM := RichEdit_GetTextLength(Chat%DirNum%)
         NameLength := StrLen(Who)
         RichEdit_SetSel(Chat%DirNum%, TxtLenATM - NameLength, TxtLenATM)
         RichEdit_SetCharFormat(Chat%DirNum%, "Segoe", "s9", "0xFF0000", "", "Selection")
         RichEdit_SetSel(Chat%DirNum%, TxtLenATM, TxtLenATM)
         RichEdit_SetCharFormat(Chat%DirNum%, "Segoe", "s9", "0x000000", "", "Selection")
         RichEdit_SetText(Chat%DirNum%, "> " Message "`r`n", "SELECTION", -1)
         If (CurrentTabNum != DirNum) {
            Gui, 80: Default
                GuiControlGet, OnlineTab%DirNum%, Pos
            Gui, 1: Default
                GuiControl, 80: Move, redbutton%DirNum%, % "x" OnlineTab%DirNum%X " y" OnlineTab%DirNum%Y " h" OnlineTab%DirNum%H " w" OnlineTab%DirNum%W
                SetTimer, blinker%DirNum%, 50
            }
        }
        Else{
         If (Just4U = 1){
            RichEdit_SetText(Chat1, "<" Who , "SELECTION", -1)
            TxtLenATM := RichEdit_GetTextLength(Chat1)
            NameLength := StrLen(Who)
            RichEdit_SetSel(Chat1, TxtLenATM - NameLength, TxtLenATM)
            RichEdit_SetCharFormat(Chat1, "Segoe", "s9", "0xFF0000", "", "Selection")
            RichEdit_SetSel(Chat1, TxtLenATM, TxtLenATM)
            RichEdit_SetCharFormat(Chat1, "Segoe", "s9", "0x000000", "", "Selection")
            RichEdit_SetText(Chat1, "> " Message "`r`n", "SELECTION", -1)
         }
         Else
            RichEdit_SetText(Chat1, "<" Who "> " Message "`r`n", "SELECTION", -1)
      }
   }
   Just4U := 0
    SendMessage, 0x115, 7, 0,, % "ahk_id " %CurrentUserTab%
   ScrollPos := RichEdit_ScrollPos(Chat1)
   If (ScrollPos != "0/0")
      RichEdit_ShowScrollBar(Chat1, "V", True)
}

onlineclick:
CurrentUserNum := A_EventInfo
PrevUserNum := A_EventInfo - 1
Gui, ListView, OnlineUsers
LV_GetText(ChosenUser, A_EventInfo)
Gui, 1: Default
ReceivedClick:
IfInString, CurrentTabList, %ChosenUser%
    Return
If (UserTabCount = 9 OR ChosenUser = NickName) 
    Return
CurrentTabList := CurrentTabList ", " ChosenUser
PreceedingTab := UserTabCount
++ UserTabCount
StringLen, UserCharCount, ChosenUser
GuiControl, 80: Text, OnlineTab%UserTabCount%, %ChosenUser%
Gui, 80: Default
Loop, 6 {
    OtherIndex := A_Index + 1
   If (UserCharCount >=1 && UserCharCount <= 4)
      ButtonWide%OtherIndex% := UserCharCount * 12
   Else If (UserCharCount >=5 && UserCharCount <= 10)
      ButtonWide%OtherIndex% := UserCharCount * 8
   Else If (UserCharCount >=11 && UserCharCount <= 6)
      ButtonWide%OtherIndex% := UserCharCount * 7
    GuiControlGet, OnlineTab%A_Index%, Pos
}
Gui, 1: Default
GuiControl, 80: Move, OnlineTab%UserTabCount%, % "w" ButtonWide%UserTabCount% " x"OnlineTab%PreceedingTab%X  + OnlineTab%PreceedingTab%W + 3
GuiControl, 80: Show, OnlineTab%UserTabCount%
If (AlertingChat != 1)
    GoSub, Button%UserTabCount%
RichEdit_SetText(Chat%UserTabCount% , "Private Chat With " ChosenUser ":`r`n`r`n", "SELECTION", -1)
return 
 
button1:
CurrentTabNum := 1
GoTo, SwitchingChatUser
button2:
CurrentTabNum := 2
GoTo, SwitchingChatUser
button3:
CurrentTabNum := 3
GoTo, SwitchingChatUser
button4:
CurrentTabNum := 4
GoTo, SwitchingChatUser
button5:
CurrentTabNum := 5
GoTo, SwitchingChatUser
button6:
CurrentTabNum := 6
GoTo, SwitchingChatUser
button7:
CurrentTabNum := 7

SwitchingChatUser:
Control, Hide,,, % "ahk_id " %CurrentUserTab%
CurrentUserTab := "Chat" CurrentTabNum, AssociatedButton := "OnlineTab" CurrentTabNum
Control, Show,,, % "ahk_id " %CurrentUserTab%
SetTimer, Blinker%CurrentTabNum%, Off
Gui, 80: Default
GuiControlGet, Addressing,, %AssociatedButton%
Gui, 1: Default
If (CurrentUserTab = "Chat1")
    GuiControl, 80: Hide, CloseConvo
Else 
    GuiControl, 80: Show, CloseConvo
GuiControl, 80: Focus, Text
Return

CloseConvo:
Gui, 80: Default
GuiControlGet, ButtonToDelete,, %AssociatedButton%
Gui, 1: Default
If (ButtonToDelete = "")
    Return
IfInString, CurrentTabList, %ButtonToDelete%
{   GuiControl, 80: , %CurrentUserTab%
    GuiControl, 80: Hide, %AssociatedButton%
    ChatTabRotation := UserTabCount - CurrentTabNum
    Loop, %ChatTabRotation% {
        If (CurrentTabNum = 2)
            OtherIndex := CurrentTabNum - 1
        Else
            OtherIndex := CurrentTabNum
        ++CurrentTabNum
      Gui, 80: Default
        GuiControlGet, OnlineTab%OtherIndex%, Pos
      Gui, 1: Default
        GuiControl, 80: Move, OnlineTab%CurrentTabNum%, % "x"OnlineTab%OtherIndex%X + OnlineTab%OtherIndex%W + 3
    }
    StringReplace, CurrentTabList, CurrentTabList, %ButtonToDelete%
    --UserTabCount
}
Return
 
 
;IRCFunctions.ahk LIBRARY (unfinished but working)
OMF(Socket, Data)
{
    ListLines, Off
    global OMF
    StringTrimRight, Data, Data, 2
    %OMF%(Data)
    ListLines, On
}
 
ROMF(Function)
{
    ListLines, Off
    global OMF
    OMF := Function
    ListLines, On
}
 
CONNECT(Nick, User, Name, Pass, Server, Port, Mode="8")
{
    ListLines, Off
    global Socket
    If (!Socket := WS2_Connect(Connection := Server . ":" . Port))
      MsgBox, 16, %A_ScriptName% - ERROR, There was an error while connecting to %Connection%!
    WS2_AsyncSelect(Socket, "OMF")
    WS2_SendData(Socket, "NICK " . Nick . "`r`n")
    WS2_SendData(Socket, "USER " . User . " " . Mode . " * :" . Name . "`r`n")
    WS2_SendData(Socket, "PASS " . Pass . "`r`n")
    ListLines, On
}
 
ID(Nick, User, Name, Pass, Mode="8")
{
    ListLines, Off
    global Socket
    WS2_SendData(Socket, "NICK " . Nick . "`r`n")
    WS2_SendData(Socket, "USER " . User . " " . Mode . " * :" . Name . "`r`n")
    WS2_SendData(Socket, "PASS " . Pass . "`r`n")
    ListLines, On
}
 
JOIN(Channel)
{
    ListLines, Off
    global Socket
    WS2_SendData(Socket, "JOIN " . Channel . "`r`n")
    ListLines, On
}
 
PRIVMSG(Name, Message)
{
    ListLines, Off
    global Socket
    WS2_SendData(Socket, "PRIVMSG " . Name . " :" . Message . "`r`n")
    ListLines, On
}
 
MSG(Name, Message)
{
    ListLines, Off
    global Socket, Addressing
    WS2_SendData(Socket, "PRIVMSG " . Name . " :" . Message . "`r`n")
    ListLines, On
}
 
NOTICE(Name, Message)
{
    ListLines, Off
    global Socket
    WS2_SendData(Socket, "NOTICE " . Name . " :" . Message . "`r`n")
    ListLines, On
}
 
QUERY(Name, Message)
{
    ListLines, Off
    global Socket
    WS2_SendData(Socket, "QUERY " . Name . " :" . Message . "`r`n")
    ListLines, On
}
 
SENDRAW(rawIRC)
{
    ListLines, Off
    global Socket
    WS2_SendData(Socket, rawIRC . "`r`n")
    ListLines, On
}
 
ACTION(Name, Action)
{
    ListLines, Off
    global Socket
    WS2_SendData(Socket, "PRIVMSG " . Name . " :" . Chr(1) . "ACTION " . Action . Chr(1) . "`r`n")
    ListLines, On
}
 
PART(Channel, Reason="")
{
    ListLines, Off
    global Socket
    WS2_SendData(Socket, "PART" . Channel . ((Reason != "") ? " :" . Reason : "") . "`r`n")
    ListLines, On
}
 
QUIT(Reason="")
{
    ListLines, Off
    global Socket
    WS2_SendData(Socket, "QUIT`r`n")
    WS2_CleanUp()
    ListLines, On
}
 
MODE(Name, Mode, Parameters)
{
    ListLines, Off
    global Socket
    WS2_SendData(Socket, "MODE " . Name . " " . Mode . " " . Parameters . "`r`n")
    ListLines, On
}
 
KICK(Name, Channel, Reason="")
{
    ListLines, Off
    global Socket
    If (Reason != "")
        WS2_SendData(Socket, "KICK " . Channel . " " . Name . " :" . Reason . "`r`n")
    Else
        WS2_SendData(Socket, "KICK " . Channel . " " . Name . "`r`n")
    ListLines, On
}
 
INVITE(Channel, Person)
{
    ListLines, Off
    global Socket
    WS2_SendData(Socket, "INVITE " . Channel . " " . Person . "`r`n")
    ListLines, On
}
 
OP(Channel, Person, DeOp=false)
{
    ListLines, Off
    global Socket
    WS2_SendData(Socket, "MODE " . Channel . " " . ((DeOp=false) ? "+" : "-") . "o " . Person . "`r`n")
    ListLines, On
}
 
VOICE(Channel, Person, DeVoice=false)
{
    ListLines, Off
    global Socket
    WS2_SendData(Socket, "MODE " . Channel . " " . ((DeVoice=false) ? "+" : "-") . "v " . Person . "`r`n")
    ListLines, On
}
 
BAN(Channel, Person, UnBan=false, KickBan=false, Reason="")
{
    ListLines, Off
    global Socket
    WS2_SendData(Socket, "MODE " . Channel . " " . ((UnBan=false) ? "+" : "-") . "b " . Person . "`r`n")
    If (KickBan = true)
        KICK(Channel, Person, Reason)
    ListLines, On
}
 
80GuiClose:
ExitSub:
Quit("i hate this")
OnExit
WS2_SendData(Socket, "PART " . Channel)
QUIT()
ExitApp


blinker1:
guicontrol, 80: Hide, redbutton1
sleep 700
guicontrol, 80: Show, redbutton1
sleep 670
return
blinker2:
guicontrol, 80: Hide, redbutton2
sleep 700
guicontrol, 80: Show, redbutton2
sleep 670
return
blinker3:
guicontrol, 80: Hide, redbutton3
sleep 700
guicontrol, 80: Show, redbutton3
sleep 670
return
blinker4:
guicontrol, 80: Hide, redbutton4
sleep 700
guicontrol, 80: Show, redbutton4
sleep 670
return
blinker5:
guicontrol, 80: Hide, redbutton5
sleep 700
guicontrol, 80: Show, redbutton5
sleep 670
return
blinker6:
guicontrol, 80: Hide, redbutton6
sleep 700
guicontrol, 80: Show, redbutton6
sleep 670
return
blinker7:
guicontrol, 80: Hide, redbutton7
sleep 700
guicontrol, 80: Show, redbutton7
sleep 670
return


AddGraphicButton(VariableName, ImgPath, Options="", bHeight=32, bWidth=32) 
{ 
Global 
Local ImgType, ImgType1, ImgPath0, ImgPath1, ImgPath2, hwndmode 
; BS_BITMAP := 128, IMAGE_BITMAP := 0, BS_ICON := 64, IMAGE_ICON := 1 
Static LR_LOADFROMFILE := 16 
Static BM_SETIMAGE := 247 
Static NULL 
SplitPath, ImgPath,,, ImgType1 
If ImgPath is float 
{ 
  ImgType1 := (SubStr(ImgPath, 1, 1)  = "0") ? "bmp" : "ico" 
  StringSplit, ImgPath, ImgPath,`. 
  %VariableName%_img := ImgPath2 
  hwndmode := true 
} 
ImgTYpe := (ImgType1 = "bmp") ? 128 : 64 
If (%VariableName%_img != "") AND !(hwndmode) 
  DllCall("DeleteObject", "UInt", %VariableName%_img) 
If (%VariableName%_hwnd = "") 
  Gui, 80: Add, Button,  v%VariableName% hwnd%VariableName%_hwnd +%ImgTYpe% %Options% 
ImgType := (ImgType1 = "bmp") ? 0 : 1 
If !(hwndmode) 
  %VariableName%_img := DllCall("LoadImage", "UInt", NULL, "Str", ImgPath, "UInt", ImgType, "Int", bWidth, "Int", bHeight, "UInt", LR_LOADFROMFILE, "UInt") 
DllCall("SendMessage", "UInt", %VariableName%_hwnd, "UInt", BM_SETIMAGE, "UInt", ImgType,  "UInt", %VariableName%_img) 
Return, %VariableName%_img ; Return the handle to the image 
}

/*
WinSock2.ahk // a rewrite by derRaphael (w) Sep, 9 2008

based on the WinLIRC Script from Chris
    http://www.autohotkey.com/docs/scripts/WinLIRC.htm
and on the WinLIRC Rewrite by ZedGecko
    http://www.autohotkey.com/forum/viewtopic.php?t=13829
    
__WSA_GetHostByName - Parts based upon scripts from DarviK 
and Tasman. Not much left of the origin source, but it was
their achievement by doing the neccessary research.
*/

; WS2 Connect - This establishes a connection to a named resource
; The parameter is to be passed in an URI:Port manner.
; Returns the socket upon successfull connection, otherwise it
; returns -1. In the latter case more Information is in the global
; variable __WSA_ErrMsg
;
; Usage-Example: 
;    Pop3_Socket := WS2_Connect("mail.isp.com:110")
; See the Doc for more Information.
WS2_Connect(lpszUrl) {

    Global 

    ; split our targetURI 
    __WinINet_InternetCrackURL("info://" lpszUrl,"__WSA")

    ; name our port
    WS2_Port := __WSA_nPort
    
    ; Init the Winsock connection
    if (     !( __WSA_ScriptInit()           )         ; Init the Scriptvariables
          || !( __WSA_Startup()              ) ) {     ; Fire up the WSA
        WS2_CleanUp()         ; Do a premature cleanup
        return -1             ; and return an error indication
    }
    ; check the URI if it's valid
    if (RegExMatch(__WSA_lpszHostName,"[^\d.]+")) ; Must be different than IP
    {
        WS2_IPAddress := __WSA_GetHostByName(__WSA_lpszHostName)
    } else {     ; Let's check if the IP is valid
        StringSplit,__WSA_tmpIPFragment, __WSA_lpszHostName,.
        Loop,4
            If (    ( __WSA_tmpIPFragment%A_Index%<0   ) 
                 || ( __WSA_tmpIPFragment%A_Index%>255 )
                 || ( __WSA_tmpIPFragment0!=4          ) ) {
                __WSA_IPerror = 1
                Break
            }
        If (__WSA_IPerror=1)
            __WSA_ErrMsg .= "No valid IP Supplied"
        else 
            WS2_IPAddress := __WSA_lpszHostName
    }

    ; CONVERSIONS

    ; The htons function returns the value in TCP/IP network byte order.
    ; http://msdn.microsoft.com/en-us/library/ms738557(VS.85).aspx
    __WSA_Port                := DllCall("Ws2_32\htons", "UShort", WS2_Port)

    ; The inet_addr function converts a string containing an IPv4 dotted-decimal 
    ; address into a proper address for the IN_ADDR structure.
    ; inet_addr: http://msdn.microsoft.com/en-us/library/ms738563(VS.85).aspx
    ; IN_ADDR:   http://msdn.microsoft.com/en-us/library/ms738571(VS.85).aspx
    __WSA_InetAddr           := DllCall("Ws2_32\inet_addr", "Str", WS2_IPAddress)

    If (     ( __WSA_Socket:=__WSA_Socket() )
          && ( __WSA_Connect()              )   ) 
        return __WSA_Socket   ; All went OK, return the SocketID
    Else {
        WS2_CleanUp()         ; Do a premature cleanup
        return -1             ; and return an error indication
    }
}

; WS2 OnMessage - This function defines, whatever should happen when
; a Message is received on the socket.
; Expected Parameter: 
;      Ws2_Socket    => Socket returned from WS2_Connect() Call
;      UDF           => An UserDefinedFunction to which the received 
;                       Data will be passed to
; Optional Parameter:
;      WindowMessage => A number indicating upon which WM_Message to react
;
; Returns -1 on error, 0 on success

WS2_AsyncSelect(Ws2_Socket,UDF,WindowMessage="") {
    Global __WSA_ErrMsg
    If (    ( StrLen(Ws2_Socket)=0 )
         || ( StrLen(UDF)=0        ) ) {
        res := -1
    } else {
        If (    (StrLen(WindowMessage)=0) 
             || (WindowMessage+0=0)      )
            WindowMessage := 0x5000
        res := __WSA_AsyncSelect(Ws2_Socket, UDF, WindowMessage)
    }
    return res
}   

WS2_SendData(WS2_Socket,DataToSend) {
    Global __WSA_ErrMsg
    If (__WSA_send(WS2_Socket, DataToSend)=-1) {
        
    }
}

; WS2 Cleanup - This needs to be called whenever Your Script exits
; Usually this is invoked by some OnExit, Label subroutines.
WS2_CleanUp() {
    DllCall("Ws2_32\WSACleanup")
}

; WS2 ScriptInit - for internal use only
; Initializes neccessary variables for this Script.
__WSA_ScriptInit()
{
    ; CONTANTS

    ; We're working with version 2 of Winsock
    Local VersionRequested    := 2
    ; from http://msdn.microsoft.com/en-us/library/ms742212(VS.85).aspx
    Local AF_INET             := 2
    Local SOCK_STREAM         := 1
    Local IPPROTO_TCP         := 6
    Local FD_READ             := 0x1
    Local FD_CLOSE            := 0x20

    __AI_PASSIVE              := 1

    __WSA_WSVersion           := VersionRequested
    __WSA_SocketType          := SOCK_STREAM
    __WSA_SocketProtocol      := IPPROTO_TCP
    __WSA_SocketAF            := AF_INET
    __WSA_lEvent              := FD_READ|FD_CLOSE

    __WSA_WOULDBLOCK          := 10035  ; http://www.sockets.com/err_lst1.htm#WSAECONNRESET
    __WSA_CONNRESET           := 10054  ; http://www.sockets.com/err_lst1.htm#WSAECONNRESET

    return 1
}

; WS2 Startup - for internal use only
; Initializes the Winsock 2 Adapter
__WSA_Startup()
{
    Global WSAData, __WSA_ErrMsg, __WSA_WSVersion

    ; It's a good idea, to have a __WSA_ErrMsg Container, so any Error Msgs
    ; may be catched by the script.
    __WSA_ErrMsg := ""

    ; Generate Structure for the lpWSAData 
    ; as stated on http://msdn.microsoft.com/en-us/library/ms742213.aspx
    ; More on WSADATA (structure) to be found here:
    ; http://msdn.microsoft.com/en-us/library/ms741563(VS.85).aspx
    VarSetCapacity(WSAData, 32)
    result := DllCall("Ws2_32\WSAStartup", "UShort", __WSA_WSVersion, "UInt", &WSAData)

    if (ErrorLevel)
        __WSA_ErrMsg .= "Ws2_32\WSAStartup could not be called due to error " ErrorLevel "`n"
                      . "Winsock 2.0 or higher is required.`n"
    if (result!=0) 
        __WSA_ErrMsg .= "Ws2_32\WSAStartup " __WSA_GetLastError()

    If (StrLen(__WSA_ErrMsg)>0)
        Return -1
    Else
        Return 1
}

; WS2 Socket Descriptor - for internal use only
; Sets type and neccessary structures for a successfull connection
__WSA_Socket()
{
    Global __WSA_ErrMsg, __WSA_SocketProtocol, __WSA_SocketType, __WSA_SocketAF

    ; Supposed to return a descriptor referencing the new socket
    ; http://msdn.microsoft.com/en-us/library/ms742212(VS.85).aspx
    __WSA_Socket := DllCall("Ws2_32\socket"
                            , "Int", __WSA_SocketAF
                            , "Int", __WSA_SocketType
                            , "Int", __WSA_SocketProtocol)
    if (socket = -1)
        __WSA_ErrMsg .= "Ws2_32\socket " __WSA_GetLastError()

    If (StrLen(__WSA_ErrMsg)>0)
        Return -1
    Else
        Return __WSA_Socket

}

; WS2 Connection call - for internal use only
; Establishes a connection to a foreign IP at the specified port
__WSA_Connect()
{
    Global __WSA_ErrMsg, __WSA_Port, __WSA_Socket, __WSA_InetAddr, __WSA_SocketAF

    ; Generate socketaddr structure for the connect()
    ; http://msdn.microsoft.com/en-us/library/ms740496(VS.85).aspx
    __WSA_SockAddrNameLen  := 16
    VarSetCapacity(__WSA_SockAddr, __WSA_SockAddrNameLen)
    NumPut(__WSA_SocketAF, __WSA_SockAddr, 0, "UShort")
    NumPut(__WSA_Port,     __WSA_SockAddr, 2, "UShort")
    NumPut(__WSA_InetAddr, __WSA_SockAddr, 4)

    ; The connect function establishes a connection to a specified socket.
    ; http://msdn.microsoft.com/en-us/library/ms737625(VS.85).aspx
    result := DllCall("Ws2_32\connect"
                        , "UInt", __WSA_Socket
                        , "UInt", &__WSA_SockAddr
                        , "Int" , __WSA_SockAddrNameLen)
    if (result)
        __WSA_ErrMsg .= "Ws2_32\connect " __WSA_GetLastError()

    If (StrLen(__WSA_ErrMsg)>0)
        Return -1
    Else
        Return 1
}


/*
 This code based originally upon an example by DarviK 
    http://www.autohotkey.com/forum/topic8871.html 
 and on the modifcations by Tasman
    http://www.autohotkey.com/forum/viewtopic.php?t=9937
*/
; Resolves canonical domainname to IP
__WSA_GetHostByName(url)
{
    Global __WSA_ErrMsg
    ; gethostbyname returns information about a domainname into a Hostent Structure
    ; http://msdn.microsoft.com/en-us/library/ms738524(VS.85).aspx
    IP := ""
    if ((PtrHostent:=DllCall("Ws2_32\gethostbyname","str",url)) != 0) {
        Loop, 1 ; 3 is max No of retrieved addresses
            If (PtrTmpIP := NumGet(NumGet(PtrHostent+12)+(offset:=(A_Index-1)*4),offset)) {
                IP := (IP) ? IP "|" : ""
                Loop, 4 ; Read our IP address
                    IP .= NumGet(PtrTmpIP+offset,(A_Index-1 ),"UChar") "."
                IP := SubStr(IP,1,-1)
            } else ; No more IPs left
                Break
        result := IP
    } else {
        __WSA_ErrMsg .= "Ws2_32\gethostbyname failed`n "
        result := -1
    }
    return result
}

; Return the last Error with a lil bit o' text if neccessary
; Note: the txt variable is set to 0 when checking for received content
__WSA_GetLastError(txt=1)
{
    Err       := DllCall("Ws2_32\WSAGetLastError")
    ExtraInfo := __WSA_ErrLookUp(RegExReplace(Err,"[^\d]"))
    If ((InStr(ExtraInfo,"Sorry, no")) || (txt!=1))
        ExtraInfo := ""
    Return ( txt ? "indicated Winsock error " : "") 
           . Err
           . ( txt ? "`n" ExtraInfo : "")
}

; WS2 AsyncSelect - for internal use only
; Sets up an Notification Handler for Receiving Messages
; Expected Parameters: Socket from Initialisation
; Optional: NotificationMsg   - default 0x5000
;           WSA_DataReiceiver - an different Name to standard
;                               wm_* processor function.
;                               default __WSA_ReceiveData
; Returns -1 on Error, 0 on success
__WSA_AsyncSelect(__WSA_Socket, UDF, __WSA_NotificationMsg=0x5000
                              ,__WSA_DataReceiver="__WSA_recv")
{
    Global

    __WSA_UDF := UDF

    OnMessage(__WSA_NotificationMsg, __WSA_DataReceiver)
    ; The WSAAsyncSelect function requests Windows message-based notification 
    ; of network events for a socket.
    ; http://msdn.microsoft.com/en-us/library/ms741540(VS.85).aspx
    Result := DllCall("Ws2_32\WSAAsyncSelect"
                , "UInt", __WSA_Socket
                , "UInt", __WSA_GetThisScriptHandle()
                , "UInt", __WSA_NotificationMsg
                , "Int",  __WSA_lEvent)
    if (Result) {
        __WSA_ErrMsg .= "Ws2_32\WSAAsyncSelect() " . __WSA_GetLastError()
        Result := -1
    }
    Return Result
}

; WS2 Receive - for internal use only
; Triggers upon Notification Handler when Receiving Messages
__WSA_recv(wParam, lParam)
{
    Global __WSA_UDF, __WSA_ErrMsg, ChatCon, NickName, Channel, Sender
    ; __WSA_UDF containes the name of the UserDefinedFunction to call when the event 
    ; has been triggered and text may be processed (allthough the reveived text might
    ; be inclomplete, especially when receiving large chunks of data, like in eMail-
    ; attachments or sometimes in IRC). The UDF needs to accept two parameter: socket
    ; and the received buffer
    
    __WSA_Socket := wParam
    __WSA_BufferSize = 4096
    Loop
    {
        VarSetCapacity(__WSA_Buffer, __WSA_BufferSize, 0)
        __WSA_BufferLength := DllCall("Ws2_32\recv"
                                        , "UInt", __WSA_Socket
                                        , "Str",  __WSA_Buffer
                                        , "Int",  __WSA_BufferSize
                                        , "Int",  0 )
        if (__WSA_BufferLength = 0)
            break
        if (__WSA_BufferLength = -1){
            __WSA_Err := __WSA_GetLastError(0)
            ; __WSA_WOULDBLOCK (from http://www.sockets.com/)
            ; The socket is marked as non-blocking (non-blocking operation mode), and 
            ; the requested operation is not complete at this time. The operation is 
            ; underway, but as yet incomplete. 
            if (__WSA_Err = 10035)
                return 1

            ; __WSA_CONNRESET: (from http://www.sockets.com/)
            ; A connection was forcibly closed by a peer. This normally results from 
            ; a loss of the connection on the remote socket due to a timeout or a reboot. 
            if (__WSA_Err != 10054)
                __WSA_ErrMsg .= "Ws2_32\recv indicated Winsock error " __WSA_Err "`n"
            Else
                Quit()
                Control, Disable,, Sender
				RichEdit_SetText(Chat1, "`r`nRe-Connecting...`r`n", "SELECTION", -1)
                MsgBox, Your connection has timed out. Please wait until reconnected to continute with chat. This will take a moment. win, receive
                CONNECT(NickName, "dylan904", NickName, "", "irc.freenode.net", 6667)
                JOIN(Channel)
                ROMF("Message_Recieved")
            break
        }

        if (StrLen(__WSA_UDF)!=0) ; If set, call UserDefinedFunction and pass Buffer to it
            %__WSA_UDF%(__WSA_Socket,__WSA_Buffer) 
    }
    return 1
}



; WSA Send - for internal use only
; Users are encouraged to use the WS2_SendData() Function
__WSA_send(__WSA_Socket, __WSA_Data)
{
    Global __WSA_ErrMsg

    Result := DllCall("Ws2_32\send"
                       , "UInt", __WSA_Socket
                       , "Str",  __WSA_Data
                       , "Int", StrLen(__WSA_Data)
                       , "Int", 0)
   If (Result = -1)
      __WSA_ErrMsg .=  "Ws2_32\send " __WSA_GetLastError()
   Return Result
}

; Closes Open Socket - for internal use only
; Returns 0 on success
__WSA_CloseSocket(__WSA_Socket)
{
    Global __WSA_ErrMsg

    Result := DllCall("Ws2_32\closesocket"
                       , "UInt", __WSA_Socket)
    If (Result != 0)
      __WSA_ErrMsg .=  "Ws2_32\closesocket " __WSA_GetLastError()

    Return result
}

; GetThisScriptHandle - for internal use only
; Returns the handle of the executing script
__WSA_GetThisScriptHandle()
{
    HiddenWindowsSave := A_DetectHiddenWindows
    DetectHiddenWindows On
    ScriptMainWindowId := WinExist("ahk_class AutoHotkey ahk_pid " DllCall("GetCurrentProcessId"))
    DetectHiddenWindows %HiddenWindowsSave%
    Return ScriptMainWindowId
}

; Lookup Winsock ErrCode - for internal use only
; This list is form http://www.sockets.com
__WSA_ErrLookUp(sNumber) {
WSA_ErrorList =
(LTrim Join`n
    10004 - Interrupted system call
    10009 - Bad file number
    10013 - Permission denied
    10014 - Bad address
    10022 - Invalid argument
    10024 - Too many open files
    10035 - Operation would block
    10036 - Operation now in progress
    10037 - Operation already in progress
    10038 - Socket operation on non-socket
    10039 - D   estination address required
    10040 - Message too long
    10041 - Protocol wrong type for socket
    10042 - Bad protocol option
    10043 - Protocol not supported
    10044 - Socket type not supported
    10045 - Operation not supported on socket
    10046 - Protocol family not supported
    10047 - Address family not supported by protocol family
    10048 - Address already in use
    10049 - Can't assign requested address
    10050 - Network is down
    10051 - Network is unreachable
    10052 - Net dropped connection or reset
    10053 - Software caused connection abort
    10054 - Connection reset by peer
    10055 - No buffer space available
    10056 - Socket is already connected
    10057 - Socket is not connected
    10058 - Can't send after socket shutdown
    10059 - Too many references, can't splice
    10060 - Connection timed out
    10061 - Connection refused
    10062 - Too many levels of symbolic links
    10063 - File name too long
    10064 - Host is down
    10065 - No Route to Host
    10066 - Directory not empty
    10067 - Too many processes
    10068 - Too many users
    10069 - Disc Quota Exceeded
    10070 - Stale NFS file handle
    10091 - Network SubSystem is unavailable
    10092 - WINSOCK DLL Version out of range
    10093 - Successful WSASTARTUP not yet performed
    10071 - Too many levels of remote in path
    11001 - Host not found
    11002 - Non-Authoritative Host not found
    11003 - Non-Recoverable errors: FORMERR, REFUSED, NOTIMP
    11004 - Valid name, no data record of requested type
    11004 - No address, look for MX record 
)
ExNr := 0, ExErr := "Sorry, but no definition available."
Loop,Parse,WSA_ErrorList,`n
{
    RegExMatch(A_LoopField,"(?P<Nr>\d+) - (?P<Err>.*)",Ex)
    if (sNumber = ExNr)
        break
}
Return ExNr " means " ExErr "`n"
}
; WinINet InternetCrackURL - for internal use only
; v 0.1 / (w) 25.07.2008 by derRaphael / zLib-Style release
; This routine was originally posted here:
; http://www.autohotkey.com/forum/viewtopic.php?p=209957#209957
__WinINet_InternetCrackURL(lpszUrl,arrayName="URL")
{
    local hModule, offset_name_length
    hModule := DllCall("LoadLibrary", "Str", "WinINet.Dll")

    ; SetUpStructures for URL_COMPONENTS / needed for InternetCrackURL
    ; http://msdn.microsoft.com/en-us/library/aa385420(VS.85).aspx
    offset_name_length:= "4-lpszScheme-255|16-lpszHostName-1024|28-lpszUserName-1024|"
                       . "36-lpszPassword-1024|44-lpszUrlPath-1024|52-lpszExtrainfo-1024"

    VarSetCapacity(URL_COMPONENTS,60,0)
    ; Struc Size               ; Scheme Size                  ; Max Port Number
    NumPut(60,URL_COMPONENTS,0), NumPut(255,URL_COMPONENTS,12), NumPut(0xffff,URL_COMPONENTS,24)
    Loop,Parse,offset_name_length,|
    {
        RegExMatch(A_LoopField,"(?P<Offset>\d+)-(?P<Name>[a-zA-Z]+)-(?P<Size>\d+)",iCU_)
        VarSetCapacity(%iCU_Name%,iCU_Size,0)
        NumPut(&%iCU_Name%,URL_COMPONENTS,iCU_Offset)
        NumPut(iCU_Size,URL_COMPONENTS,iCU_Offset+4)
    }

    ; Split the given URL; extract scheme, user, pass, authotity (host), port, path, and query (extrainfo)
    ; http://msdn.microsoft.com/en-us/library/aa384376(VS.85).aspx
    DllCall("WinINet\InternetCrackUrlA","Str",lpszUrl,"uInt",StrLen(lpszUrl),"uInt",0,"uInt",&URL_COMPONENTS)
    ; Update variables to retrieve results
    Loop,Parse,offset_name_length,|
    {
        RegExMatch(A_LoopField,"-(?P<Name>[a-zA-Z]+)-",iCU_)
        VarSetCapacity(%iCU_Name%,-1)
        %arrayName%_%iCU_Name% := % %iCU_Name%
    }
    %arrayName%_nPort:=NumGet(URL_COMPONENTS,24,"uInt")
    DllCall("FreeLibrary", "UInt", hModule)                    ; unload the library
}

/* Title:		RichEdit

				This module allows you to create and programmatically set text properties in rich edit control.
				Besides that, it contains functions that work with standard edit controls. Each function contains
				description for which kind of control it can be used - any control supporting edit control interface
				(Edit, RichEdit, HiEdit...) or just rich edit control.
 */

/*
 Function:		Add
				Create rich edit version 4.1 control. (requires at least Windows XP SP1)

 Parameters:
				HParent	- Handle of the parent of the control.
				X..H	- Position.
				Style	- White space separated list of control styles. Any integer style or one of the style keywords (see below).
						  Invalid styles are skipped. "*MULTILINE WANTRETURN VSCROLL*" by default.
				Text	- Control text.

 Styles:
     DISABLENOSCROLL - Disables scroll bars instead of hiding them when they are not needed.
     BORDER			- Displays the control with a sunken border style so that the rich edit control appears recessed into its parent window.
     HIDDEN			- Don't show the control.
     VSCROLL		- Enble vertical scroll bar.
     HSCROLL		- Enable horizontal scroll bar. If this style is present control starts with wrap mode deactivated. Otherwise, wrap mode is active.
     SCROLL			- Enable both scroll bars.
     AUTOHSCROLL	- Automatically scrolls text to the right by 10 characters when the user types a character at the end of the line. When the user presses the ENTER key, the control scrolls all text back to position zero.
     AUTOVSCROLL	- Automatically scrolls text up one page when the user presses the ENTER key on the last line.
     CENTER			- Centers text in a single-line or multiline edit control.
     LEFT			- Left aligns text.
     MULTILINE		- Designates a multiline edit control. The default is single-line edit control.
     NOHIDESEL		- Negates the default behavior for an edit control. The default behavior hides the selection when the control loses the input focus and inverts the selection when the control receives the input focus. If you specify *NOHIDESEL*, the selected text is inverted, even if the control does not have the focus.
     NUMBER			- Allows only digits to be entered into the edit control.
     PASSWORD		- Displays an asterisk (*) for each character typed into the edit control. This style is valid only for single-line edit controls.
     READONLY		- Prevents the user from typing or editing text in the edit control.
     RIGHT			- Right aligns text in a single-line or multiline edit control.
     SELECTIONBAR	- When set, there is small left margin (wider than default) where cursor changes to right-up arrow allowing full line(s) selection. This style also requires use of *MULTILINE* style.
     WANTRETURN		- Specifies that a carriage return be inserted when the user presses the ENTER key while entering text into a multiline edit control in a dialog box. If you do not specify this style, pressing the ENTER key has the same effect as pressing the dialog box's default push button. This style has no effect on a single-line edit control.

 Returns:
	Control's handle or 0. Error message on problem.

 Example:
 (start code)
  Gui, +LastFound
  hwnd := WinExist()
  hRichEdit := RichEdit_Add(hwnd, 5, 5, 200, 300)
  Gui, Show, w210 h310
 (end code)
 */
RichEdit_Add(HParent, X="", Y="", W="", H="", Style="", Text="")  {
  static WS_CLIPCHILDREN=0x2000000, WS_VISIBLE=0x10000000, WS_CHILD=0x40000000
		,ES_DISABLENOSCROLL=0x2000, EX_BORDER=0x200
		,ES_LEFT=0, ES_CENTER=1, ES_RIGHT=2, ES_MULTILINE=4, ES_AUTOVSCROLL=0x40, ES_AUTOHSCROLL=0x80, ES_NOHIDESEL=0x100, ES_NUMBER=0x2000, ES_PASSWORD=0x20,ES_READONLY=0x800,ES_WANTRETURN=0x1000  ;, ES_SELECTIONBAR = 0x1000000
		,ES_HSCROLL=0x100000, ES_VSCROLL=0x200000, ES_SCROLL=0x300000
		,MODULEID

	if !MODULEID
		init := DllCall("LoadLibrary", "Str", "Msftedit.dll", "Uint"), MODULEID := 091009


	ifEqual, Style,, SetEnv, Style, MULTILINE WANTRETURN VSCROLL
	hStyle := InStr(" " Style " ", " hidden ") ? 0 : WS_VISIBLE,  hExStyle := 0
	Loop, parse, Style, %A_Tab%%A_Space%
	{
		IfEqual, A_LoopField, ,continue
		else if A_LoopField is integer
			 hStyle |= A_LoopField
		else if (v := ES_%A_LOOPFIELD%)
			 hStyle |= v
		else if (v := EX_%A_LOOPFIELD%)
			 hExStyle |= v
		else if (A_LoopField = "SELECTIONBAR")
       selectionbar := true
		else continue
	}
	/*
		class   := A_OSVersion = "WIN_95" ? "RICHEDIT" : "RichEdit20A"
		hModule := DllCall("LoadLibrary", "str",  (class="RichEdit20A" ? "riched20.dll" : "riched32.dll")  )

		http://www.soulfree.net/tag/391
		RE version - DLL (hModule)- class
		1.0	       - Riched32.dll - RichEdit
		2.0	       - Riched20.dll - RichEdit20A or RichEdit20W (ANSI or Unicode window classes)
		3.0	       - Riched20.dll - ?
		4.1	       - Msftedit.dll - RICHEDIT50W

		2.0 not compatible w/ EM_CONVPOSITION, EM_GETIMECOLOR, EM_GETIMEOPTIONS, EM_GETPUNCTUATION,
		  EM_GETWORDWRAPMODE, EM_SETIMECOLOR, EM_SETIMEOPTIONS, EM_SETPUNCTUATION, EM_SETWORDWRAPMODE

		Windows XP SP1	Includes Rich Edit 4.1, Rich Edit 3.0, and a Rich Edit 1.0 emulator.
		Windows XP	Includes Rich Edit 3.0 with a Rich Edit 1.0 emulator.
		Windows Me	Includes Rich Edit 1.0 and 3.0.
		Windows 2000	Includes Rich Edit 3.0 with a Rich Edit 1.0 emulator.
		Windows NT 4.0	Includes Rich Edit 1.0 and 2.0.
		Windows 98	Includes Rich Edit 1.0 and 2.0.
		Windows 95	Includes only Rich Edit 1.0. However, Riched20.dll is compatible with Windows 95 and may be installed by an application that requires it.
     */

	hCtrl := DllCall("CreateWindowEx"
                  , "Uint", hExStyle			; ExStyle
                  , "str" , "RICHEDIT50W"		; ClassName
                  , "str" , Text				; WindowName
                  , "Uint", WS_CHILD | hStyle	; Edit Style
                  , "int" , X					; Left
                  , "int" , Y					; Top
                  , "int" , W					; Width
                  , "int" , H					; Height
                  , "Uint", HParent				; hWndParent
                  , "Uint", MODULEID			; hMenu
                  , "Uint", 0					; hInstance
                  , "Uint", 0, "Uint")			; must return uint.
	return hCtrl,  selectionbar ? RichEdit_SetOptions( hCtrl, "OR", "SELECTIONBAR" ) : ""
}

/*
  Function:  AutoUrlDetect
 			 Enable, disable, or toggle automatic detection of URLs in the RichEdit control.

  Parameters:
 			Flag - Specify true to enable automatic URL detection or false to disable it. Specify
             *"^"* to toggle its current state. Omit to only return current state without any change.

  Returns:
 			If auto-URL detection is active, the return value is 1.
 			If auto-URL detection is inactive, the return value is 0.

 Example:
 (start code)
  MsgBox, % RichEdit_AutoUrlDetect( hRichEdit, true )
  MsgBox, % RichEdit_AutoUrlDetect( hRichEdit, "^" )
  MsgBox, % "Current state: " RichEdit_AutoUrlDetect( hRichEdit )
 (end code)
 */
RichEdit_AutoUrlDetect(HCtrl, Flag="" )  {	;wParam Specify TRUE to enable automatic URL detection or FALSE to disable it.
	static EM_AUTOURLDETECT=0x45B, EM_GETAUTOURLDETECT=0x45C

	If (Flag = "") || (Flag ="^") {
		SendMessage, EM_GETAUTOURLDETECT,,,,ahk_id %HCtrl%
		ifEqual, Flag,, return ERRORLEVEL
		Flag := !ERRORLEVEL
	}
	SendMessage, EM_AUTOURLDETECT, Flag,,, ahk_id %HCtrl%
	return Flag
}

/*
 Function: CanPaste
           Determines whether an Edit control can paste a specified clipboard format.

 Parameters:
           ClipboardFormat - Specifies the Clipboard Formats to try. To try any format currently on the clipboard, set this parameter to zero.
							 The default is 0x1 (CF_TEXT).

 Returns:
           True if the clipboard format can be pasted otherwise false.

 Remarks:
           For additional information on clipboard formats, see the following:
           <http://msdn.microsoft.com/en-us/library/ms649013(VS.85).aspx>

 Related:
		<Paste>, <PasteSpecial>

 Example:
 (start code)
  If RichEdit_CanPaste( hRichEdit, 0 )
    RichEdit_Paste( hRichEdit )
  Else
    MsgBox, Cannot paste your clipboard into control..
 (end code)
 */
RichEdit_CanPaste(hEdit, ClipboardFormat=0x1) {
    Static EM_CANPASTE := 1074
    SendMessage EM_CANPASTE,ClipboardFormat,0,,ahk_id %hEdit%
    return ErrorLevel
}

/*
 Function: CharFromPos
           Gets information about the character closest to a specified point in the client area of the Edit control.

 Parameters:
           X, Y - The coordinates of a point in the Edit control's client area relative to the upper-left corner of the client area.

 Returns:
           The character index of the specified point or the character index to
           the last character if the given point is beyond the last character in the control.
 */
RichEdit_CharFromPos(hEdit,X,Y) {
    Static EM_CHARFROMPOS:=0xD7

	WinGetClass, cls, ahk_id %hEdit%
	if cls in RICHEDIT50W
		 VarSetCapacity(POINTL, 8), lParam := &POINTL, NumPut(X, POINTL), NumPut(Y,POINTL)
	else lParam := (Y<<16)|X

    SendMessage EM_CHARFROMPOS,,lParam,,ahk_id %hEdit%
    return ErrorLevel
}

/*
 Function:	Clear
    Send to an Edit control or combo box to delete (clear) the current selection.

 Remarks:
    To delete the current selection and place the deleted content on the clipboard, use the Cut operation.
			
 Related:
    <Cut>, <Copy>, <Paste>
 */
RichEdit_Clear(hEdit) {
    static WM_CLEAR=0x303
    SendMessage WM_CLEAR,,,,ahk_id %hEdit%
}

/*
 Function:		Convert
				Convert twips to pixels or vice-versa.

 Parameters:
				Input		- Twips (Input>0) or pixels (Input<0).
				Direction	- 0 (default) or 1. Pixels are not always square (the height and width are not the same).
							  Therefore, it is necessary to pass in the desired "direction" to use, horizontal (0) or vertical (1).
 Returns:
				Rounded value.
 */
RichEdit_Convert(Input, Direction=0) {
	static twipsPerInch = 1440, LOGPIXELSX=88, LOGPIXELSY=90, tpi0, tpi1

	if !tpi0
		dc := DllCall("GetDC", "uint", 0, "Uint")
		, tpi0 := DllCall("gdi32.dll\GetDeviceCaps", "uint", dc, "int", LOGPIXELSX)
		, tpi1 := DllCall("gdi32.dll\GetDeviceCaps", "uint", dc, "int", LOGPIXELSY)
		, DllCall("ReleaseDC", "uint", 0, "uint", dc)

   return (Input>0) ? (Input * tpi%Direction%) // twipsPerInch  : (-Input*twipsPerInch) // tpi%Direction%
}

/*
 Function: Copy
    Copy selection of the Edit control.

 Related:
		<Cut>, <Clear>, <Paste>
 */
RichEdit_Copy(hEdit) {
    Static WM_COPY:=0x301
    SendMessage WM_COPY,0,0,,ahk_id %hEdit%
}

/*
 Function: Cut
    Cut selection from the Edit control.

 Related:
    <Copy>, <Clear>, <Paste>
 */
RichEdit_Cut(hEdit) {
    Static WM_CUT:=0x300
    SendMessage WM_CUT,,,,ahk_id %hEdit%
}

/*
 Function:	FindText
			Find desired text in the Edit control.

 Parameters:
			Text	- Text to be searched for.
			CpMin	- Start searching at this character position. By default 0.
			CpMax	- End searching at this character position. When searching forward, a value of �1 extends the search range to the end of the text.
			Flags	- Space separated combination of search flags. See below.

 Flags:
			WHOLEWORD	- If set, the operation searches only for whole words that match the search string. If not set, the operation also searches for word fragments that match the search string.
			MATCHCASE	- If set, the search operation is case-sensitive. If not set, the search operation is case-insensitive.
			DOWN		- Rich Edit only: If set, the search is from the end of the current selection to the end of the document.
						  If not set, the search is from the end of the current selection to the beginning of the document.
			UNICODE		- Transforms Text into the Unicode charset before searching for it.
 Returns:
			The zero-based character position of the next match, or -1 if there are no more matches.

 Remarks
			The *CpMin* member always specifies the starting-point of the search, and *CpMax* specifies the end point.
			When searching backward, *CpMin* must be equal to or greater than *CpMax*.

 Example:
 (start code)
  ^f::
    RichEdit_HideSelection( hRichEdit, false )
    Dlg_Find( hwnd, "OnFind", "d" )
  return

  OnFind(Event, Flags, FindText, ReplaceText)  {
    global hRichEdit

    IfNotEqual, Event, F,  return
    RichEdit_GetSel(hRichEdit, min, max)
    word := InStr(Flags,"w") ? " WHOLEWORD" : ""
    case := InStr(Flags,"c") ? " MATCHCASE" : ""
    InStr( Flags, "d" ) ? (pos:=max+1 , direction:=" DOWN")
                        : (pos:=max-1)

    ; search control for word
    pos:=RichEdit_FindText(hRichEdit,FindText,pos,-1,"unicode" direction word case)

    ; highlight found match
  	if pos != -1
  		RichEdit_SetSel(hRichEdit, pos, pos+StrLen(FindText))

  	Else
      MsgBox, no matches found..
  }
  return
 (end code)
 */
RichEdit_FindText(hEdit, Text, CpMin=0, CpMax=-1, Flags="UNICODE") {
	static EM_FINDTEXT=1080, FR_DOWN=1, FR_WHOLEWORD=2, FR_MATCHCASE=4, FR_UNICODE=0
	hFlags := 0
	loop, parse, Flags, %A_Tab%%A_Space%,
		ifEqual, A_LoopField,,continue
		else hFlags |= FR_%A_LOOPFIELD%

	If InStr(Flags, "Unicode") {
		VarSetCapacity( uText, (len:=StrLen(Text))*2+1), DllCall( "MultiByteToWideChar", "Int",0,"Int",0,"Str",Text,"UInt",len,"Str", uText, "UInt", len )
		txtAdr := &uText
	} else txtAdr := &Text

	VarSetCapacity(FT, 12)
	NumPut(CpMin,   FT, 0)
	NumPut(CpMax,   FT, 4)
	NumPut(txtAdr,  FT, 8)

	SendMessage, EM_FINDTEXT, hFlags, &FT,, ahk_id %hEdit%
	Return ErrorLevel=4294967295 ? -1 : ErrorLevel
}

/*
 Function:	FindWordBreak
			Finds the next word break in rich edit conttrol, before or after the specified character position or retrieves information about the character at that position.

 Parameters:
		    CharIndex	- Zero-based character starting position.
			Flag		- One of the flags list below.

 Flag:
			CLASSIFY	- Returns the character class and word-break flags of the character at the specified position.
			ISDELIMITER - Returns true if the character at the specified position is a delimiter, or false otherwise.
			LEFT		- Finds the nearest character before the specified position that begins a word.
			LEFTBREAK	- Finds the next word end before the specified position. This value is the same as PREVBREAK.
			MOVEWORDLEFT  - Finds the next character that begins a word before the specified position. This value is used during CTRL+LEFT ARROW key processing.
			MOVEWORDRIGHT - Finds the next character that begins a word after the specified position. This value is used during CTRL+right key processing.
			RIGHT		- Finds the next character that begins a word after the specified position.
			RIGHTBREAK	- Finds the next end-of-word delimiter after the specified position. This value is the same as NEXTBREAK.

 Returns:
		  The message returns a value based on the wParam parameter.
			o CLASSIFY		- Returns the character class and word-break flags of the character at the specified position.
			o ISDELIMITER	- Returns true if the character at the specified position is a delimiter, otherwise it returns false.
			o Other			- Returns the character index of the word break.
 */
RichEdit_FindWordBreak(hCtrl, CharIndex, Flag="")  {
	static  EM_FINDWORDBREAK=1100
			, WB_CLASSIFY=3, WB_ISDELIMITER=2, WB_LEFT=0, WB_LEFTBREAK=6, WB_MOVEWORDLEFT=4, WB_MOVEWORDNEXT=5, WB_MOVEWORDPREV=4, WB_MOVEWORDRIGHT=5, WB_NEXTBREAK=7, WB_PREVBREAK=6, WB_RIGHT=1, WB_RIGHTBREAK=7

	SendMessage, EM_FINDWORDBREAK, WB_%Flag%, CharIndex,, ahk_id %hCtrl%
	return ErrorLevel
}

/*
 Function: FixKeys
	  	   Fix Tab and Esc key handling in rich edit control.

 Returns:
		  True or false.

 Remarks:
	Whenever you press Escape in a multiline edit control it sends a WM_CLOSE message to its parent. Both the regular edit control and the rich edit control have this problem.
	This is by Microsoft design. There is also similar undesired behavior for {Tab} key which is used by the system to navigate over controls with "tabstop" flag. RichEdit is designed
	to use ^{Tab} instead. This function subclasses the control to prevent such behavior.

	However, before using this function be sure to know what subclassing is and what kind of effects
	it may introduce to your particular script. There is also other method to solve this problem via
	hotkey handling while rich edit control has focus.

 Reference:
	o WM_GETDLGCODE @ MSDN: <http://msdn.microsoft.com/en-us/library/ms645425(VS.85).aspx>
	o William Willing blog: <http://www.williamwilling.com/blog/?p=28>.
	o WinAsm Forum: <http://www.winasm.net/forum/index.php?showtopic=487>.
	o CodeGuru: <http://www.codeguru.com/cpp/controls/editctrl/keyboard/article.php/c513/>.
	o Strange Microsoft solution for VB (that doesn't work): <http://support.microsoft.com/kb/q143273/>.
 */
RichEdit_FixKeys(hCtrl) {
	oldProc := DllCall("GetWindowLong", "uint", hCtrl, "uint", -4)
	ifEqual, oldProc, 0, return 0
	wndProc := RegisterCallback("RichEdit_wndProc", "", 4, oldProc)
	ifEqual, wndProc, , return 0
	return DllCall("SetWindowLong", "UInt", hCtrl, "Int", -4, "Int", wndProc, "UInt")
}

RichEdit_GetFirstVisibleLine(hCtrl) {
	static EM_GETFIRSTVISIBLELINE = 0xCE
	SendMessage, EM_GETFIRSTVISIBLELINE, 0, 0, , ahk_id %hCtrl%
	return ErrorLevel
}

/*
 Function: GetLine
			Get the text of the desired line from an Edit control.

 Parameters:
			LineNumber	- Zero-based index of the line. -1 means current line.

 Returns:
			The return value is the text.
			The return value is empty string if the line number specified by the line parameter is greater than the number of lines in the Edit control.

 Related:
     <GetText>, <LineIndex>, <LineLength>
 */
RichEdit_GetLine(hEdit, LineNumber=-1){
	static EM_GETLINE=196	  ;The return value is the number of characters copied. The return value is zero if the line number specified by the line parameter is greater than the number of lines in the HiEdit control

	if (LineNumber = -1)
		LineNumber := RichEdit_LineFromChar(hEdit, RichEdit_LineIndex(hEdit))
	len := RichEdit_LineLength(hEdit, LineNumber)
	ifEqual, len, 0, return	

	VarSetCapacity(txt, len * (A_IsUnicode ? 2 : 1), 0), NumPut(len, txt)
	SendMessage, EM_GETLINE, LineNumber, &txt,, ahk_id %hEdit%
	if ErrorLevel = FAIL
		return "", ErrorLevel := A_ThisFunc "> Failed to get line with code " A_LastError

	VarSetCapacity(txt, -1)
	return txt
}

/*
 Function:	GetLineCount
			Gets the number of lines in a multiline Edit control.

 Returns:
			The return value is an integer specifying the total number of text lines in the multiline edit control or rich edit control.
			If the control has no text, the return value is 1. The return value will never be less than 1.

 Remarks:
			The function retrieves the total number of text lines, not just the number of lines that are currently visible.
			If the Wordwrap feature is enabled, the number of lines can change when the dimensions of the editing window change.

 Related:
     <GetTextLength>, <LineLength>
 */
RichEdit_GetLineCount(hEdit){
	static EM_GETLINECOUNT=0xBA
 	SendMessage, EM_GETLINECOUNT,,,, ahk_id %hEdit%
	Return ErrorLevel
}

/*
 Function:	GetOptions
			Get the options for a rich edit control.

 Remarks:
			See <SetOptions> for details.
 */
RichEdit_GetOptions(hCtrl)  {
	static  EM_GETOPTIONS=1102
			,1="AUTOWORDSELECTION", 64="AUTOVSCROLL", 128="AUTOHSCROLL",  256="NOHIDESEL", 2048="READONLY", 4096="WANTRETURN", 16777216="SELECTIONBAR"
			,options="1,64,128,256,2048,4096,16777216"

	if (hCtrl > 1) {
		SendMessage, EM_GETOPTIONS,,,, ahk_id %hCtrl%
		o := ErrorLevel
	} else o := SubStr(hCtrl, 2)

	loop, parse, options, `,
		if (o & A_LoopField)
			res .= %A_LoopField% " "

	return SubStr(res, 1, -1)
}

/*
 Function:	GetCharFormat
			Determines the character formatting in a rich edit control.

 Parameters:
			Face	- Optional byref parameter will contain the name of the font.
			Style	- Optional byref parameter will contain a space separated list
					  of styles. See <SetCharFormat> for list of styles.
			TextColor		- Text forground color. If starts with "-" the color is AUTOCOLOR.
			BackColor		- Text background color. If starts with "-" the color is AUTOCOLOR.
			Mode	- If empty, this optional parameter retrieves the formatting to all text in the
					  control. Otherwise, pass "SELECTION" (default) to get formatting of the current selection. If the selection
					  is empty, the function will get the character of the insertion point.

 Remarks:
		Function will get the attributes of the first character.

 Related:
		<SetCharFormat>, <SetBgColor>
 
 Example:
 (start code)
  RichEdit_GetCharFormat(hRichEdit, face, style, color)
  MsgBox, Face = %Face% `nstyle = %style%  `ncolor = %color%
 (end code)
 */
RichEdit_GetCharFormat(hCtrl, ByRef Face="", ByRef Style="", ByRef TextColor="", ByRef BackColor="", Mode="SELECTION")  {
	static EM_GETCHARFORMAT=1082, SCF_SELECTION=1
  		  , CFM_CHARSET:=0x8000000, CFM_BACKCOLOR=0x4000000, CFM_COLOR:=0x40000000, CFM_FACE:=0x20000000, CFM_OFFSET:=0x10000000, CFM_SIZE:=0x80000000, CFM_WEIGHT=0x400000, CFM_UNDERLINETYPE=0x800000
		  , CFE_HIDDEN=0x100, CFE_BOLD=1, CFE_ITALIC=2, CFE_LINK=0x20, CFE_PROTECTED=0x10, CFE_STRIKEOUT=8, CFE_UNDERLINE=4, CFE_SUPERSCRIPT=0x30000, CFE_SUBSCRIPT=0x30000
		  , CFM_ALL2=0xFEFFFFFF, COLOR_WINDOW=5, COLOR_WINDOWTEXT=8
		  , styles="HIDDEN BOLD ITALIC LINK PROTECTED STRIKEOUT UNDERLINE SUPERSCRIPT SUBSCRIPT", StrGet = "StrGet"

	VarSetCapacity(CF, 84, 0), NumPut(84, CF), NumPut(CFM_ALL2, CF, 4)
	SendMessage, EM_GETCHARFORMAT, SCF_%Mode%, &CF,, ahk_id %hCtrl%
;	HexView(&CF, 84)

	Face := DllCall("MulDiv", "UInt", &CF+26, "Int",1, "Int",1, A_IsUnicode ? "astr" : "str")

	Style := "", dwEffects := NumGet(CF, 8, "UInt")
	Loop, parse, styles, %A_SPACE%
		if (CFE_%A_LoopField% & dwEffects)
			Style .= A_LoopField " "
    s := NumGet(CF, 12, "Int") // 20,  o := NumGet(CF, 16, "Int")
	Style .= "s" s (o ? " o" o : "")

	oldFormat := A_FormatInteger
    SetFormat, integer, hex
	
	if (dwEffects & CFM_BACKCOLOR)
		 BackColor := "-" DllCall("GetSysColor", "int", COLOR_WINDOW)
	else BackColor := NumGet(CF, 64), BackColor := (BackColor & 0xff00) + ((BackColor & 0xff0000) >> 16) + ((BackColor & 0xff) << 16)

	if (dwEffects & CFM_COLOR)
		 TextColor := "-" DllCall("GetSysColor", "int", COLOR_WINDOWTEXT)
	else TextColor := NumGet(CF, 20), TextColor := (TextColor & 0xff00) + ((TextColor & 0xff0000) >> 16) + ((TextColor & 0xff) << 16)

    SetFormat, integer, %oldFormat%
}

/*
  Function: GetRedo
 			Determine whether there are any actions in the rich edit control redo queue, and
			optionally retrieve the type of the next redo action.

  Parameters:
 			name - This optional parameter is the name of the variable in which to store the
             type of redo action, if any.

  Name Types:
      UNKNOWN - The type of undo action is unknown.
      TYPING - Typing operation.
      DELETE - Delete operation.
      DRAGDROP - Drag-and-drop operation.
      CUT - Cut operation.
      PASTE - Paste operation.

  Returns:
 			If there are actions in the control redo queue, the return value is a nonzero value.
 			If the redo queue is empty, the return value is zero.

  Related:
		<Redo>, <GetUndo>, <Undo>, <SetUndoLimit>

 Example:
 (start code)
  If RichEdit_GetRedo( hRichEdit, name )
    MsgBox, The next redo is a %name% type
  Else
    MsgBox, Nothing left to redo.
 (end code)
 */
RichEdit_GetRedo(hCtrl, ByRef name="-")  {
	static EM_CANREDO=1109, EM_GETREDONAME=1111,UIDs="UNKNOWN,TYPING,DELETE,DRAGDROP,CUT,PASTE"
	SendMessage, EM_CANREDO,,,, ahk_id %hCtrl%
	nRedo := ErrorLevel

	If ( nRedo && name != "-" )  {
		SendMessage, EM_GETREDONAME,,,, ahk_id %hCtrl%
		Loop, Parse, UIDs, `,
			If (A_Index - 1 = ErrorLevel)  {
				name := A_LoopField
				break
			}
	}
	return nRedo
}

/*
 Function: GetModify
      Gets the state of the modification flag for the Edit control.
      The flag indicates whether the contents of the control has been modified.

 Returns:
      True if the content of Edit control has been modified, false otherwise.
      
  Related:
      <SetModify>, <Save>
 */
RichEdit_GetModify(hEdit)  {
    Static EM_GETMODIFY=0xB8
    SendMessage EM_GETMODIFY,,,,ahk_id %hEdit%
    Return ErrorLevel = 4294967295 ? 1 : 0
}

/*
 Function:	GetParaFormat
			Retrieves the paragraph formatting of the current selection in a rich edit control. (*** not implemented ***)	
 */
; Num,Align,Line,Ident,Space,Tabs
RichEdit_GetParaFormat(hCtrl) {
	static EM_GETPARAFORMAT=1085
		   ,PFM_ALL2=0xc0fffdff
	VarSetCapacity(PF, 188, 0), NumPut(188, PF),  NumPut(PFM_ALL2, PF, 4)
	SendMessage, EM_GETPARAFORMAT,, &PF,, ahk_id %hCtrl%
}

/*
 Function:  GetRect
 			Gets the formatting rectangle of the Edit control.

 Parameters:
			Left..Bottom	- Output variables, can be omitted.

 Returns:
 			Space separated rectangle.
 */
RichEdit_GetRect(hEdit,ByRef Left="",ByRef Top="",ByRef Right="",ByRef Bottom="") {
    static EM_GETRECT:=0xB2

	VarSetCapacity(RECT,16)
    SendMessage EM_GETRECT,0,&RECT,,ahk_id %hEdit%
      Left  :=NumGet(RECT, 0,"Int")
    , Top   :=NumGet(RECT, 4,"Int")
    , Right :=NumGet(RECT, 8,"Int")
    , Bottom:=NumGet(RECT,12,"Int")
    return  Left " " Top " " Right " " Bottom
}

/*
  Function: GetSel
 			Retrieve the starting and ending character positions of the selection in a rich edit control.

  Parameters:
 			cpMin -	The optional name of the variable in which to store the character position index immediately
              preceding the first character in the range.
 			cpMin -	The optional name of the variable in which to store the character position index immediately
              following the last character in the range.

  Returns:
 			Returns *cpMin*. If there is no selection this is cursor position.

  Related:
      <GetText>, <GetTextLength>, <SetSel>, <SetText>, <HideSelection>, <LineFromChar>
 */
RichEdit_GetSel(hCtrl, ByRef cpMin="", ByRef cpMax="" )  {
  static EM_EXGETSEL=0x434
  VarSetCapacity(CHARRANGE, 8)
  SendMessage, EM_EXGETSEL, 0,&CHARRANGE,, ahk_id %hCtrl%
  cpMin := NumGet(CHARRANGE, 0, "Int"), cpMax := NumGet(CHARRANGE, 4, "Int")
  return cpMin
}

/*
 Function:  GetText
			Retrieves a specified range of characters from a rich edit control.

 Parameters:
			CpMin -	Beginning of range of characters to retrieve.
			CpMax -	End of range of characters to retrieve.
			CodePage - If *UNICODE* or *U*, this optional parameter will use unicode code page
					in the translation. Otherwise it will default to using ansi. (*** needs rework ***)

 Note:
			If the *CpMin* and *CpMax* are omitted, the current selection is retrieved.
			The range includes everything if *CpMin* is 0 and *CpMax* is �1.

 Returns:
			Returns the retrieved text.

 Related:
			<GetSel>, <GetLine>, <GetTextLength>, <SetText>, <SetSel>, <FindText>
			
 Example:
 (start code)
  MsgBox, % RichEdit_GetText( hRichEdit ) ; get current selection
  MsgBox, % RichEdit_GetText( hRichEdit, 0, -1 ) ; get all
  MsgBox, % RichEdit_GetText( hRichEdit, 4, 10 ) ; get range
 (end code)
 */
RichEdit_GetText(HCtrl, CpMin="-", CpMax="-", CodePage="")  {
	static EM_EXGETSEL=0x434, EM_GETTEXTEX=0x45E, EM_GETTEXTRANGE=0x44B, GT_SELECTION=2, StrGet="StrGet"

	bufferLength := RichEdit_GetTextLength(hCtrl, "CLOSE", "UNICODE" )

	If (CpMin CpMax = "--")
		MODE := GT_SELECTION, CpMin:=CpMax:=""
	else if (CpMin=0 && CpMax=-1)
		MODE := GT_ALL      , CpMin:=CpMax:=""
	else if (CpMin+0 != "") && (cpMax+0 != "")
	{
		VarSetCapacity(lpwstr, bufferLength), VarSetCapacity(TEXTRANGE, 12)
		NumPut(CpMin, TEXTRANGE, 0, "UInt")
		NumPut(CpMax, TEXTRANGE, 4, "UInt"), NumPut(&lpwstr, TEXTRANGE, 8, "UInt")
		SendMessage, EM_GETTEXTRANGE,, &TEXTRANGE,, ahk_id %hCtrl%
		
		if !A_IsUnicode 
		{
			; If not unicode, return ansi from string pointer..
			if !InStr(RichEdit_TextMode(HCtrl), "MULTICODEPAGE")
				return DllCall("MulDiv", "UInt", &lpwstr, "Int",1, "Int",1, "str")

			;..else, convert Unicode to Ansi..
			nSz := DllCall("lstrlenW","UInt",&lpwstr) + 1, VarSetCapacity( ansi, nSz )
			DllCall("WideCharToMultiByte" , "Int",0       , "Int",0
										,"UInt",&LPWSTR ,"UInt",nSz+1
										, "Str",ansi    ,"UInt",nSz+1
										, "Int",0       , "Int",0 )
			VarSetCapacity(ansi, -1)
		} else VarSetCapacity(lpwstr, -1)

		return A_IsUnicode ? lpwstr : ansi
	}
	else return "", errorlevel := A_ThisFunc "> Invalid use of cpMin or cpMax parameter."

	VarSetCapacity(GETTEXTEX, 20, 0)          , VarSetCapacity(BUFFER, bufferLength, 0)
	NumPut(bufferLength, GETTEXTEX, 0, "UInt"), NumPut(MODE, GETTEXTEX, 4, "UInt")
	NumPut( (CodePage="unicode" || CodePage="u") ? 1200 : 0  , GETTEXTEX, 8, "UInt")
	SendMessage, EM_GETTEXTEX, &GETTEXTEX, &BUFFER,, ahk_id %hCtrl%
	VarSetCapacity(BUFFER, -1)

	

	return A_IsUnicode ? %StrGet%(&BUFFER,"", "UTF-8") : BUFFER
}

/*
 Function:	GetTextLength
			Calculates text length in various ways for a rich edit control.

 Parameters:
			flag     - Space separated list of one or more options.  See below list.
			codepage - If *UNICODE* or *U*, this optional parameter will use unicode code page
                in the translation. Otherwise it will default to using ansi.

 Flag Options:
     DEFAULT  - Returns the number of characters. This is the default.
     USECRLF  - Computes the answer by using CR/LFs at the end of paragraphs.
     PRECISE  - Computes a precise answer. This approach could necessitate a conversion
                and thereby take longer. This flag cannot be used with the *CLOSE* flag.
     CLOSE    - Computes an approximate (close) answer. It is obtained quickly and can
                be used to set the buffer size. This flag cannot be used with the *PRECISE*
                flag.
     NUMCHARS - Returns the number of characters. This flag cannot be used with the
                *NUMBYTES* flag.
     NUMBYTES - Returns the number of bytes. This flag cannot be used with the *NUMCHARS*
                flag.

 Returns:
     If the operation succeeds, the return value is the number of TCHARs in the edit
     control, depending on the setting of the flags.
     If the operation fails, the return value is blank.

 Remarks:
     This message is a fast and easy way to determine the number of characters in the
     Unicode version of the rich edit control. However, for a non-Unicode target code
     page you will potentially be converting to a combination of single-byte and double-byte
     characters.

 Related:
     <LineLength>, <LimitText>, <GetSel>

 Example:
 (start code)
  MsgBox, % "DEFAULT  = " RichEdit_GetTextLength(hRichEdit, "DEFAULT" )  "`n"
          . "USECRLF  = " RichEdit_GetTextLength(hRichEdit, "USECRLF" )  "`n"
          . "PRECISE  = " RichEdit_GetTextLength(hRichEdit, "PRECISE" )  "`n"
          . "CLOSE    = " RichEdit_GetTextLength(hRichEdit, "CLOSE" )    "`n"
          . "NUMCHARS = " RichEdit_GetTextLength(hRichEdit, "NUMCHARS" ) "`n"
          . "NUMBYTES = " RichEdit_GetTextLength(hRichEdit, "NUMBYTES" ) "`n"
 (end code)
 */
RichEdit_GetTextLength(hCtrl, Flags=0, CodePage="")  {
  static EM_GETTEXTLENGTHEX=95,WM_USER=0x400
  static GTL_DEFAULT=0,GTL_USECRLF=1,GTL_PRECISE=2,GTL_CLOSE=4,GTL_NUMCHARS=8,GTL_NUMBYTES=16

  hexFlags:=0
	Loop, parse, Flags, %A_Tab%%A_Space%
		hexFlags |= GTL_%A_LOOPFIELD%

  VarSetCapacity(GETTEXTLENGTHEX, 4)
  NumPut(hexFlags, GETTEXTLENGTHEX, 0), NumPut((codepage="unicode"||codepage="u") ? 1200 : 1252, GETTEXTLENGTHEX, 4)
  SendMessage, EM_GETTEXTLENGTHEX | WM_USER, &GETTEXTLENGTHEX,0,, ahk_id %hCtrl%
  IfEqual, ERRORLEVEL,0x80070057, return "", errorlevel := A_ThisFunc "> Invalid combination of parameters."
  IfEqual, ERRORLEVEL,FAIL      , return "", errorlevel := A_ThisFunc "> Invalid control handle."
  return ERRORLEVEL
}

/*
 Function:	GetUndo
    Determine whether there are any actions in the Edit control undo queue, and optionally retrieve
    the type of the next undo action.

 Parameters:
    Name - Optional byref parameter will contain the type of undo action, if any.

 Types:
    UNKNOWN	 - The type of undo action is unknown.
    TYPING	 - Typing operation.
    DELETE	 - Delete operation.
    DRAGDROP - Drag-and-drop operation.
    CUT		 - Cut operation.
    PASTE	 - Paste operation.

 Returns:
    If there are actions in the control undo queue, the return value is a nonzero value.
    If the undo queue is empty, the return value is zero.

 Related:
    <Undo>, <SetUndoLimit>, <GetRedo>, <Redo>

 Example:
 (start code)
  If RichEdit_GetRedo( hRichEdit, name )
    MsgBox, The next redo is a %name% type
  Else MsgBox, Nothing left to redo.
 (end code)
 */
RichEdit_GetUndo(hCtrl, ByRef Name="-")  {
  static EM_CANUNDO=0xC6,EM_GETUNDONAME=86,WM_USER=0x400
        ,UIDs="UNKNOWN,TYPING,DELETE,DRAGDROP,CUT,PASTE"
  SendMessage, EM_CANUNDO, 0,0,, ahk_id %hCtrl%
  nUndo := ERRORLEVEL

  If ( nUndo && name != "-" )  {
    SendMessage, WM_USER | EM_GETUNDONAME, 0,0,, ahk_id %hCtrl%
    Loop, Parse, UIDs, `,
      If (A_Index - 1 = errorlevel)  {
        name := A_LoopField
        break
      }
  }
  return nUndo
}

/*
 Function:  HideSelection
    Hides or shows the selection in a rich edit control.

 Parameters:
    State - True or false.

 Remarks:
    This function is noticeable when it is set to false and the rich edit control isn't the active control or window.  The example included in <FindText> demonstrates use.

 Related:
			<SetSel>, <GetSel>
 */
RichEdit_HideSelection(hCtrl, State=true)  {
  static EM_HIDESELECTION = 1087
  SendMessage, EM_HIDESELECTION,%State%,0,, ahk_id %hCtrl%
}

/*
 Function:  LineFromChar
			Determines which line contains the specified character in a rich edit control.

 Parameters:
			CharIndex -	Zero-based integer index of the character. -1 (default) means current line.

 Returns:
			Zero-based index of the line.

 Related:
			<LineIndex>, <GetLineCount>
 */
RichEdit_LineFromChar(hCtrl, CharIndex=-1)  {
  static EM_EXLINEFROMCHAR=1078
  SendMessage, EM_EXLINEFROMCHAR,,CharIndex,, ahk_id %hCtrl%
  return ERRORLEVEL
}

/*
 Function:	LineIndex
			Returns the character index of the first character of a specified line in an Edit control.

 Parameters:
			LineNumber	- Line number for which to retreive character index. -1 (default) means current line.

 Returns:
			The character index of the line specified, or -1 if the specified line number is greater than the number of lines.

 Related:
			<LineLength>, <LineFromChar>, <GetLine>, <GetLineCount>
 */
RichEdit_LineIndex(hEdit, LineNumber=-1) {
	static EM_LINEINDEX=187
 	SendMessage, EM_LINEINDEX, LineNumber,,, ahk_id %hEdit%
	Return ErrorLevel
}

/*
 Function:	LineLength
			Returns the length of a line in an Edit control.

 Parameters:
			LineNumber	- Line number for which to retreive line length. -1 (default) means current line.

 Returns:
			The length (in characters) of the line.
			
 Related:
			<GetTextLength>, <LineIndex>, <LineFromChar>
 */
RichEdit_LineLength(hEdit, LineNumber=-1) {
	static EM_LINELENGTH=193
	SendMessage, EM_LINELENGTH, RichEdit_LineIndex(hEdit, LineNumber),,, ahk_id %hEdit%
	Return ErrorLevel
}

/*
 Function: LineScroll
			Scrolls the text in the Edit control.

 Parameters:
			XScroll -	The number of characters to scroll horizontally.  Use a
								negative number to scroll to the left and a positive number to
								scroll to the right.
			YScroll -	The number of lines to scroll vertically.  Use a negative
						    number to scroll up and a positive number to scroll down.
 Remarks:
			This message does not move the caret.
			This function can be used to scroll horizontally past the last character of any line.
 */
RichEdit_LineScroll(hEdit,XScroll=0,YScroll=0){
    Static EM_LINESCROLL:=0xB6
    SendMessage EM_LINESCROLL, XScroll, YScroll,,ahk_id %hEdit%
}

/*
 Function:  LimitText
			Sets an upper limit to the amount of text the user can type or paste into a rich edit control.

 Parameters:
			txtSize -	Specifies the maximum amount of text that can be entered. If this parameter is zero,
               the default maximum is used, which is 64K characters. A Component Object Model (COM)
               object counts as a single character.

 Returns:
			This function does not return a value.

 Remarks:
     Before LimitText is called, the default limit to the amount of text a user can enter is
     32,767 characters.
 */
RichEdit_LimitText(hCtrl,txtSize=0)  {
  static EM_EXLIMITTEXT=53,WM_USER=0x400
  SendMessage, WM_USER | EM_EXLIMITTEXT, 0,%txtSize%,, ahk_id %hCtrl%
}

/*
 Function: Paste
		   Paste clipboard into the Edit control.

 Related:
		<CanPaste>, <PasteSpecial>, <Cut>, <Copy>, <Clear>
 */
RichEdit_Paste(hEdit) {
    Static WM_PASTE:=0x302
    SendMessage WM_PASTE,0,0,,ahk_id %hEdit%
}

/*
 Function:	PasteSpecial
      Pastes a specific clipboard format in a rich edit control.

 Parameters:
			Format	- One of the clipboard formats. See <http://msdn.microsoft.com/en-us/library/bb774214(VS.85).aspx>

 Related:
		<CanPaste>, <Paste>
 */
RichEdit_PasteSpecial(HCtrl, Format)  {
  static EM_PASTESPECIAL=0x440
		,CF_BITMAP=2,CF_DIB=8,CF_DIBV5=17,CF_DIF=5,CF_DSPBITMAP=0x82,CF_DSPENHMETAFILE=0x8E,CF_DSPMETAFILEPICT=0x83
        ,CF_DSPTEXT=0x81,CF_ENHMETAFILE=14,CF_GDIOBJFIRST=0x300,CF_GDIOBJLAST=0x3FF,CF_HDROP=15,CF_LOCALE=16
        ,CF_METAFILEPICT=3,CF_OEMTEXT=7,CF_OWNERDISPLAY=0x80,CF_PALETTE=9,CF_PENDATA=10,CF_PRIVATEFIRST=0x200
        ,CF_PRIVATELAST=0x2FF,CF_RIFF=11,CF_SYLK=4,CF_TEXT=1,CF_WAVE=12,CF_TIFF=6,CF_UNICODETEXT=13

  SendMessage, EM_PASTESPECIAL, CF_%Format%, 0,, ahk_id %hCtrl%
}


/*
 Function: PosFromChar
           Gets the client area coordinates of a specified character in an Edit control.

 Parameters:
           CharIndex - The zero-based index of the character.

           X, Y - These parameters, which must contain valid variable names,
           are used to return the x/y-coordinates of a point in the control's client relative to the upper-left corner of the client area.

 Remarks:
           If CharIndex is greater than the index of the last character in the control, the returned coordinates are of the position just past
           the last character of the control.
 */
RichEdit_PosFromChar(hEdit, CharIndex, ByRef X, ByRef Y) {
    Static EM_POSFROMCHAR=0xD6
    VarSetCapacity(POINTL,8,0)
    SendMessage EM_POSFROMCHAR,&POINTL,CharIndex,,ahk_id %hEdit%
    X:=NumGet(POINTL,0,"Int"), Y:=NumGet(POINTL,4,"Int")
}

/*
 Function:	Redo
			Do redo operation.

 Returns:
			True if the Redo operation succeeds, false otherwise.
 */
RichEdit_Redo(hEdit) {
	static EM_REDO := 1108
	SendMessage, EM_REDO,,,, ahk_id %hEdit%
	return ErrorLevel
}

/*
 Function:	ReplaceSel
			Replace selection with desired text in the Edit control.

 Parameters:
			Text - Text to replace selection with.
 */
RichEdit_ReplaceSel(hEdit, Text=""){
	static  EM_REPLACESEL=194
	SendMessage, EM_REPLACESEL,, &text,, ahk_id %hEdit%
}

/*
 Function:	Save
			Save the content of the rich edit control using RT format.

 Parameters:
			FileName	- File name to save RTF file to. If omitted, function will return content.
			
  Related:
      <GetModify>, <SetModify>
      
 Example:
 (start code)
  If !RichEdit_GetModify( hRichEdit )  {
    MsgBox, No changes detected
    return
  }

  RichEdit_Save( hRichEdit, file )
  RichEdit_SetModify( hRichEdit, false )
  MsgBox, File has been saved
 (end code)
 */
RichEdit_Save(hCtrl, FileName="") {
	static EM_STREAMOUT=0x44A

	wbProc := RegisterCallback("RichEdit_editStreamCallBack", "F")
	VarSetCapacity(EDITSTREAM, 16, 0)
	NumPut(RichEdit_GetTextLength(hCtrl, "USECRLF")*2, EDITSTREAM)	;aproximate
	NumPut(wbProc, EDITSTREAM, 8, "UInt")

	SendMessage, EM_STREAMOUT, 2, &EDITSTREAM,, ahk_id %hCtrl%
	return RichEdit_editStreamCallBack("!", FileName, "", "")
}

/*
 Function:	ScrollCaret
			Scroll content of Edit control until caret is visible.
 */
RichEdit_ScrollCaret(hEdit){
	static EM_SCROLLCARET=183
	SendMessage, EM_SCROLLCARET,,,, ahk_id %hEdit%
}

/*
 Function:	ScrollPos
			Obtain the current scroll position, or tell the rich edit control to scroll to a particular point.

 Parameters:
			PosString - String specifying the x/y point in the virtual text space of the document, expressed
					    in pixels. (See example)

 Returns:
     If *posString* is omitted, the return value is the current scroll position.

 Related:
		<ShowScrollBar>, <GetSel>, <LineFromChar>, <SetSel>

 Example:
	> Msgbox, % "scroll pos = " RichRichEdit_ScrollPos( hRichEdit )
	> RichRichEdit_ScrollPos( hRichEdit , "7/22" )
 */
RichEdit_ScrollPos(HCtrl, PosString="" )  {
  static EM_GETSCROLLPOS=1245,EM_SETSCROLLPOS=1246

  VarSetCapacity(POINT, 8, 0)
  If (!PosString)  {
    SendMessage, EM_GETSCROLLPOS, 0,&POINT,, ahk_id %HCtrl%
    return NumGet(POINT, 0, "Int") . "/" . NumGet(POINT, 4, "Int")  ; returns posString
  }

  If RegExMatch( PosString, "^(?<X>\d*)/(?<Y>\d*)$", m )  {
    NumPut(mX, POINT, 0, "Int"), NumPut(mY, POINT, 4, "Int")
    SendMessage, EM_SETSCROLLPOS, 0,&POINT,, ahk_id %HCtrl%
  }
  else return false, errorlevel := "ERROR: '" PosString "' isn't a valid posString."
}

/*
 Function:	SelectionType
			Determines the selection type for a rich edit control.

 Returns:
			If the selection is not empty, the return value is a set of flags containing one or more of the following values:
			TEXT		-	Text.
			OBJECT		-	At least one Component Object Model (COM) object.
			MULTICHAR	-	More than one character of text.
			MULTIOBJECT	-	More than one COM object.

 Remarks:
	This message is useful during WM_SIZE processing for the parent of a bottomless rich edit control.
 */
RichEdit_SelectionType(hCtrl)  {
	static EM_SELECTIONTYPE=1090, 1="TEXT", 2="OBJECT", 4="MULTICHAR", 8="MULTIOBJECT", types="1,2,4,8"

	if hCtrl > 0
	{
		SendMessage, EM_SELECTIONTYPE,,,, ahk_id %hCtrl%
		if !(o := ErrorLevel)
			return
	}
	else o := abs(hCtrl)

	loop, parse, types, `,
		if (o & A_LoopField)
			res .= %A_LoopField% " "

	return SubStr(res, 1, -1)
}

/*
 Function:	SetBgColor
			Sets the background color for a rich edit control.

 Parameters:
			Color -	Color in RGB format (0xRRGGBB) if > 0 or BGR format if < 0.

 Returns:
			Returns the previous background color in RGB format.

 Related:
     <SetCharFormat>, <GetCharFormat>

 Example:
 > Dlg_Color( color, hRichEdit )
 > RichEdit_SetBgColor( hRichEdit, color )
 >
 > RichEdit_SetBgColor( hRichEdit, 0xa9f874 )
 */
RichEdit_SetBgColor(hCtrl, Color)  {
	static EM_SETBKGNDCOLOR=1091

	if (Color < 0) {
		SendMessage, EM_SETBKGNDCOLOR,, abs(Color),, ahk_id %hCtrl%
		return Color
	}

	old := A_FormatInteger
	SetFormat, integer, hex
	RegExMatch( Color, "0x(?P<R>..)(?P<G>..)(?P<B>..)$", _ ) ; RGB2BGR
	Color := "0x00" _B _G _R        ; 0x00bbggrr
	SendMessage, EM_SETBKGNDCOLOR,,Color,, ahk_id %hCtrl%
	RegExMatch( ERRORLEVEL + 0x1000000, "(?P<B>..)(?P<G>..)(?P<R>..)$", _ ) ; RGB2BGR
	pColor := "0x" _R _G _B
	SetFormat, integer, %old%

	return pColor
}

/*
 Function:	SetCharFormat
			Set character formatting in a rich edit control.

 Parameters:
			Face	- Font name. Optional.
			Style	- Space separated list of styles. See below list. Optional.
			TextColor	- Text foreground color. Optional.
			BackColor	- Text backgrond color. Optional.
			Mode	- Character formatting that applies to the control.
					  If omitted, the function changes the default character formatting.
					  It can be one of the values given bellow. Optional.

 Styles:
			s<Num>		- Character size, usual AHK represntation (i.e. s12)
			o<Num>		- Character offset from the baseline, in twips,. If the value of this member is positive, the character is a superscript; if the value is negative, the character is a subscript.
			AUTOBACKCOLOR - The background color is the return value of GetSysColor(COLOR_WINDOW:=5). If this flag is set, BackColor member is ignored.
			AUTOCOLOR	- The text color is the return value of GetSysColor(COLOR_WINDOWTEXT:=8). If this flag is set, the TextColor member is ignored.
			BOLD		- Characters are bold.
			HIDDEN		- Characters are not displayed.
			ITALIC		- Characters are italic.
			LINK		- A rich edit control sends LINK notification messages when it receives mouse messages while the mouse pointer is over text with the LINK effect.
			PROTECTED	- Characters are protected; an attempt to modify them will cause an PROTECTED notification message.
			STRIKEOUT	- Characters are struck out.
			SUBSCRIPT	- Characters are subscript. The SUPERSCRIPT and SUBSCRIPT values are mutually exclusive.
						  For both values, the control automatically calculates an offset and a smaller font size.
			SUPERSCRIPT	- Characters are superscript.
			UNDERLINE	- Characters are underlined.

 Modes:
			DEFAULT		- Changes the formating for the default text in the control. This is also the style used if you don't specify valid style.
			ALL			- Applies the formatting to all text in the control.
			SELECTION	- Applies the formatting to the current selection. If the selection is empty, the character formatting is applied
						  to the insertion point, and the new character format is in effect only until the insertion point changes. 
			WORD		- Applies the formatting to the selected word or words. If the selection is empty but the insertion point is inside a word
						  ,the formatting is applied to the word.
						  
 Returns:
			True or false.

 Remarks:
			This function will fire up SELCHANGE message even if selection isn't changed.
 */
RichEdit_SetCharFormat(HCtrl, Face="", Style="", TextColor="", BackColor="", Mode="SELECTION")  {
	static EM_SETCHARFORMAT=0x444
		  , CFM_CHARSET:=0x8000000,CFM_COLOR:=0x40000000, CFM_FACE:=0x20000000, CFM_OFFSET:=0x10000000, CFM_SIZE:=0x80000000, CFM_WEIGHT=0x400000, CFM_UNDERLINETYPE=0x800000
		  , CFM_HIDDEN=0x100, CFM_BOLD=1, CFM_ITALIC=2, CFM_DISABLED=0x2000, CFM_LINK=0x20, CFM_PROTECTED=0x10, CFM_STRIKEOUT=8, CFM_UNDERLINE=4, CFM_SUPERSCRIPT=0x30000, CFM_SUBSCRIPT=0x30000, CFM_BACKCOLOR=0x4000000, CFE_AUTOBACKCOLOR=0x4000000, CFE_AUTOCOLOR = 0x40000000
		  , CFE_HIDDEN=0x100, CFE_BOLD=1, CFE_ITALIC=2, CFE_DISABLED=0x2000, CFE_LINK=0x20, CFE_PROTECTED=0x10, CFE_STRIKEOUT=8, CFE_UNDERLINE=4, CFE_SUBSCRIPT=0x10000, CFE_SUPERSCRIPT=0x20000
		  , SCF_ALL=4, SCF_SELECTION=1, SCF_WORD=3, StrPut="StrPut"	;, SCF_ASSOCIATEFONT=0x10

	;sz := S(_, "CHARFORMAT2A: cbSize dwMask dwEffects yHeight=.04 yOffset=.04 crTextColor bCharSet=.1 bPitchAndFamily=.1 szFaceName wWeight=60.2 sSpacing=.02 crBackColor lcid dwReserved sStyle=.02 wKerning=.2 bUnderlineType=.1 bAnimation=.1 bRevAuthor=.1 bReserved1=.1")

	VarSetCapacity(CF, 84, 0),  NumPut(84, CF)
	hMask := 0
	if (Face != "") && (StrLen(Face) <= 32) {
		if A_IsUnicode
			VarSetCapacity(faceAnsi, %StrPut%(Face, "cp0")), %StrPut%(Face, &faceAnsi, "cp0")
		hMask |= CFM_FACE, DllCall("lstrcpyA", "UInt", &CF+26, "Uint", A_IsUnicode ? &faceAnsi : &Face)
	}

	if (TextColor != "")
		TextColor := ((TextColor & 0xFF) << 16) + (TextColor & 0xFF00) + ((TextColor >> 16) & 0xFF)
		, hMask |= CFM_COLOR, NumPut(TextColor, CF, 20)

	if (BackColor != "")
		BackColor := ((BackColor & 0xFF) << 16) + (BackColor & 0xFF00) + ((BackColor >> 16) & 0xFF)
		, hMask |= CFM_BACKCOLOR,  NumPut(BackColor, CF, 64)

	if (Style != "") {
		hEffects := 0
		loop, parse, Style, %A_Space%
		{
			lf := A_LoopField, c := SubStr(lf, 1, 1)
			if InStr("so", c) && ((j := SubStr(lf, 2)+0) != "", (%c% := j))
				 continue

			if bOff := c = "-"
				lf := SubStr(lf, 2)

			hMask |= CFM_%lf%, hEffects |= bOff ? 0 : CFE_%lf%
		}
	    NumPut(hEffects, CF, 8)
		if (s != "")
			hMask |= CFM_SIZE, NumPut(s*20, CF, 12, "Int")
		if (o != "")
			hMask |= CFM_OFFSET, NumPut(o, CF, 16, "Int")
	}

	NumPut(hMask, CF, 4)
	SendMessage, EM_SETCHARFORMAT, SCF_%Mode%, &CF,, ahk_id %hCtrl%
	return ErrorLevel
}

/*
	Function:	SetEvents
				Set notification events.

	Parameters:
				Handler	- Function that handles events. If empty, any existing handler will be removed.
				Events	- White space separated list of events to monitor.

	Handler:
 >     	Result := Handler(hCtrl, Event, p1, p2, p3 )

		hCtrl	- Handle of richedit control sending the event.
		Event	- Specifies event that occurred. Event must be registered to be able to monitor it.
		Col,Row - Cell coordinates.
		Data	- Numeric data of the cell. Pointer to string for textual cells and DWORD value for numeric.
		Result  - Return 1 to prevent action.

	Events:
		*CHANGE*: Sent when the user has taken an action that may have altered text in an edit control.
				  Sent after the system updates the screen. (***)

		*DRAGDROPDONE*: Notifies a rich edit control's parent window that the drag-and-drop operation has completed.
		 o P1 - Number of characters highlighted in drag-drop operation.
         o P2 - Beginning character position of range.
         o P3 - Ending character position of range.

		*DROPFILES*: Notifies that the user is attempting to drop files into the control.
		 o P1 - Number of files dropped onto rich edit control.
		 o P2 - Newline delimited (`n) list of files dropped onto control.
		 o P3 - Character position files were dropped onto within rich edit control.

		*KEYEVENTS*: Notification of a keyboard or mouse event in the control. To ignore the
					 event, the handler function should return a nonzero value.  (*** needs redone)
		 o P1 - Character position files were dropped onto within rich edit control.

		*MOUSEEVENTS,SCROLLEVENTS,LINK*: A rich edit control sends these messages when it receives various messages, when the
				user clicks the mouse or when the mouse pointer is over text that has the LINK effect.
				(*** expand usefulness)

		*PROTECTED*:	User is taking an action that would change a protected range of text.  To ignore
						the event, the handler function should return a nonzero value.

		*REQUESTRESIZE*: This message notifies a rich edit control's parent window that the control's
						 contents are either smaller or larger than the control's window size.
		 o P1 - Requested new size.

		*SELCHANGE*: The current selection has changed.
		 o P1 - Beginning character position of range.
		 o P2 - Ending character position of range.
		 o P3 - Selection type.

		*LINK*: The hyperlink has been clicked.
		 o P1 - LClick or RClick.
		 o P2 - CpMin.
		 o P3 - CpMax.

 Returns:
		The previous event mask (number).
 */
RichEdit_SetEvents(hCtrl, Handler="", Events="selchange"){
  static ENM_CHANGE=0x1,ENM_DRAGDROPDONE=0x10,ENM_DROPFILES:=0x100000,ENM_KEYEVENTS=0x10000,ENM_LINK=0x4000000,ENM_MOUSEEVENTS=0x20000,ENM_PROTECTED=0x200000,ENM_REQUESTRESIZE=0x40000,ENM_SCROLLEVENTS=0x8,ENM_SELCHANGE=0x80000 ;ENM_OBJECTPOSITIONS=0x2000000,ENM_SCROLL=0x4,ENM_UPDATE=0x2   ***
       , sEvents="CHANGE,DRAGDROPDONE,DROPFILES,KEYEVENTS,LINK,MOUSEEVENTS,PROTECTED,REQUESTRESIZE,SCROLLEVENTS,SELCHANGE,SCROLL"
	   , WM_NOTIFY=0x4E,WM_COMMAND=0x111,EM_SETEVENTMASK=1093, oldNotify, oldCOMMAND

	if (Handler = "")
		return OnMessage(WM_NOTIFY, old != "RichEdit_onNotify" ? old : ""), old := ""

	if !IsFunc(Handler)
		return A_ThisFunc "> Invalid handler: " Handler

	hMask := 0
	loop, parse, Events, %A_Tab%%A_Space%
	{
		IfEqual, A_LoopField,,continue
		if A_LoopField not in %sEvents%
			return A_ThisFunc "> Invalid event: " A_LoopField
		hMask |= ENM_%A_LOOPFIELD%
		If (A_LoopField = "DROPFILES")
			DllCall("shell32.dll\DragAcceptFiles", "UInt", hCtrl, "UInt", true)

		 ; 		if A_LoopField in CHANGE,SCROLL   ; (*** WIP)
		 ;     	if !oldCOMMAND {
		 ;     		oldCOMMAND := OnMessage(WM_COMMAND, "RichEdit_onNotify")
		 ;     		if oldCOMMAND != RichEdit_onNotify
		 ;     			RichEdit("oldCOMMAND", RegisterCallback(oldCOMMAND))
		 ;     	}
	}

	if !oldNotify {
		oldNotify := OnMessage(WM_NOTIFY, "RichEdit_onNotify")
		if oldNotify != RichEdit_onNotify
			RichEdit("oldNotify", RegisterCallback(oldNotify))
	}

	RichEdit(hCtrl "Handler", Handler)
	SendMessage, EM_SETEVENTMASK,,hMask,, ahk_id %hCtrl%
	return ERRORLEVEL  ; This message returns the previous event mask
}

/*
 Function:	SetFontSize
			Sets the font size for the selected text in the rich edit control.

 Parameters:
			Add - Change in point size of the selected text. The change is applied to
					each part of the selection. So, if some of the text is 10pt and some 20pt,
					after a call with wParam set to 1, the font sizes become 11pt and 22pt, respectively.
					
 Returns:
			True if no error occurred, false otherwise.
 */
RichEdit_SetFontSize(hCtrl, Add) {
	static EM_SETFONTSIZE=0x4DF
	SendMessage, EM_SETFONTSIZE,Add,,, ahk_id %hCtrl%
	return ErrorLEvel
}

/*
 Function: SetModify
      Sets or clears the modification flag for an edit control. The modification flag indicates
      whether the text within the edit control has been modified.

  Related:
      <GetModify>, <Save>
 */
RichEdit_SetModify(hEdit, State=true)  {
  Static EM_SETMODIFY = 185
  SendMessage EM_SETMODIFY,%State%,,,ahk_id %hEdit%
}

/*
 Function:	SetOptions
			Sets the options for a rich edit control.


 Parameters:
			Operation	- Specifies the operation.
			Options		- White separted list of option values.

 Operation:
			SET - Sets the options to those specified by Options.
			OR  - Combines the specified options with the current options.
			AND - Retains only those current options that are also specified by Options.
			XOR - Logically exclusive OR the current options with those specified by Options.

 Options:
			AUTOWORDSELECTION - Automatic selection of word on double-click.
			AUTOVSCROLL - Same as AUTOVSCROLL style.
			AUTOHSCROLL - Same as AUTOHSCROLL style.
			NOHIDESEL - Same as NOHIDESEL style.
			READONLY - Same as READONLY style.
			WANTRETURN - Same as WANTRETURN style.
			SELECTIONBAR - Same as SELECTIONBAR style.
 Returns:
			Returns the current options of the edit control.
 */
RichEdit_SetOptions(hCtrl, Operation, Options)  {
	static EM_SETOPTIONS=1101
		, ECOOP_SET=0x1,ECOOP_OR=0x2,ECOOP_AND=0x3,ECOOP_XOR=0x4
		, ECO_AUTOWORDSELECTION=0x1,ECO_AUTOVSCROLL=0x40,ECO_AUTOHSCROLL=0x80,ECO_NOHIDESEL=0x100,ECO_READONLY=0x800,ECO_WANTRETURN=0x1000,ECO_SELECTIONBAR=0x1000000

	operation := ECOOP_%Operation%
	ifEqual, operation,,return A_ThisFunc "> Invalid operation: " Operation

	hOptions := 0
	loop, parse, Options, %A_Tab%%A_Space%,
		ifEqual, A_LoopField,,continue
		else hOptions |= ECO_%A_LOOPFIELD%

	SendMessage, EM_SETOPTIONS, operation, hOptions,, ahk_id %hCtrl%
	return RichEdit_GetOptions( "." ErrorLevel)
}

/*
 Function:	PageRotate
			Rotate page.
 
 Parameters:
		    R	- Can be one of the following: 0,90,180,270. 

 Returns:
			If R is omitted, functin returns current rotation.
 */
RichEdit_PageRotate(hCtrl, R="") {
	static EM_SETPAGEROTATE=1260, EM_GETPAGEROTATE=1259, EPR_270 = 1, EPR_180 = 2, EPR_90 = 3, 1=270, 2=180, 3=90
	
	if (R="") { 
		SendMessage, EM_GETPAGEROTATE,,,, ahk_id %hCtrl%
		return (%ErrorLevel%)
	}
	
	SendMessage, EM_SETPAGEROTATE,EPR_%R%,,, ahk_id %hCtrl%
}

/*
 Function:	SetParaFormat
			Sets the paragraph formatting for the current selection in a rich edit control.

 Parameters:
			o1..o6	- Named arguments: Num, Align, Line, Ident, Space, Tabs. Each named arugment has its own set of
					  parameters (delimited by comma). The syntax is "Name=a1,a2,a3,a4".

 *Num* :

			Type	- EMPTY, BULLET, DECIMAL, LOWER, UPPER, ROMAN_LOWER, ROMAN_UPPER, SEQUENCE (Uses a sequence of characters beginning with the character specified by the start argument).
			Start	- Starting number or starting value used for numbered paragraphs.
			Style	- One of the following :
					  o RP   - Follows the number with a right parenthesis.
					  o P	 - Encloses the number in parentheses.
					  o D	 - Follows the number with a dot.
					  o N	 - Displays only the number.
					  o CONT - Continues a numbered list without applying the next number or bullet.
					  o NEW  - Starts a new number with value of *Start* parameter.
			Offset	- Minimum space between a paragraph number and the paragraph text, in twips.

 *Align* :

			Type	- CENTER, LEFT, RIGHT, JUSTIFY.

 *Line* :

			Rule	- One of the following :
					  o SINGLE	 - Single spacing.
					  o 1ANDHALF - One-and-a-half spacing.
					  o DOUBLE	 - Double spacing.
					  o S1		 - The Spacing specifies the spacing from one line to the next, in twips. However, if Spacing specifies a value that is less than single spacing, the control displays single-spaced text.
					  o S2		 - The Spacing specifies the spacing from one line to the next, in twips. The control uses the exact spacing specified, even if Spacing specifies a value that is less than single spacing.
					  o S3		 - The value of Spacing/20 is the spacing, in lines, from one line to the next. Thus, setting Spacing to 20 produces single-spaced text, 40 is double spaced, 60 is triple spaced, and so on.
			Spacing - Spacing between lines. This value is valid only for S1-S3 Rules.

 *Ident* :

 			First	- Indentation of the paragraph's first line, relative to the paragraph's current indentation, in twips.
					  The indentation of subsequent lines depends on the Offset member.  To see all this in effect you must enable word wrap mode.
					  If starts with ".", it represents absolute indentation from the left margin.
			Offset	- Indentation of the second and subsequent lines, relative to the indentation of the first line, in twips.
					  The first line is indented if this member is negative or outdented if this member is positive.
			Right	- Indentation of the right side of the paragraph, relative to the right margin, in twips.

 *Space* :

			Before	- Size of the spacing above the paragraph, in twips.
			After	- Specifies the size of the spacing below the paragraph, in twips.

 *Tabs* :

			List	- Space separated list of absolute tab stop positions in twips.

 Returns:
			True if succeessiful, false otherwise.

 Remarks:
			Control uses carriage return character (`r) for paragraph markers by default.
 */
RichEdit_SetParaFormat(hCtrl, o1="", o2="", o3="", o4="", o5="", o6="")  {
	;S(_, "PARAFORMAT2: cbSize dwMask wNumbering=.2 wEffects=.2 dxStartIndent=.04 dxRightIndent=.04 dxOffset=.04 wAlignment=.02 cTabCount dySpaceBefore=156.04 dySpaceAfter=.04 dyLineSpacing=.04 sStyle=.02 bLineSpacingRule=.1 bOutlineLevel=.1 wShadingWeight=.2 wShadingStyle=.2 wNumberingStart=.2 wNumberingStyle=.2 wNumberingTab=.2 wBorderSpace=.2 wBorderWidth=.2 wBorders=.2")
	static EM_SETPARAFORMAT=0x447
		,PFM_ALIGNMENT=0x8, PFM_BORDER=0x800, PFM_BOX=0x4000000, PFM_COLLAPSED=0x1000000, PFM_DONOTHYPHEN=0x400000, PFM_KEEP=0x20000, PFM_KEEPNEXT=0x40000, PFM_LINESPACING=0x100, PFM_NOLINENUMBER=0x100000, PFM_NOWIDOWCONTROL=0x200000, PFM_NUMBERING=0x20
		,PFM_NUMBERINGSTART=0x8000, PFM_NUMBERINGSTYLE=0x2000, PFM_NUMBERINGTAB=0x4000, PFM_OFFSET=0x4, PFM_OFFSETINDENT=0x80000000, PFM_OUTLINELEVEL=0x2000000, PFM_PAGEBREAKBEFORE=0x80000, PFM_RIGHTINDENT=0x2, PFM_RTLPARA=0x10000, PFM_SHADING=0x1000
		,PFM_SIDEBYSIDE=0x800000, PFM_SPACEAFTER=0x80, PFM_SPACEBEFORE=0x40, PFM_STARTINDENT=0x1, PFM_STYLE=0x400,PFM_TABLE=0x40000000, PFM_TABSTOPS=0x10, PFN_BULLET=0x1, PFN_LCLETTER=3, PFN_LCROMAN=5, PFN_UCLETTER=4, PFN_UCROMAN=6

	static ALIGN_CENTER=3, ALIGN_LEFT=1, ALIGN_RIGHT=2, ALIGN_JUSTIFY=4
		  ,NUM_TYPE_BULLET=1, NUM_TYPE_DECIMAL=2, NUM_TYPE_LOWER=3, NUM_TYPE_UPPER=4, NUM_TYPE_ROMAN_LOWER=5, NUM_TYPE_ROMAN_UPPER=6, NUM_TYPE_SEQUENCE=7
		  ,NUM_STYLE_P=0X100, NUM_STYLE_D=0X200, NUM_STYLE_N=0X300, NUM_STYLE_CONT=0X400, NUM_STYLE_NEW=0X800
		  ,LINE_RULE_SINGLE=0, LINE_RULE_1ANDHALF=1, LINE_RULE_DOUBLE=2, LINE_RULE_S1=3, LINE_RULE_S2=4, LINE_RULE_S3=5,

	loop {
		ifEqual, o%A_Index%,,break
		else j := InStr( o%A_index%, "=" ), p := SubStr(o%A_index%, 1, j-1 ), v := SubStr( o%A_index%, j+1)
		StringSplit, %p%, v, `,
	}

	;S(PF, "PARAFORMAT2! cbSize dwMask wAlignment", sz, PFM_ALIGNMENT, PFA_RIGHT)
	VarSetCapacity(PF, 188, 0), NumPut(188, PF),  hMask := 0
	if Align0
		hMask |= PFM_ALIGNMENT, NumPut(ALIGN_%Align1%, PF, 24, "UShort")

	;S(PF, "PARAFORMAT2! cbSize dwMask wNumbering wNumberingStart wNumberingStyle wNumberingTab", sz, pm := PFM_NUMBERING | PFM_NUMBERINGSTART | PFM_NUMBERINGSTYLE | PFM_NUMBERINGTAB, p1:=2, p2:=10, p3:=0x200, p4:=20*50)
	if Num0
		hMask |= PFM_NUMBERING, NumPut(NUM_TYPE_%Num1%, PF, 8, "UShort")
		, (Num2 = "") ? "" : (hMask |= PFM_NUMBERINGSTART,  NumPut(Num2, PF, 176, "UShort"))
		, (Num3 = "") ? "" : (hMask |= PFM_NUMBERINGSTYLE,  NumPut(NUM_STYLE_%Num3%, PF, 178, "UShort"))
		, (Num4 = "") ? "" : (hMask |= PFM_NUMBERINGTAB,    NumPut(Num4, PF, 180, "UShort"))

	;S(PF, "PARAFORMAT2! cbSize dwMask bLineSpacingRule dyLineSpacing", sz, PFM_LINESPACING, x:=4, y:=20*50)
	if Line0
		hMask |= PFM_LINESPACING,  NumPut(LINE_RULE_%Line1%, PF, 170, "UChar"),  NumPut(Line2, PF, 164, "Int")

	;S(PF, "PARAFORMAT2! cbSize dwMask dxOffset dxStartIndent dxRightIndent", sz, p:=PFM_OFFSET | PFM_OFFSETINDENT | PFM_RIGHTINDENT, x:=-20*50, y:=20*50, z=x:=20*50)
	if Ident0
		hMask |= 0	;dummy, expression so that bellow works....
		,(Ident1 = "") ? "" : (hMask |= SubStr(Ident1,1,1)!="." ? PFM_OFFSETINDENT : (PFM_STARTINDENT, Ident1 := SubStr(Ident1,2)),  NumPut(Ident1, PF, 12, "Int"))
		,(Ident2 = "") ? "" : (hMask |= PFM_OFFSET,  NumPut(Ident2, PF, 20, "Int"))
		,(Ident3 = "") ? "" : (hMask |= PFM_RIGHTINDENT,  NumPut(Ident3, PF, 16, "Int"))

	;S(PF, "PARAFORMAT2! cbSize dwMask dySpaceAfter dySpaceBefore", sz, p:=PFM_SPACEAFTER | PFM_SPACEBEFORE, x:=20*50, y:=10*50)
	if Space0
		hMask |= 0
		,(Space1 = "") ? "" : (hMask |= PFM_SPACEBEFORE,  NumPut(Space1, PF, 156, "Int"))
		,(Space2 = "") ? "" : (hMask |= PFM_SPACEAFTER,   NumPut(Space2, PF, 160, "Int"))

	;S(PF, "PARAFORMAT2! cbSize dwMask cTabCount rgxTabs", sz, PFM_TABSTOPS, x:=2)		;put 2 tabstops
	;NumPut(20*50, PF, 28+0, "Int"), NumPut(20*250, PF, 28+4, "Int")
	if Tabs0
	{
		loop, parse, Tabs1, %A_Space%%A_Tab%
			NumPut(A_LoopField, PF, 24+(A_Index*4), "Int"), tabCount := A_Index
		NumPut(tabCount, PF, 26, "Short"),  hMask |= PFM_TABSTOPS
	}

	;S(PF, "PARAFORMAT2! cbSize dwMask wBorders wBorderWidth", sz, PFM_BORDER, x:=64, y:=20*5 )	;!!! does not work

    NumPut(hMask, PF, 4)   ; HexView(&PF, sz)
	SendMessage, EM_SETPARAFORMAT,,&PF,,ahk_id %hCtrl%
	return ErrorLevel
}

/*
 Function:	SetEditStyle
			Sets the current edit style flags.

 Parameters:
			Style - One of the styles bellow. Prepend "-" to turn the style off.

 Styles:
			EMULATESYSEDIT	- When this bit is on, rich edit attempts to emulate the system edit control.
			BEEPONMAXTEXT	- Rich Edit will call the system beeper if the user attempts to enter more than the maximum characters.
			EXTENDBACKCOLOR	- Extends the background color all the way to the edges of the client rectangle.
			USEAIMM			- Uses the AIMM input method component that ships with Microsoft Internet Explorer 4.0 or later.
			UPPERCASE		- Converts all input characters to uppercase.
			LOWERCASE		- Converts all input characters to lowercase.
			XLTCRCRLFTOCR	- Turns on translation of CRCRLFs to CRs. When this bit is on and a file is read in, all instances of CRCRLF will be converted to hard CRs internally. This will affect the text wrapping. Note that if such a file is saved as plain text, the CRs will be replaced by CRLFs. This is the .txt standard for plain text.
			SCROLLONKILLFOCUS - When KillFocus occurs, scroll to the beginning of the text.

 Returns:
			State of the edit style flags after rich edit has attempted to implement your edit style changes (number).
 */
RichEdit_SetEditStyle(hCtrl, Style)  {
	static EM_SETEDITSTYLE=0x4CC
		   ,SES_UPPERCASE=512, SES_LOWERCASE=1024, SES_XLTCRCRLFTOCR=16384, SES_EXTENDBACKCOLOR=4, SES_BEEPONMAXTEXT=2, SES_EMULATESYSEDIT=1, SES_USEAIMM=64, SES_SCROLLONKILLFOCUS=8192

	if bOff := (SubStr(Style, 1, 1) = "-")
		Style := SubStr(Style, 2)
	SendMessage, EM_SETEDITSTYLE, bOff ? 0 : SES_%Style%, SES_%Style%,, ahk_id %hCtrl%
	return ErrorLevel
}

/*
 Function:  SetSel
			Selects a range of characters or Component Object Model (COM) objects in a rich edit control.

 Parameters:
			CpMin -	Beginning of range of characters to select.
			CpMax -	End of range of characters to select.

 Remarks:
			If the *cpMin* and *cpMax* members are equal, or *cpMax* is omitted, the cursor will be moved to
			*cpMin*'s position.  The range includes everything if *cpMin* is 0 and *cpMax* is �1.

 Returns:
			The selection that is actually set.

 Related:
			<HideSelection>, <SetText>, <GetSel>, <GetText>, <GetTextLength>

 Example:
 (start code)
  RichEdit_SetSel( hRichEdit, 4, 10 ) ; select range
  RichEdit_SetSel( hRichEdit, 2 )     ; move cursor to right of 2nd character
  RichEdit_SetSel( hRichEdit, 0, -1 ) ; select all
 (end code)
 */
RichEdit_SetSel(hCtrl, CpMin=0, CpMax=0)  {
	static EM_EXSETSEL=1079

	VarSetCapacity(CHARRANGE, 8), NumPut(cpMin, CHARRANGE, 0, "Int"), NumPut(cpMax ? cpMax : cpMin, CHARRANGE, 4, "Int")
	SendMessage, EM_EXSETSEL, , &CHARRANGE,, ahk_id %hCtrl%
	return ErrorLevel
}

/*
 Function:	SetText
			Set text from string or file in rich edit control using either rich text or plain text.

 Parameters:
			Txt		- The text string to set within control. To set RTF mark-up the Txt must be prefixed with "{rtf".
			Flag	- Space separated list of options.  See below list.
			Pos		- This optional parameter allows you to specify a character position you want text inserted to,
					  rather than replacing current selection. To append to the end, use -1.
					  When using SELECTION flag, the position is relative to the current selection text and current selection is expanded to
					  contain new text. If used without SELECTION flag existing selection remains unafected.

 Flags:
			DEFAULT		- Deletes the undo stack, discards rich-text formatting, & replaces all text.
			KEEPUNDO	- Keeps the undo stack.
			SELECTION	- Replaces selection and keeps rich-text formatting. If you don't specify this style entire content of
						  the control will be replaced with the new text.
			FROMFILE	- Load a file into control.  If used, this option expects the *txt* parameter to be
						  a filename. If there is a problem loading the file, *ErrorLevel* will contain message.

 Returns:
		If the operation is setting all of the text and succeeds, the return value is 1.
		If the operation fails, the return value is zero.

 Related:
		<SetSel>, <GetText>, <GetSel>, <TextMode>

 Example:
 (start code)
  FileSelectFile, file,,, Select file, RTF(*.rtf; *.txt)
  RichEdit_SetText(hRichEdit, file, "FROMFILE KEEPUNDO")

  RichEdit_SetText(hRichEdit, "insert..", "SELECTION")

  RichEdit_SetText(hRichEdit, "replace all..")

  RichEdit_SetText(hRichEdit, "append to end of selection..", "SELECTION", -1 )
 (end code)
 */
RichEdit_SetText(HCtrl, Txt="", Flag=0, Pos="" )  {
	static EM_SETTEXTEX=0x461, ST_KEEPUNDO=1, ST_SELECTION=2, StrPut = "StrPut"

	hFlag=0
	If Flag
  		Loop, parse, Flag, %A_Tab%%A_Space%
			If (A_LoopField = "FROMFILE") {
				FileRead, Txt, %Txt%
				IfNotEqual, Errorlevel, 0, return false, ErrorLevel := A_ThisFunc "> Couldn't open file: '" Txt "'"
			} else if A_LoopField in KEEPUNDO,SELECTION
				hFlag |= ST_%A_LoopField%

  ; If specifying a pos, calculate new range for restoring original selection
	if (Pos != "")
		if (hFlag >= ST_SELECTION) {
			RichEdit_GetSel(HCtrl, min, max)
			ifLess, Pos, -1, SetEnv, Pos, 0
			else if (Pos > max-min)
				Pos := max-min

			ifEqual, Pos, -1, SetEnv, Pos, %max%
			else Pos += min

			prevPos := RichEdit_SetSel(HCtrl, Pos)
			max += StrLen(Txt)
		} else {
			hFlag |= ST_SELECTION, len := StrLen(Txt)
			RichEdit_GetSel(HCtrl, min, max)
			prevPos := RichEdit_SetSel(HCtrl, Pos)
			if (Pos < min)
				min += len, max += len
			else if (Pos >= min) && (Pos < max)
				max += len
		}

	VarSetCapacity(SETTEXTEX, 8), NumPut(hFlag, SETTEXTEX)
	/* Didn't make the difference. 
	NumPut(A_IsUnicode ? 1200 : 0, SETTEXTEX, 4)  ;The code page is used to translate the text to Unicode. If codepage is 1200 (Unicode code page),
												  ; no translation is done. If codepage is CP_ACP (0), the system code page is used.
	*/	

	tt := Txt
	if A_IsUnicode
		VarSetCapacity(tt, %StrPut%(Txt, "cp0")), %StrPut%(Txt, &tt, "cp0")
	
	SendMessage, EM_SETTEXTEX, &SETTEXTEX, &tt,, ahk_id %HCtrl%
	return ERRORLEVEL, prevPos != "" ? RichEdit_SetSel(HCtrl, min, max) : ""
}

/*
 Function:  SetUndoLimit
			Set the maximum number of actions that can stored in the undo queue of the rich edit control.

 Parameters:
			nMax - The maximum number of actions that can be stored in the undo queue.

 Returns:
			The return value is the new maximum number of undo actions for the rich edit control.

 Remarks:
			By default, the maximum number of actions in the undo queue is 100. If you increase
			this number, there must be enough available memory to accommodate the new number.
			For better performance, set the limit to the smallest possible value needed.

 Related:
			<Undo>, <GetUndo>, <Redo>, <GetRedo>

 Example:
		> MsgBox, % RichEdit_SetUndoLimit( hRichEdit, 5 )
 */
RichEdit_SetUndoLimit(hCtrl, nMax)  {
	static EM_SETUNDOLIMIT=82,WM_USER=0x400
	if nMax is not integer
		return false
	SendMessage, WM_USER | EM_SETUNDOLIMIT, %nMax%,0,, ahk_id %hCtrl%
	return ERRORLEVEL
}

/*
 Function:  ShowScrollBar
			Shows or hides scroll bars for Edit control.

 Parameters:
			Bar - Identifies which scroll bar to display: horizontal or vertical. This parameter must be
				  "*V*", "*H*", or a combination of the two.

			State - True or false.

 Remarks:
     This method is only valid when the control is in-place active. Calls made while the control is inactive may fail.

 Related:
     <ScrollPos>

 Example:
	 > RichEdit_ShowScrollBar( hRichEdit, "VH", false )
	 > Sleep, 3000
	 >
	 > RichEdit_ShowScrollBar( hRichEdit, "V", true )
 */
RichEdit_ShowScrollBar(hCtrl, Bar, State=true)  {
  static EM_SHOWSCROLLBAR=96,WM_USER=0x400,SB_HORZ=0,SB_VERT=1

	If ( StrLen(bar) <= 2)  {
		If InStr( Bar, "H" )
			SendMessage, WM_USER | EM_SHOWSCROLLBAR, SB_HORZ, State,, ahk_id %hCtrl%
		If InStr( Bar, "V" )
			SendMessage, WM_USER | EM_SHOWSCROLLBAR, SB_VERT, State,, ahk_id %hCtrl%
	}
}

/*
 Function:	TextMode
			Get or set the current text mode of a rich edit control.

 Parameters:
			TextMode - Space separated list of options (see below). If omitted, current text mode is returned.

 Options:
		Specify one of the following values to set the text mode parameter.
		If you don't specify a text mode value, the text mode remains at its current setting.

		PLAINTEXT		 - Indicates plain-text mode, in which the control is similar to a standard edit control.
		RICHTEXT		 - Indicates rich-text mode (default text mode).

		Specify one of the following values to set the undo level parameter. If you don't specify an undo level value, the undo level remains at its current setting.

		SINGLELEVELUNDO  - The control allows the user to undo only the last action in the undo queue.
		MULTILEVELUNDO	 - The control supports multiple undo actions (default undo mode).
						   Use <SetUndoLimit> to set the maximum number of undo actions.

		Specify one of the following values to set the code page parameter. If you don't specify an code page value, the code page remains at its current setting.

		SINGLECODEPAGE	 - The control only allows the English keyboard and a keyboard corresponding
						   to the default character set. For example, you could have Greek and
						   English. Note that this prevents Unicode text from entering the control.
						   For example, use this value if a rich edit control must be restricted to ANSI text.
		MULTICODEPAGE	 - The control allows multiple code pages and Unicode text into the control (default code page mode).

 Returns:
		If *TextMode* is omitted, the return value is the current text mode settings.
		When *TextMode* is given, function will return true or false.

 Remarks:
		The control text will be deleted when calling this function.

		In rich text mode, a rich edit control has standard rich edit functionality.
		However, in plain text mode, the control is similar to a standard edit control :

		- The text in a plain text control can have only one format (such as Bold, 10pt Arial).
		- The user cannot paste rich text formats, such as Rich Text Format (RTF) or embedded objects into a plain text control.
		- Rich text mode controls always have a default end-of-document marker or carriage return, to format paragraphs.
		- Plain text controls, on the other hand, do not need the default, end-of-document marker, so it is omitted.

 Related:
		<SetUndoLimit>

 Example:
	(start code)
	  MsgBox, % "mode= " RichEdit_TextMode(hRichEdit)

	  If RichEdit_TextMode( hRichEdit, "PLAINTEXT SINGLELEVELUNDO" )
			MsgBox, % "new mode= " RichEdit_TextMode(hRichEdit)
	  Else	MsgBox, % errorlevel
	(end code)
 */
RichEdit_TextMode(HCtrl, TextMode="")  {
  static EM_SETTEXTMODE=0x459, EM_GETTEXTMODE=0x45A
		,TM_PLAINTEXT=1, TM_RICHTEXT=2, TM_SINGLELEVELUNDO=4, TM_MULTILEVELUNDO=8, TM_SINGLECODEPAGE=16, TM_MULTICODEPAGE=32
		,TEXTMODES="MULTICODEPAGE,SINGLECODEPAGE,MULTILEVELUNDO,SINGLELEVELUNDO,RICHTEXT,PLAINTEXT"

	If (TextMode)  {    ; Setting text mode
		hTextMode := 0
		Loop, parse, TextMode, %A_Tab%%A_Space%
			ifEqual, A_LoopField,,continue
			else hTextMode |= TM_%A_LOOPFIELD%
	    IfEqual, hTextMode,, return false, ErrorLevel := A_ThisFunc "> Some of the options are invalid: " TextMode

		RichEdit_SetText(HCtrl)
		SendMessage, EM_SETTEXTMODE, hTextMode,,, ahk_id %HCtrl%
		return Errorlevel ? False : True
	}
	else  {				; Getting current text mode
		SendMessage, EM_GETTEXTMODE,,,, ahk_id %HCtrl%
		tm := ErrorLevel
		loop, parse, TEXTMODES,`,
			if (TM_%A_LoopField% & tm)
				res .= A_LoopField " "
		return SubStr(res, 1, -1)
	}
}

/*
 Function:		WordWrap
				Set word wrap mode in rich edit control.

 Parameters:
				Flag	- True or false.

 Returns:
				The return value is zero if the operation fails, or nonzero if it succeeds.

 */
RichEdit_WordWrap(HCtrl, Flag)  {
	static EM_SETTARGETDEVICE=0x448
	SendMessage, EM_SETTARGETDEVICE,NULL,!Flag,, ahk_id %hCtrl%
	return ErrorLevel
}

/*
 Function:	Zoom
			Sets the zoom ratio anywhere between 1/64 and 64.

 Parameters:
			zoom - Integer amount to increase or decrease zoom with *+* or *-* infront of it (see examples).

 Returns:
			If the new zoom setting is accepted, the return value is true.
			If the new zoom setting is not accepted, the return value is false.
			If *zoom* param is omitted, current numerator/denominator ratio is returned.

 Examples:
 > Msgbox, % "zoom ratio: " RichEdit_Zoom( hRichEdit )
 >
 > #MaxHotkeysPerInterval 200
 > #IfWinActive ahk_group RichEditGrp
 > ^WheelUp::   RichEdit_Zoom( hRichEdit, +1 )
 > ^WheelDown:: RichEdit_Zoom( hRichEdit, -1 )
 > #IfWinActive
 */
Richedit_Zoom(hCtrl, zoom=0)  {
  static EM_SETZOOM=225,EM_GETZOOM=224,WM_USER=0x400

  ; Get the current zoom ratio
  VarSetCapacity(numer, 4)  , VarSetCapacity(denom, 4)
  SendMessage, WM_USER | EM_GETZOOM, &numer,&denom,, ahk_id %hCtrl%
  numerator := NumGet(numer, 0, "UShort") ;, denominator := NumGet(denom, 0, "UShort")

  If zoom is not integer
    return false, errorlevel := "ERROR: '" zoom "' is not an integer, stupid"
  If (!zoom)
    return numerator "/" denominator

  ; Calculate new numerator value (denominator not currently changed)
  InStr(zoom,"-") ?  numerator-=SubStr(zoom,2)  :  numerator+=zoom

  ; Set the zoom ratio
  SendMessage, WM_USER | EM_SETZOOM, %numerator%, 1,, ahk_id %hCtrl%
  return ERRORLEVEL
}

/*
 Function:	Undo
			Send message to Edit control to undo the next action in the control's undo queue &
		  optionally empty the undo buffer by resetting the undo flag.

 Parameters:
			Reset - Set to true to clear the undo buffer rather than send undo command.

 Returns:
			For a single-line edit control, the return value is always true.
			For a multiline edit control, the return value is true if the undo operation is
			successful, or false if the undo operation fails, or your resetting the undo queue.
 */
RichEdit_Undo(hCtrl, Reset=false)  {
  static EM_UNDO=0xC7,EM_EMPTYUNDOBUFFER=0xCD
  If !reset  {
    SendMessage, EM_UNDO,,,, ahk_id %hCtrl%
    return ERRORLEVEL
  } else SendMessage, EM_EMPTYUNDOBUFFER,,,, ahk_id %hCtrl%
}

;========================================== PRIVATE ===================================================================

RichEdit_add2Form(hParent, Txt, Opt){
	static parse = "Form_Parse"
	%parse%(Opt, "x# y# w# h# style", x, y, w, h, style)
	hCtrl := RichEdit_Add(hParent, x, y, w, h, style, Txt)
	return hCtrl
}


RichEdit_onNotify(Wparam, Lparam, Msg, Hwnd) {
	static MODULEID := 091009, oldNotify="*", oldCOMMAND="*"
		  ,ENM_PROTECTED=1796, ENM_REQUESTRESIZE=1793, ENM_SELCHANGE=1794, ENM_DROPFILES=1795, ENM_DRAGDROPDONE=1804, ENM_LINK=1803

	critical		;its OK, always executed in its own thread.
	if (_ := (NumGet(Lparam+4))) != MODULEID
	 ifLess _, 10000, return	;if ahk control, return asap (AHK increments control ID starting from 1. Custom controls use IDs > 10000 as its unlikely that u will use more then 10K ahk controls.
	 else {
		ifEqual, oldNotify, *, SetEnv, oldNotify, % RichEdit("oldNotify")
		if oldNotify !=
			 return DllCall(oldNotify, "uint", Wparam, "uint", Lparam, "uint", Msg, "uint", Hwnd)
		else return
		;ifEqual, oldCOMMAND, *, SetEnv, oldCOMMAND, % RichEdit("oldCOMMAND")
		;if oldCOMMAND !=
		;	return DllCall(oldCOMMAND, "uint", Wparam, "uint", Lparam, "uint", Msg, "uint", Hwnd)
	 }

	hw :=  NumGet(Lparam+0), code := NumGet(Lparam+8, 0, "UInt"),  handler := RichEdit(hw "Handler")
	ifEqual, handler,,return code=ENM_PROTECTED ? TRUE : FALSE  ;ENM_PROTECTED msg returns nonzero value to prevent operation

	If (code = 1792) {					;ENM_MOUSEEVENTS ENM_KEYEVENTS ENM_SCROLLEVENTS
		static 258="KEYPRESS_DWN",513="MOUSE_L_DWN",514="MOUSE_L_UP",516="MOUSE_R_DWN",517="MOUSE_R_UP",522="SCROLL_BEGIN",277="SCROLL_END" ;,512="MOUSE_HOVER",256="KEYPRESS_UP"

		umsg := NumGet(lparam+12)		;Keyboard or mouse message identifier.
		key := ((n:=NumGet(lparam+40))>=32) ? Chr(n) : ""
		If (%umsg%)   ;***
			return %handler%(hw, %Umsg%, key, "", "")
	}

	If (code = ENM_REQUESTRESIZE)  {
		rc := NumGet(lparam+24) ;Requested new size.
		return %handler%(hw, "REQUESTRESIZE", rc, "", "")
	}

	if (code = ENM_SELCHANGE)  {
		cpMin := NumGet(lparam+12), cpMax := NumGet(lparam+16), selType := RichEdit_SelectionType(-NumGet(lparam+20))
		return %handler%(hw, "SELCHANGE", cpMin, cpMax, seltype)
	}

	If (code = ENM_DROPFILES)  {          ;
		hDrop := NumGet(lparam+8, 4 , "UInt"), cp := NumGet(lparam+8, 8 , "Int")

		; (thanks DerRaphael!)  http://www.autohotkey.com/forum/post-234905.html&highlight=#234905
		Loop,% file_count := DllCall("shell32.dll\DragQueryFile","uInt",hDrop,"uInt",0xFFFFFFFF,"uInt",0,"uInt",0) {
		   VarSetCapacity(lpSzFile,4096,0)
		   DllCall("shell32.dll\DragQueryFile","uInt",hDrop,"uInt",A_index-1,"uInt",&lpSzFile,"uInt",4096)
		   VarSetCapacity(lpSzFile,-1)
		   files .= ((A_Index>1) ? "`n" : "") lpSzFile
		}
		return %handler%(hw, "DROPFILES", file_count, files, cp)
	}

	If (code = ENM_DRAGDROPDONE)  {
		chars := NumGet(lparam+12), cpMax := NumGet(lparam+16)
		return %handler%(hw, "DRAGDROPDONE", chars, cpMax-chars, cpMax)
	}

	If (code = ENM_PROTECTED)  {
		cpMin := NumGet(lparam+24), cpMax := NumGet(lparam+28)
		return %handler%(hw, "PROTECTED", cpMin, cpMax, "") ; This message returns a nonzero value to prevent the operation.
	}

	If (code = ENM_LINK )  {
		umsg := NumGet(lparam+12)
		If umsg Not In 513,516
			 return
		cpMin := NumGet(lparam+24), cpMax := NumGet(lparam+28)
		return %handler%(hw, "LINK", (Umsg = 513 ? "LClick" : "RClick"), cpMin, cpMax) ; This message returns a nonzero value to prevent the operation.
	}
}

RichEdit_wndProc(hwnd, uMsg, wParam, lParam){

    if (uMsg = 0x87)  ;WM_GETDLGCODE
		return 4	 ;DLGC_WANTALLKEYS

   return DllCall("CallWindowProcA", "UInt", A_EventInfo, "UInt", hwnd, "UInt", uMsg, "UInt", wParam, "UInt", lParam)
}

RichEdit_editStreamCallBack(dwCookie, pbBuff, cb, pcb) {
	static s

	if (dwCookie="!") {
		fn := pbBuff
		ifEqual, fn,, return l := s, VarSetCapacity(s,0)
		FileDelete, %fn%
		FileAppend, %s%, %fn%
		return VarSetCapacity(s, 0)
	}

	if s =
		 VarSetCapacity(s, dwCookie)

	s .= DllCall("MulDiv", "Int", pbBuff, "Int",1, "Int", 1, "str")
}

;Mini storage
RichEdit(var="", value="~`a", ByRef o1="", ByRef o2="", ByRef o3="", ByRef o4="", ByRef o5="", ByRef o6="") {
	static
	 _ := %var%
	ifNotEqual, value, ~`a, SetEnv, %var%, %value%
	return _
}

/* Group: About
	o Version 1.0c by freakkk & majkinetor.
	o MSDN Reference : <http://msdn.microsoft.com/en-us/library/bb787605(VS.85).aspx>.
	o RichEdit control shortcut keys: <http://msdn.microsoft.com/en-us/library/bb787873(VS.85).aspx#rich_edit_shortcut_keys>.
	o Licensed under BSD <http://creativecommons.org/licenses/BSD/>.
 */
 
 ;//******************* Functions *******************
;//Sun, Jul 13, 2008 --- 7/13/08, 7:19:19pm
;//Function: ListView_HeaderFontSet
;//Params...
;//		p_hwndlv    = ListView hwnd
;//		p_fontstyle = [b[old]] [i[talic]] [u[nderline]] [s[trike]]
;//		p_fontname  = <any single valid font name = Arial, Tahoma, Trebuchet MS>
ListView_HeaderFontSet(p_hwndlv="", p_fontstyle="", p_fontname="") {
	static hFont1stBkp
	method:="CreateFont"
	;//method="CreateFontIndirect"
	WM_SETFONT:=0x0030
	WM_GETFONT:=0x0031

	LVM_FIRST:=0x1000
	LVM_GETHEADER:=LVM_FIRST+31

	;// /* Font Weights */
	FW_DONTCARE:=0
	FW_THIN:=100
	FW_EXTRALIGHT:=200
	FW_LIGHT:=300
	FW_NORMAL:=400
	FW_MEDIUM:=500
	FW_SEMIBOLD:=600
	FW_BOLD:=700
	FW_EXTRABOLD:=800
	FW_HEAVY:=900

	FW_ULTRALIGHT:=FW_EXTRALIGHT
	FW_REGULAR:=FW_NORMAL
	FW_DEMIBOLD:=FW_SEMIBOLD
	FW_ULTRABOLD:=FW_EXTRABOLD
	FW_BLACK:=FW_HEAVY
	/*
	parse p_fontstyle for...
		cBlue	color	*** Note *** OMG can't set ListView/SysHeader32 font/text color??? ***
		s19		size
		b		bold
		w500	weight?
	*/
	;//*** Note *** yes I will allow mixed types later!...this was quick n dirty...
	;//*** Note *** ...it now supports bold italic underline & strike-thru...all at once
	style:=p_fontstyle
	;//*** Note *** change RegExReplace to RegExMatch
	style:=RegExReplace(style, "i)\s*\b(?:I|U|S)*B(?:old)?(?:I|U|S)*\b\s*", "", style_bold)
	style:=RegExReplace(style, "i)\s*\b(?:B|U|S)*I(?:talic)?(?:B|U|S)*\b\s*", "", style_italic)
	style:=RegExReplace(style, "i)\s*\b(?:B|I|S)*U(?:nderline)?(?:B|I|S)*\b\s*", "", style_underline)
	style:=RegExReplace(style, "i)\s*\b(?:B|I|U)*S(?:trike)?(?:B|I|U)*\b\s*", "", style_strike)
	;//style:=RegExReplace(style, "i)\s*\bW(?:eight)(\d+)\b\s*", "", style_weight)
	if (style_bold)
		fnWeight:=FW_BOLD
	if (style_italic)
		fdwItalic:=1
	if (style_underline)
		fdwUnderline:=1
	if (style_strike)
		fdwStrikeOut:=1
	;//if (mweight)
	;//	fnWeight:=mweight
	lpszFace:=p_fontname

	ret:=hHeader:=SendMessage(p_hwndlv, LVM_GETHEADER, 0, 0)
	el:=Errorlevel
	le:=A_LastError
	;//msgbox, 64, , SendMessage LVM_GETHEADER: ret(%ret%) el(%el%) le(%le%)

	ret:=hFontCurr:=SendMessage(hHeader, WM_GETFONT, 0, 0)
	el:=Errorlevel
	le:=A_LastError
	;//msgbox, 64, , SendMessage WM_GETFONT: ret(%ret%) el(%el%) le(%le%)
	if (!hFont1stBkp) {
		hFont1stBkp:=hFontCurr
	}

	if (method="CreateFont") {
		if (p_fontstyle!="" || p_fontname!="") {
			ret:=hFontHeader:=CreateFont(nHeight, nWidth, nEscapement, nOrientation
										, fnWeight, fdwItalic, fdwUnderline, fdwStrikeOut
										, fdwCharSet, fdwOutputPrecision, fdwClipPrecision
										, fdwQuality, fdwPitchAndFamily, lpszFace)
			el:=Errorlevel
			le:=A_LastError
			;//msgbox, 64, , CreateFont: ret(%ret%) el(%el%) le(%le%)
		} else hFontHeader:=hFont1stBkp
		ret:=SendMessage(hHeader, WM_SETFONT, hFontHeader, 1)
		;//ret:=SendMessage(hHeader, WM_SETFONT, hFontHeader, 0)
		;//ret:=SendMessage(hHeader, WM_SETFONT, &0, 1)
		el:=Errorlevel
		le:=A_LastError
		;//msgbox, 64, , SendMessage WM_SETFONT: ret(%ret%) el(%el%) le(%le%)
	}
}

/*
HFONT CreateFont(
  int nHeight,               // height of font
  int nWidth,                // average character width
  int nEscapement,           // angle of escapement
  int nOrientation,          // base-line orientation angle
  int fnWeight,              // font weight
  DWORD fdwItalic,           // italic attribute option
  DWORD fdwUnderline,        // underline attribute option
  DWORD fdwStrikeOut,        // strikeout attribute option
  DWORD fdwCharSet,          // character set identifier
  DWORD fdwOutputPrecision,  // output precision
  DWORD fdwClipPrecision,    // clipping precision
  DWORD fdwQuality,          // output quality
  DWORD fdwPitchAndFamily,   // pitch and family
  LPCTSTR lpszFace           // typeface name
);
*/
CreateFont(               nHeight                   , nWidth                  , nEscapement
						, nOrientation              , fnWeight                , fdwItalic
						, fdwUnderline              , fdwStrikeOut            , fdwCharSet
						, fdwOutputPrecision        , fdwClipPrecision        , fdwQuality
						, fdwPitchAndFamily         , lpszFace) {
	return DllCall("CreateFont"
				, "Int" , nHeight           , "Int" , nWidth          , "Int" , nEscapement
				, "Int" , nOrientation      , "Int" , fnWeight        , "UInt", fdwItalic
				, "UInt", fdwUnderline      , "UInt", fdwStrikeOut    , "UInt", fdwCharSet
				, "UInt", fdwOutputPrecision, "UInt", fdwClipPrecision, "UInt", fdwQuality
				, "UInt", fdwPitchAndFamily , "Str" , lpszFace)
}

SendMessage(p_hwnd, p_msg, p_wParam="", p_lParam="") {
	return DllCall("SendMessage", "UInt", p_hwnd, "UInt", p_msg, "UInt", p_wParam, "UInt", p_lParam)
}

;//           Msg [, wParam     , lParam     , Control  , WinTitle  , WinText  , ExcludeTitle     , ExcludeText
A_SendMessage(p_msg, p_wParam="", p_lParam="", p_ctrl="", p_title="", p_text="", p_excludetitle="", p_excludetext="") {
	SendMessage, p_msg, p_wParam, p_lParam, %p_ctrl%, %p_title%, %p_text%, %p_excludetitle%, %p_excludetext%
	return errorlevel
}
;//******************* /Functions *******************