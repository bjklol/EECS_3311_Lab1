note
	description: "container application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CONTAINERS

inherit
	ES_SUITE

create
	make

feature -- Adding test classes.

	make
			-- Run application.
		local
			ac: ARRAYED_CONTAINER
		do
		--	add_test (create {TEST_ARRAY_COPIES}.make)
			add_test (create {TEST_ARRAYED_CONTAINER}.make)
		--	add_test (create {}.make)
			show_browser
			run_espec
		end

end

-- old_imp := imp.twin --creates a shallow copy/creates its own, separate copy of the object/array
-- old_imp := imp --creates an alias. So they BOTH point to the SAME object (as opposed to just the value)
-- others_unchanged:
--	across
--		1 |..| imp.count as j
--	all
--		j.item /= i implies imp [j.item] ~ (old imp.twin) [j.item]
--	end
