/obj/machinery/wish_granter
	name = "wish granter"
	desc = "You're not so sure about this, anymore..."
	icon = 'icons/obj/device.dmi'
	icon_state = "syndbeacon"

	use_power = 0
	anchored = 1
	density = 1

	var/charges = 1
	var/insisting = 0

/obj/machinery/wish_granter/attack_hand(mob/living/carbon/user)
	if(charges <= 0)
		user.text2tab("The Wish Granter lies silent.")
		return

	else if(!ishuman(user))
		user.text2tab("You feel a dark stirring inside of the Wish Granter, something you want nothing of. Your instincts are better than any man's.")
		return

	else if(is_special_character(user))
		user.text2tab("Even to a heart as dark as yours, you know nothing good will come of this.  Something instinctual makes you pull away.")

	else if (!insisting)
		user.text2tab("Your first touch makes the Wish Granter stir, listening to you.  Are you really sure you want to do this?")
		insisting++

	else
		user.text2tab("You speak.  [pick("I want the station to disappear","Humanity is corrupt, mankind must be destroyed","I want to be rich", "I want to rule the world","I want immortality.")].  The Wish Granter answers.")
		user.text2tab("Your head pounds for a moment, before your vision clears.  You are the avatar of the Wish Granter, and your power is LIMITLESS!  And it's all yours.  You need to make sure no one can take it from you.  No one can know, first.")

		charges--
		insisting = 0

		user.dna.add_mutation(HULK)
		user.dna.add_mutation(XRAY)
		user.dna.add_mutation(COLDRES)
		user.dna.add_mutation(TK)

		ticker.mode.traitors += user.mind
		user.mind.special_role = "Avatar of the Wish Granter"

		var/datum/objective/hijack/hijack = new
		hijack.owner = user.mind
		user.mind.objectives += hijack

		var/obj_count = 1
		for(var/datum/objective/OBJ in user.mind.objectives)
			user.text2tab("<B>Objective #[obj_count]</B>: [OBJ.explanation_text]")
			obj_count++

		user.text2tab("You have a very bad feeling about this.")

	return