note
	description: "A linear container implemented via an array."
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAYED_CONTAINER

create
	make

feature {NONE} -- Implementation of container via an array

	imp : ARRAY[STRING]

feature -- Constructors

	make
			-- Initialize an empty container. (Done already by professor)
		do
			-- This implementation is correct, just given to you.
			create {ARRAY[STRING]} imp.make_empty
		ensure
			empty_container: imp.is_empty -- Your task (done?)
--			across
--				1 |..| imp.count as j
--			all
--				j.item = void
--			end
		end


feature -- Commands

	assign_at (i: INTEGER; s: STRING)
			-- Change the value at position 'i' to 's'.
		require
			 valid_index: valid_index(i)  --Your task (done)
		do
			imp [i] := s
			-- Uncomment this to produce a wrong implementation
--			if i > 1 then
--				imp [1] := s
--			end
		ensure
			size_unchanged: imp.count = old imp.twin.count
			item_assigned: imp [i] ~ s
			others_unchanged:
				across
					1 |..| imp.count as j
				all
					j.item /= i implies imp [j.item] ~ (old imp.twin) [j.item]
				end
		end

	insert_at (i: INTEGER; s: STRING)
			-- Insert value 's' into index 'i'.
		require
			valid_index: valid_index(i) -- Your task (done)
		local
			str: STRING
			x: INTEGER
		do
			if i > imp.count then
				imp.force (s, i)
			else
				imp.force ("foo", imp.count + 1)
				from
					x := imp.count
				until
					x = i
				loop
					str := imp[x]
					imp[x] := imp[x-1]
					x := x - 1
				end
			imp.put (s, i)

			end
			-- Your task(done?)
		ensure
			size_changed: imp.count = old imp.twin.count + 1 -- Your task(done)
			inserted_at_i: imp[i] ~ s -- Your task(done)
			left_half_the_same:
			across
				imp.lower |..| (i-1) as j
			all
				imp[j.item] ~ (old imp.twin)[j.item]
			end-- Your task(done)
			right_half_the_same:
			across
				(i+1) |..|  imp.upper as j
			all
				imp[j.item] ~ (old imp.twin)[j.item-1]
			end  -- Your task(done)
		end

	delete_at (i: INTEGER)
			-- Delete element stored at index 'i'.
		require
			valid_index: valid_index(i) -- Your task(done) 
		do
			-- Your task (done?)
			across
				(i) |..| (imp.upper - 1) as j
			loop
				imp[j.item] := imp[j.item + 1]
			end
			imp.remove_tail(1)
		ensure
			size_changed: imp.count = old imp.twin.count - 1 -- Your task(done)
			left_half_the_same:
			across 1 |..| (i-1)
				 as j
			all
				imp[j.item] ~ (old imp.twin)[j.item]
			end-- Your task(done)
			right_half_the_same:
			across i |..| imp.upper
				 as j
			all
				imp[j.item] ~ (old imp.twin)[j.item+1]
			end -- Your task(done)
		end

	insert_last (s: STRING)
			-- Insert 's' as the last element of the container.
		do
			-- Your task(done?)
		imp.force (s, imp.upper + 1) -- Is the +1 necessary?

		ensure
			size_changed: imp.count = old imp.twin.count + 1 -- Your task(done?)
			last_inserted: imp[imp.upper] ~ s -- Your task(done)
			others_unchanged:
			across 1 |..| (imp.count - 1)
				as j
			all
				imp[j.item] ~ (old imp.twin)[j.item]
			end -- Your task(done)
		end

	remove_first
			-- Remove first element from the container.
		require
			not_empty: count >= 1 -- Your task(done)
		do
		--	Your task
			across 1 |..| (imp.count-1) as j
			loop
				imp[j.item] := imp[j.item+1]
			end
			imp.remove_tail (1)

		ensure
			size_changed: imp.count = old imp.twin.count - 1 -- Your task(done)
			others_unchanged:
			across	1 |..| imp.upper as j
			all
				imp[j.item] ~ (old imp.twin)[j.item+1]
			end-- Your task(done?)
		end

feature -- Queries

	count: INTEGER -- Your task
	  -- Number of items currently stored in the container.
      -- It is up to you to either implement 'count' as an attribute,
      -- or to implement 'count' as a query (uniform access principle).
      do
      	Result := imp.count
      end

	valid_index (i: INTEGER): BOOLEAN
			-- Is 'i' a valid index of current container?
		do
			Result := (i >= imp.lower) and (i <= imp.upper)
			 -- Your task(done?)
		ensure
			size_unchanged: imp.count = old imp.twin.count -- Your task-(done)
			result_correct: Result = (i >= imp.lower and i <= imp.upper) -- Your task (done)
			no_elements_changed:
			across
				1 |..| imp.count as j
			all
				imp[j.item] ~ (old imp.twin)[j.item]
			end -- Your task (done)
		end

	get_at (i: INTEGER): STRING
			-- Return the element stored at index 'i'.
		require
			valid_index: valid_index(i) -- Your task(done)
		do
			-- Your task (done)
			Result := imp[i]
		ensure
			size_unchanged: imp.count = old imp.twin.count -- Your task-(done)
			result_correct: Result = imp[i] -- Your task (done)
			no_elements_changed:
			across
				1 |..| imp.count as j
			all
				imp[j.item] ~ (old imp.twin)[j.item]
			end-- Your task (done)
		end

invariant
	-- Size of container and size of implementation array always match.
	consistency: imp.count = count
end
