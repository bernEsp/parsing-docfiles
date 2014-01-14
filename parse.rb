require 'rubygems'
require 'nokogiri'
require 'zip'
class Parse
  def initialize
    @file = 'test-parser.docx'
    to_xml @file
  end
  private
    def to_xml file
      puts "loading ..."
      @file = Zip::File.new(file) 
      document_xml = unzip_read('word/document.xml')
      xml = Nokogiri::XML(document_xml)
      puts xml
    end

    def unzip_read zip_path
      file = @file.find_entry(zip_path)  
      contents = ""
      file.get_input_stream do |f|
        contents = f.read
      end
      contents
    end
end
if __FILE__ == $0
  Parse.new
end
