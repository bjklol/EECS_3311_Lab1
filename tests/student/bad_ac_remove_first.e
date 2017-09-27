note
	description: "Summary description for {BAD_AC_REMOVE_FIRST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BAD_AC_REMOVE_FIRST
inherit
	ARRAYED_CONTAINER
		redefine
			remove_first
		end
create
	make
feature
	remove_first
		do
			Precursor
			imp[1] := "ffo"
		end
end
