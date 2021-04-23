GetLineActionType(Line){
    static Actions := [], _1 := Actions.Insert(0
        , "ACT_INVALID"
        , "ACT_ASSIGN", "ACT_ASSIGNEXPR", "ACT_EXPRESSION", "ACT_ADD", "ACT_SUB", "ACT_MULT", "ACT_DIV"
        , "ACT_ELSE"
        , "ACT_IFIN", "ACT_IFNOTIN", "ACT_IFCONTAINS", "ACT_IFNOTCONTAINS", "ACT_IFIS", "ACT_IFISNOT"
        , "ACT_IFBETWEEN", "ACT_IFNOTBETWEEN"
        , "ACT_IFEXPR"
        , "ACT_IFEQUAL", "ACT_IFNOTEQUAL", "ACT_IFGREATER", "ACT_IFGREATEROREQUAL", "ACT_IFLESS", "ACT_IFLESSOREQUAL"
        , "ACT_IFWINEXIST", "ACT_IFWINNOTEXIST", "ACT_IFWINACTIVE", "ACT_IFWINNOTACTIVE"
        , "ACT_IFINSTRING", "ACT_IFNOTINSTRING"
        , "ACT_IFEXIST", "ACT_IFNOTEXIST"
        , "ACT_IFMSGBOX"
        , "ACT_MSGBOX", "ACT_INPUTBOX", "ACT_SPLASHTEXTON", "ACT_SPLASHTEXTOFF", "ACT_PROGRESS", "ACT_SPLASHIMAGE"
        , "ACT_TOOLTIP", "ACT_TRAYTIP", "ACT_INPUT"
        , "ACT_TRANSFORM", "ACT_STRINGLEFT", "ACT_STRINGRIGHT", "ACT_STRINGMID"
        , "ACT_STRINGTRIMLEFT", "ACT_STRINGTRIMRIGHT", "ACT_STRINGLOWER", "ACT_STRINGUPPER"
        , "ACT_STRINGLEN", "ACT_STRINGGETPOS", "ACT_STRINGREPLACE", "ACT_STRINGSPLIT", "ACT_SPLITPATH", "ACT_SORT"
        , "ACT_ENVGET", "ACT_ENVSET", "ACT_ENVUPDATE"
        , "ACT_RUNAS", "ACT_RUN", "ACT_RUNWAIT", "ACT_URLDOWNLOADTOFILE"
        , "ACT_GETKEYSTATE"
        , "ACT_SEND", "ACT_SENDRAW", "ACT_SENDINPUT", "ACT_SENDPLAY", "ACT_SENDEVENT"
        , "ACT_CONTROLSEND", "ACT_CONTROLSENDRAW", "ACT_CONTROLCLICK", "ACT_CONTROLMOVE", "ACT_CONTROLGETPOS", "ACT_CONTROLFOCUS"
        , "ACT_CONTROLGETFOCUS", "ACT_CONTROLSETTEXT", "ACT_CONTROLGETTEXT", "ACT_CONTROL", "ACT_CONTROLGET"
        , "ACT_SENDMODE", "ACT_SENDLEVEL", "ACT_COORDMODE", "ACT_SETDEFAULTMOUSESPEED"
        , "ACT_CLICK", "ACT_MOUSEMOVE", "ACT_MOUSECLICK", "ACT_MOUSECLICKDRAG", "ACT_MOUSEGETPOS"
        , "ACT_STATUSBARGETTEXT", "ACT_STATUSBARWAIT"
        , "ACT_CLIPWAIT", "ACT_KEYWAIT"
        , "ACT_SLEEP", "ACT_RANDOM"
        , "ACT_GOTO", "ACT_GOSUB", "ACT_ONEXIT", "ACT_HOTKEY", "ACT_SETTIMER", "ACT_CRITICAL", "ACT_THREAD", "ACT_RETURN", "ACT_EXIT"
        , "ACT_LOOP", "ACT_FOR", "ACT_WHILE", "ACT_UNTIL", "ACT_BREAK", "ACT_CONTINUE"
        , "ACT_TRY", "ACT_CATCH", "ACT_THROW"
        , "ACT_BLOCK_BEGIN", "ACT_BLOCK_END"
        , "ACT_WINACTIVATE", "ACT_WINACTIVATEBOTTOM"
        , "ACT_WINWAIT", "ACT_WINWAITCLOSE", "ACT_WINWAITACTIVE", "ACT_WINWAITNOTACTIVE"
        , "ACT_WINMINIMIZE", "ACT_WINMAXIMIZE", "ACT_WINRESTORE"
        , "ACT_WINHIDE", "ACT_WINSHOW"
        , "ACT_WINMINIMIZEALL", "ACT_WINMINIMIZEALLUNDO"
        , "ACT_WINCLOSE", "ACT_WINKILL", "ACT_WINMOVE", "ACT_WINMENUSELECTITEM", "ACT_PROCESS"
        , "ACT_WINSET", "ACT_WINSETTITLE", "ACT_WINGETTITLE", "ACT_WINGETCLASS", "ACT_WINGET", "ACT_WINGETPOS", "ACT_WINGETTEXT"
        , "ACT_SYSGET", "ACT_POSTMESSAGE", "ACT_SENDMESSAGE"
        , "ACT_PIXELGETCOLOR", "ACT_PIXELSEARCH", "ACT_IMAGESEARCH"
        , "ACT_GROUPADD", "ACT_GROUPACTIVATE", "ACT_GROUPDEACTIVATE", "ACT_GROUPCLOSE"
        , "ACT_DRIVESPACEFREE", "ACT_DRIVE", "ACT_DRIVEGET"
        , "ACT_SOUNDGET", "ACT_SOUNDSET", "ACT_SOUNDGETWAVEVOLUME", "ACT_SOUNDSETWAVEVOLUME", "ACT_SOUNDBEEP", "ACT_SOUNDPLAY"
        , "ACT_FILEAPPEND", "ACT_FILEREAD", "ACT_FILEREADLINE", "ACT_FILEDELETE", "ACT_FILERECYCLE", "ACT_FILERECYCLEEMPTY"
        , "ACT_FILEINSTALL", "ACT_FILECOPY", "ACT_FILEMOVE", "ACT_FILECOPYDIR", "ACT_FILEMOVEDIR"
        , "ACT_FILECREATEDIR", "ACT_FILEREMOVEDIR"
        , "ACT_FILEGETATTRIB", "ACT_FILESETATTRIB", "ACT_FILEGETTIME", "ACT_FILESETTIME"
        , "ACT_FILEGETSIZE", "ACT_FILEGETVERSION"
        , "ACT_SETWORKINGDIR", "ACT_FILESELECTFILE", "ACT_FILESELECTFOLDER", "ACT_FILEGETSHORTCUT", "ACT_FILECREATESHORTCUT"
        , "ACT_INIREAD", "ACT_INIWRITE", "ACT_INIDELETE"
        , "ACT_REGREAD", "ACT_REGWRITE", "ACT_REGDELETE", "ACT_SETREGVIEW"
        , "ACT_OUTPUTDEBUG"
        , "ACT_SETKEYDELAY", "ACT_SETMOUSEDELAY", "ACT_SETWINDELAY", "ACT_SETCONTROLDELAY", "ACT_SETBATCHLINES"
        , "ACT_SETTITLEMATCHMODE", "ACT_SETFORMAT", "ACT_FORMATTIME"
        , "ACT_SUSPEND", "ACT_PAUSE"
        , "ACT_AUTOTRIM", "ACT_STRINGCASESENSE", "ACT_DETECTHIDDENWINDOWS", "ACT_DETECTHIDDENTEXT", "ACT_BLOCKINPUT"
        , "ACT_SETNUMLOCKSTATE", "ACT_SETSCROLLLOCKSTATE", "ACT_SETCAPSLOCKSTATE", "ACT_SETSTORECAPSLOCKMODE"
        , "ACT_KEYHISTORY", "ACT_LISTLINES", "ACT_LISTVARS", "ACT_LISTHOTKEYS"
        , "ACT_EDIT", "ACT_RELOAD", "ACT_MENU", "ACT_GUI", "ACT_GUICONTROL", "ACT_GUICONTROLGET"
        , "ACT_EXITAPP"
        , "ACT_SHUTDOWN"
        , "ACT_FILEENCODING")
    static AHKThread := AhkDllthread("Lib/AutoHotkey" . (A_IsUnicode ? "U" : "A") . ((A_PtrSize = 4) ? "32" : "64") . ".dll")
    static _2 := AHKThread.ahktextdll()
    pLine := AHKThread.addScript(line,false)
    If pLine = 0xFFFFFFFF
        Return Actions[0]
    Return Actions[NumGet(pLine + 0,0,"UChar")] ;ActionType
}