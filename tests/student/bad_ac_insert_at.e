note
	description: "Summary description for {BAD_AC_INSERT_AT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BAD_AC_INSERT_AT

inherit
	ARRAYED_CONTAINER
		redefine
			insert_at

		end
create
	make
feature -- Create a bad version of assign_at
	insert_at (i: INTEGER; s: STRING)
		do
			Precursor (i, s)
			if i > 1 then
				imp[i + 1] := s + "a"
			end
		end
end
