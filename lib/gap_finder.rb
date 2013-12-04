#
# This is used for finding the gaps between a subset of elements in an array
# and the original layout. We use this is Discourse to find gaps between posts.
#
module GapFinder

  def self.find(subset, original)
    return if subset.nil? or original.nil?

    i = j = 0
    gaps = {}
    current_gap = []

    while
      e1 = subset[i]
      e2 = original[j]

      if (e1 == e2)
        if current_gap.size > 0
          gaps[e1] = current_gap.dup
          current_gap = []
        end

        i = i + 1
      else
        current_gap << e2
      end
      j = j + 1

      break if (i >= subset.size) || (j >= original.size)
    end
    # if current_gap.size > 0
    #   gaps[e1] = current_gap.dup
    # end

    if j < original.size
      current_gap = gaps[original.last] = gaps[original.last] || []
      while j < original.size
        current_gap << original[j]
        j = j + 1
      end
    end

    # If we have no gaps, return nil
    gaps.keys.size > 0 ? gaps : nil
  end

end
