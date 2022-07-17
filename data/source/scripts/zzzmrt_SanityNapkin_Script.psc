Scriptname zzzmrt_SanityNapkin_Script extends ObjectReference  

GlobalVariable Property SanityNapkinRegisterd Auto
GlobalVariable Property HoursToExpireSanityNapkin Auto 
Actor Property Player Auto
Quest Property MenstrationQuest Auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If (SanityNapkinRegisterd.GetValueInt() != 1)
		If (akNewContainer != None && (akNewContainer == Player))
				MenstrationQuest.RegisterForSingleUpdateGameTime(HoursToExpireSanityNapkin.GetValueInt())
				SanityNapkinRegisterd.SetValueInt(1)
		EndIf
	EndIf
EndEvent