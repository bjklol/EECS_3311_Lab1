note
	description: "Summary description for {BAD_AC_DELETE_AT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BAD_AC_DELETE_AT

inherit
	ARRAYED_CONTAINER
		redefine
			delete_at

		end
create
	make
feature -- Create a bad version of assign_at
	delete_at (i: INTEGER)
		do
			Precursor (i)
			imp.force ("bleh", i)
		end
end
