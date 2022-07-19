Scriptname zzzmrt_Sanity_Napkin_Script extends ObjectReference  

Actor Property Player Auto
Quest Property MenstruationQuest Auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If ((akNewContainer != None) && (Player as ObjectReference == akNewContainer))
		MenstruationQuest.RegisterForSingleUpdate(1.0)
	EndIf
EndEvent
