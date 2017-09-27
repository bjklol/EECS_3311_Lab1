note
	description: "Summary description for {TEST_ARRAYED_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_ARRAYED_CONTAINER
inherit
	ES_TEST
create
	make
feature
	make
		do
			add_boolean_case(agent test_assign_at_insert_last_get_at)
			add_boolean_case(agent insert_at_delete_at)
			add_boolean_case(agent delete_at_only)
			add_boolean_case(agent test_remove_first)
			add_boolean_case(agent test_count)
			add_boolean_case(agent test_all_methods)
			add_violation_case_with_tag("others_unchanged", agent test_bad_assign_at)
			add_violation_case_with_tag("right_half_the_same", agent test_bad_insert_at)
			add_violation_case_with_tag("last_inserted", agent test_bad_insert_last)
			add_violation_case_with_tag("size_changed", agent test_bad_delete_at)
			add_violation_case_with_tag("others_unchanged", agent test_bad_remove_first)
		end
feature

	test_assign_at_insert_last_get_at: BOOLEAN
		local
			ac: ARRAYED_CONTAINER
		do
			comment("test: assign_at and insert_last and get_at")
			create ac.make
			ac.insert_last ("alan")
			ac.insert_last ("mark")
			ac.insert_last ("tom")
			Result :=
				ac.get_at (1) ~ "alan"
			and ac.get_at (2) ~ "mark"
			and ac.get_at (3) ~ "tom"
			check Result end

			ac.assign_at (2, "jim")
			Result :=
				ac.get_at (1) ~ "alan"
			and ac.get_at (2) ~ "jim"
			and ac.get_at (3) ~ "tom"
			check Result end
		end

	insert_at_delete_at:BOOLEAN
		local
			ac:ARRAYED_CONTAINER
		do
			comment("test: insert_at and delete_at")
			create {ARRAYED_CONTAINER} ac.make
			ac.insert_last ("Alice")
			ac.insert_last ("Bob")
			ac.insert_at (1, "Eve")
			Result :=
				ac.get_at (1) ~ "Eve"
			and	ac.get_at (2) ~ "Alice"
			and	ac.get_at (3) ~ "Bob"
			check Result end

			ac.delete_at (2)
			Result :=
				ac.count = 2
			and	ac.get_at (1) ~ "Eve"
			and	ac.get_at (2) ~ "Bob"
			check Result end
		end

	delete_at_only:BOOLEAN
		local
				ac:ARRAYED_CONTAINER
			do
				comment("test delete_at only")
				create {ARRAYED_CONTAINER} ac.make
				ac.insert_last ("Alice")
				ac.insert_last ("Bob")
				ac.insert_last ("Eve")
				ac.delete_at (2)
				Result :=
					ac.get_at (1) ~ "Alice"
				and	ac.get_at (2) ~ "Eve"
				check Result end

				ac.delete_at (2)
				Result :=
					ac.count = 1
				and	ac.get_at (1) ~ "Alice"
				check Result end
			end

	test_remove_first:BOOLEAN
		local
			ac:ARRAYED_CONTAINER
		do
			comment("test: remove_first")
			create {ARRAYED_CONTAINER} ac.make
			ac.insert_last ("Adam")
			ac.insert_last ("Ben")
			Result :=
				ac.get_at (1) ~ "Adam"
			and	ac.get_at (2) ~ "Ben"
			check Result end

			ac.remove_first
			Result :=
				ac.get_at (1) ~ "Ben"
			check Result end
		end

	test_count:BOOLEAN
		local
			ac:ARRAYED_CONTAINER
		do
			comment("test: count")
			create {ARRAYED_CONTAINER} ac.make
			ac.insert_last ("Etan")
			ac.insert_at (1, "FRO BROTHA")
			ac.assign_at (1, "Sid")
			Result :=
				ac.count = 2
			and	ac.get_at (1) ~ "Sid"
			and	ac.get_at (2) ~ "Etan"
			check Result end
		end

	test_all_methods:BOOLEAN
		local
			ac:ARRAYED_CONTAINER
		do
			comment("test: all methods")
			create {ARRAYED_CONTAINER} ac.make
			ac.insert_last ("Aaron")
			Result :=
				ac.get_at (1) ~ "Aaron"
			check Result end
			ac.insert_last ("BJ")
			ac.insert_at (2, "Chava")
			ac.assign_at (3, "D'asra")
			Result :=
				ac.get_at (1) ~ "Aaron"
			and	ac.get_at (2) ~ "Chava"
			and	ac.get_at (3) ~ "D'asra"
			and	ac.count = 3
			check Result end
			ac.delete_at (2)
			ac.remove_first
			Result :=
				ac.count = 1
			and	ac.get_at (1) ~ "D'asra"
			check Result end

		end

	test_bad_assign_at
		local
			ac: BAD_AC_ASSIGN_AT
		do
			comment ("Test should violate others_unchanged postcondition")
			create {BAD_AC_ASSIGN_AT} ac.make
			ac.insert_last ("A")
			ac.insert_last ("B")
			ac.assign_at (2, "C")
		end


	test_bad_insert_at
		local
			ac: BAD_AC_INSERT_AT
		do
			comment("Test should violate right_half_the_same postcondition")
			create {BAD_AC_INSERT_AT} ac.make
			ac.insert_last ("Boy")
			ac.insert_last ("AYY")
			ac.insert_at (2, "CCC")
		end

	test_bad_insert_last
		local
			ac: BAD_INSERT_LAST
		do
			comment("Test should violate last_inserted postcondition")
			create {BAD_INSERT_LAST} ac.make
			ac.insert_last ("Bllosh")
		end

	test_bad_delete_at
		local
			ac: BAD_AC_DELETE_AT
		do
			comment("Test should violate size_changed postcondition")
			create {BAD_AC_DELETE_AT} ac.make
			ac.insert_last ("ARGH")
			ac.insert_last ("WHY!!!")
			ac.delete_at (2)

		end

	test_bad_remove_first
		local
			ac: BAD_AC_REMOVE_FIRST
		do
			comment("Test should test whatever and give a foo violation")
			create {BAD_AC_REMOVE_FIRST} ac.make
			ac.insert_last ("foo")
			ac.insert_at (1, "foo")
			ac.remove_first
		end
end
