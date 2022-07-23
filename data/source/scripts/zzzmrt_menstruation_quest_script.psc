Scriptname zzzmrt_Menstruation_Quest_Script extends Quest  Conditional

LeveledItem Property SanityNapkinList Auto
LeveledItem Property LItemMiscVendorMiscItems75 Auto
GlobalVariable Property HoursToExpireSanityNapkin Auto
Actor Property Player Auto
Spell Property DrippingBloodSpell Auto
MiscObject Property SanityNapkin Auto
MagicEffect Property Menstruation Auto
GlobalVariable Property gLItemMiscVendorMiscItems75 Auto
GlobalVariable Property JSW_BB_Enabled  Auto
GlobalVariable Property DrippingBloodCommentsToggle Auto
GlobalVariable Property DrippingBloodHelpfulCommentsToggle Auto
Faction Property JSW_SUB_TrackedFemFaction Auto
Faction Property JSW_SUB_CycleBuffFaction Auto

Bool Property isSanityNapkinRegisterd Auto Conditional


Float Function getBaseVersion()
	Return 1.0
EndFunction

Float Function getCurrentVersion()
	Return getBaseVersion() + 0.02
EndFunction


Event OnInit()
	Player.AddSpell(DrippingBloodSpell)
	If gLItemMiscVendorMiscItems75.GetValueInt() != 1
		LItemMiscVendorMiscItems75.AddForm(SanityNapkinList,1,1)
		gLItemMiscVendorMiscItems75.SetValueInt(1)
	EndIf
	isSanityNapkinRegisterd = False
	Debug.Trace("Fertility Menstruation Effects initilized.")
EndEvent

Event OnUpdateGameTime()
	isSanityNapkinRegisterd = False
	RegisterForSingleUpdate(15.0)
	plugItUp()
EndEvent

Event OnUpdate()
	Utility.Wait(0.2)
	plugItUp()
EndEvent

Function plugItUp()
	If bIsMenstruating()
		If !isSanityNapkinRegisterd
			If Player.GetItemCount(SanityNapkin) > 0
				Player.RemoveItem(SanityNapkin,1)
				RegisterForSingleUpdateGameTime(maxInt(1,HoursToExpireSanityNapkin.GetValueInt()))
				isSanityNapkinRegisterd = True
			Else
				Debug.Notification("You need a new sanitary napkin.")
			EndIf
		EndIf
	Else
		isSanityNapkinRegisterd = False
	EndIf
EndFunction

Bool Function bIsMenstruating()
	If JSW_BB_Enabled.GetValueInt() == 1
		If Player.GetFactionRank(JSW_SUB_TrackedFemFaction) == -35
			If Player.GetFactionRank(JSW_SUB_CycleBuffFaction) > 0
				If Player.HasSpell(DrippingBloodSpell)
					If Player.HasMagicEffect(Menstruation)
						Return True
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	Return False
EndFunction

Function stopThis()
	Player.RemoveSpell(DrippingBloodSpell)
EndFunction

Function startThis()
	OnInit()
EndFunction

Int Function maxInt(Int a, Int b)
	If a > b
		Return a
	EndIf
	return b
EndFunction