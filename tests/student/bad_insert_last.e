note
	description: "Summary description for {BAD_INSERT_LAST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BAD_INSERT_LAST

inherit
	ARRAYED_CONTAINER
		redefine
			insert_last

		end
create
	make
feature -- Create a bad version of assign_at
	insert_last (s: STRING)
		do
			-- First call the inherited version from
			-- AC
			Precursor (s)
			imp[imp.count] := "foo^^"
		end
end
