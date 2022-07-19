Scriptname zzzmrt_Menstruation_Quest_Script extends Quest  Conditional

LeveledItem Property SanityNapkinList Auto
LeveledItem Property LItemMiscVendorMiscItems75 Auto
GlobalVariable Property HoursToExpireSanityNapkin Auto
Actor Property Player Auto
Spell Property MenstruationSpell Auto
MiscObject Property SanityNapkin Auto
MagicEffect Property Menstruation Auto 
Bool Property isSanityNapkinRegisterd Auto Conditional

Event OnInit()
	Player.AddSpell(MenstruationSpell)
	LItemMiscVendorMiscItems75.AddForm(SanityNapkinList,1,1)
	isSanityNapkinRegisterd = False
EndEvent

Event OnUpdateGameTime()
	isSanityNapkinRegisterd = False
	Utility.Wait(3.0)
	 plugItUp()
EndEvent

Event OnUpdate()
	Utility.Wait(0.2)
	plugItUp()
EndEvent

Function plugItUp()
	If Player.HasMagicEffect(Menstruation)
		If !isSanityNapkinRegisterd
			If Player.GetItemCount(SanityNapkin) > 0
				Player.RemoveItem(SanityNapkin,1)
				RegisterForSingleUpdateGameTime(maxInt(1,HoursToExpireSanityNapkin.GetValueInt()))
				isSanityNapkinRegisterd = True
			Else
				Debug.Notification("You need a new Sanity napkin.")
			EndIf
		EndIf
	Else
		isSanityNapkinRegisterd = False
	EndIf
EndFunction

Int Function maxInt(Int a, Int b)
	If a > b
		Return a
	EndIf
	return b
EndFunction