require 'pry'
module Theater
    module Entities
        class Shows
            NUMBER_OF_SHOWS = [1,2,3]
            class << self
                def all
                    NUMBER_OF_SHOWS
                end
            end
            
        end
    end
end
