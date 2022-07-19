Scriptname zzzmrt_Menstruation_Script extends activemagiceffect  

Quest Property MenstruationQuest Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	MenstruationQuest.RegisterForSingleUpdate(1.0)
EndEvent
