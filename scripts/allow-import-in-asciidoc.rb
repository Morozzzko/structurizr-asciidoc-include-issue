is_asciidoc = -> (filename) { filename.end_with?('.adoc') }

root_path = File.expand_path( __dir__, '/..')

best_guess_for_path = -> (filename) do
  Dir.glob(File.join(root_path, '**', filename)).first
end

workspace.documentation.sections.to_a.select do |section| 
  is_asciidoc.(section.filename)
end.each do |section|
  section_path = best_guess_for_path.(section.filename)

  new_content = section.content.gsub(/include::(?<filename>[\/\w\d\.]+)\[\]/) do      
    filename = Regexp.last_match['filename']
    File.read(File.join(File.dirname(section_path), filename))
  end

  section.set_content(new_content)
end

