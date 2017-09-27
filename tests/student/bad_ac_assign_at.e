note
	description: "Summary description for {BAD_AC_ASSIGN_AT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BAD_AC_ASSIGN_AT
inherit
	ARRAYED_CONTAINER
		redefine
			assign_at
		end
create
	make
feature -- Create a bad version of assign_at
	assign_at (i: INTEGER; s: STRING)
		do
			-- First call the inherited version from
			-- AC
			Precursor (i, s)
			-- Here comes the wrong implementation
			-- which should trigger some postcondtion
			-- violation
			if i > 1 then
				imp [i - 1] := "BAD"
			end
		end
end
