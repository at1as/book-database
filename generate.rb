require 'liquid'

# Acquire list of books in directory
saved_books_dir = "/Volumes/5TB-MEDIA/Books/"
Dir.chdir(saved_books_dir)
book_list = Dir.glob('*').reject {|f| File.directory? f }


def strip_trailing_year(str)
  # "Author – Title (YYYY)" => "Author - Title""
  (title = /(.*)(\([0-9]{4}\)\Z)/.match(str)) ? title[1].strip : str.strip
end

all_formats = book_list.map{ |book| book.split('.').last }.uniq.sort!


detailed_book_list = book_list.group_by { |filename| 
  filename.rpartition('.').first
}.map do |k, v| 
  [
    k, 
    {
      "title"   => strip_trailing_year(k.partition(' - ').last),
      "formats" => v.map { |j| j.split('.').last },
      "authors" => k.split(' - ').first.strip,
      "year"    => (k.rpartition('(').last.chomp(')') if k[-6..-1] =~ /([0-9]{4})/)
    }
  ] 
end.to_h 


# Generate HTML page

Dir.chdir(__dir__)
text = File.read('_templates/books.liquid')
@template = Liquid::Template.parse(text)
output = @template.render('books' => detailed_book_list,
                          'books_dir' => saved_books_dir,
                          'num_books' => detailed_book_list.length,
                          'formats' => all_formats)

File.open('_output/book-list.html', 'w') { |file| file.write(output) }

