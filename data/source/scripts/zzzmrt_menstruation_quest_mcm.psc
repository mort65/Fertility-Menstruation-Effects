Scriptname zzzmrt_menstruation_quest_mcm extends SKI_ConfigBase

String Property myName = "FM's Menstruation Effects" Auto Hidden
zzzmrt_Menstruation_Quest_Script property MainScript Auto

Int flags

Event OnConfigInit()
	ModName = myName
	initPages()
EndEvent

Function initPages()
EndFunction

int Function GetVersion()
	return 1
EndFunction

Event OnVersionUpdate(int a_version)
	if a_version > 1
		OnConfigInit()
	endif
EndEvent

Event OnConfigClose()
EndEvent

Event OnGameReload()
	Parent.OnGameReload()
EndEvent


Event OnPageReset(string page)
	SetCursorFillMode(LEFT_TO_RIGHT)

	AddToggleOptionST("ST_MOD_ENABLE", "$ST_MOD_ENABLE_TOGGLE", Game.GetPlayer().HasSpell(MainScript.DrippingBloodSpell))
	If (Game.GetPlayer().HasSpell(MainScript.DrippingBloodSpell))
		flags = OPTION_FLAG_NONE
	Else
		flags = OPTION_FLAG_DISABLED
	EndIf
	AddToggleOptionST("ST_MOD_RESET", "$ST_MOD_RESET_TOGGLE", False, flags)
	AddEmptyOption()
	AddEmptyOption()
	AddToggleOptionST("ST_COMMENT_TOGGLE", "$ST_COMMENT_TOGGLE", MainScript.DrippingBloodCommentsToggle.GetValueInt() as Bool,flags)
	AddEmptyOption()
	If (Game.GetPlayer().HasSpell(MainScript.DrippingBloodSpell) && (MainScript.DrippingBloodCommentsToggle.GetValueInt() as Bool))
		flags = OPTION_FLAG_NONE
	Else
		flags = OPTION_FLAG_DISABLED
	EndIf
	AddToggleOptionST("ST_COMMENT_HELPFUL_TOGGLE", "$ST_COMMENT_HELPFUL_TOGGLE", MainScript.DrippingBloodHelpfulCommentsToggle.GetValueInt() as Bool,flags)
	AddEmptyOption()
	If (Game.GetPlayer().HasSpell(MainScript.DrippingBloodSpell))
		flags = OPTION_FLAG_NONE
	Else
		flags = OPTION_FLAG_DISABLED
	EndIf
	AddSliderOptionST("ST_NAPKIN_DURATION", "$ST_NAPKIN_DURATION",MainScript.HoursToExpireSanityNapkin.GetValue(),"$ST_NAPKIN_DURATION_1",flags)
EndEvent

State ST_MOD_ENABLE
	Event OnSelectST()
		If Game.GetPlayer().HasSpell(MainScript.DrippingBloodSpell)
			MainScript.stopThis()
		Else
			MainScript.startThis()
		EndIf
		ForcePageReset()
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$ST_MOD_ENABLE_DESC")
	EndEvent
	
	Event OnDefaultST()
	EndEvent
EndState

State ST_MOD_RESET
	Event OnSelectST()
		SetToggleOptionValueST(True)
		utility.Wait(1.0)
		MainScript.stopThis()
		MainScript.startThis()
		ForcePageReset()
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$ST_MOD_RESET_DESC")
	EndEvent
	
	Event OnDefaultST()
	EndEvent
EndState

State ST_COMMENT_TOGGLE
	Event OnSelectST()
		If MainScript.DrippingBloodCommentsToggle.GetValueInt()
			MainScript.DrippingBloodCommentsToggle.SetValueInt(0)
		Else
			MainScript.DrippingBloodCommentsToggle.SetValueInt(1)
		EndIf
		ForcePageReset()
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$ST_COMMENT_DESC")
	EndEvent
	
	Event OnDefaultST()
	EndEvent
EndState

State ST_COMMENT_HELPFUL_TOGGLE
	Event OnSelectST()
		If MainScript.DrippingBloodHelpfulCommentsToggle.GetValueInt()
			MainScript.DrippingBloodHelpfulCommentsToggle.SetValueInt(0)
		Else
			MainScript.DrippingBloodHelpfulCommentsToggle.SetValueInt(1)
		EndIf
		ForcePageReset()
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$ST_COMMENT_HELPFULl_DESC")
	EndEvent
	
	Event OnDefaultST()
	EndEvent
EndState

State ST_NAPKIN_DURATION
	Event OnSliderOpenST()
		SetSliderDialogStartValue(MainScript.HoursToExpireSanityNapkin.GetValue())
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(1.0, 24.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(float value)
		MainScript.HoursToExpireSanityNapkin.SetValueInt(value as Int)
		SetSliderOptionValueST(value, "$ST_NAPKIN_DURATION_1")
	EndEvent

	Event OnHighlightST()
		SetInfoText("$ST_NAPKIN_DURATION_DESC")
	EndEvent
	
	Event OnDefaultST()
	EndEvent
EndState