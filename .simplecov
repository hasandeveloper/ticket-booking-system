require 'simplecov'

class FileNameFilter < SimpleCov::Filter
    def matches?(source_file)
        source_file.filename =~ /.*test.*/
    end
end
SimpleCov.start { add_filter(FileNameFilter.new(5)) }
Dir.glob("./**/*test*.rb").each {|file| require file }
