Scriptname zzzmrt_Menstration_Quest_Script extends Quest

LeveledItem Property SanityNapkinList Auto
LeveledItem Property LItemMiscVendorMiscItems75 Auto
GlobalVariable Property SanityNapkinRegisterd Auto
GlobalVariable Property HoursToExpireSanityNapkin Auto
Actor Property Player Auto
Spell Property MenstrationSpell Auto
MiscObject Property SanityNapkin Auto
MagicEffect Property Menstration Auto 


Event OnInit()
	Game.GetPlayer().AddSpell(MenstrationSpell)
	LItemMiscVendorMiscItems75.AddForm(SanityNapkinList,1,1)
EndEvent

Event OnUpdateGameTime()
	If SanityNapkinRegisterd.GetValueInt() == 1
		If Player.HasMagicEffect(Menstration)
			Player.RemoveItem(SanityNapkin,1)
			If Player.GetItemCount(SanityNapkin) > 0
				RegisterForSingleUpdateGameTime(HoursToExpireSanityNapkin.GetValueInt())
			Else
				SanityNapkinRegisterd.SetValueInt(0)
			EndIf
		EndIf
	EndIf
EndEvent

