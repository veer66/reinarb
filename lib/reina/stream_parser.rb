# Copyright (C) 2014 Vee Satayamas
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE X CONSORTIUM BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require "whittle"

module Reina
  class Lu
    attr_reader :surface, :analyses
    
    def initialize
      @analyses = []
    end
  end
  
  class AmbiLu < Lu
    def initialize(surface, analyses)
      super()
      @surface = surface
      @analyses = analyses
    end
  end
  
  class UnkLu < Lu
    def initialize(surface)
      super()
      @surface = surface
    end
  end

  class NonLu < Lu
    def initialize(surface)
      super()
      @surface = surface
    end
  end
  
  class StreamParser < Whittle::Parser
    rule(:wsp => /\s+/).skip!
    rule(:surface => /\^[^\^^\$^\<][^\$^<^\/]*/)
    rule(:text => /[^\/^\^^\$^\<][^\^]*/)
    rule(:elu => /\$/)
    rule(:tag => /<\w+>/)
    rule(:lemma => /\/[^\*^\$^<]+/)
    rule(:unk => /\/\*[^\$]+/)

    rule(:tags) do |r|
      r[:tags, :tag].as { |tags, tag| 
        tags + [tag]
      }
      r[:tag].as { |t| [t[1..-2]] }
    end
    
    rule(:analysis) do |r|
      r[:lemma, :tags].as { |lemma, tags| { tags: tags, lemma: lemma[1..-1] }}
    end
    
    rule(:analyses) do |r|
      r[:analyses, :analysis].as { |analyses, analysis| analyses + [analysis] }
      r[:analysis].as { |analysis| [analysis] }
    end

    rule(:lu) do |r|
      r[:surface, :analyses, :elu].as { |surface, analyses, _| 
        AmbiLu.new(surface[1..-1], analyses)
      }
      r[:surface, :unk, :elu].as { |surface, _, _| UnkLu.new(surface[1..-1]) }
      r[:text].as { |txt| NonLu.new(txt) }
    end
    
    rule(:stream) do |r|
      r[:stream, :lu].as { |lu_lst, lu| lu_lst + [lu] }
      r[:lu].as { |lu| [lu] }
    end 
    start(:stream)
  end  
end
