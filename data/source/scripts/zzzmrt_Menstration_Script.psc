Scriptname zzzmrt_Menstration_Script extends Activemagiceffect  

GlobalVariable Property SanityNapkinRegisterd Auto
GlobalVariable Property HoursToExpireSanityNapkin Auto
Quest Property MenstrationQuest Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If SanityNapkinRegisterd.GetValueInt() != 1
		MenstrationQuest.RegisterForSingleUpdateGameTime(HoursToExpireSanityNapkin.GetValueInt())
	EndIf
EndEvent
