module Reina  
  class LdixLoader
    def self.load(file)
      file.map do |line|
        line.chomp.split(/:|:[<>]:/).map do |col|
          toks = col.split(/(<\w+>)/)
          {
            headword: toks[0],
            tags: toks[1..-1].map{ |t| t[1..-2] }
          }
        end
      end
    end
  end
end
