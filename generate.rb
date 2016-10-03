require 'liquid'

# Acquire list of books in directory
saved_books_dir = "./Books/"
Dir.chdir(saved_books_dir)
book_list = Dir.glob('*').reject {|f| File.directory? f }


# Map book title to list of formats
books_and_formats = book_list.group_by { |x| x.rpartition('.')[0] }.map{ |k, v| [k, v.map{ |j| j.split('.').last }] }.to_h


# Generate HTML page
Dir.chdir(__dir__)
text = File.read('books.liquid')
@template = Liquid::Template.parse(text)
output = @template.render('books' => books_and_formats, 'books_dir' => saved_books_dir)

File.open('book-list.html', 'w') { |file| file.write(output) }

