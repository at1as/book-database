# Book-Database

Interface to search through and filter your book list. 


## Screenshots
<img src="http://at1as.github.io/github_repo_assets/book-database.png" width="700px">


## Usage

Download the repository here, set the appropriate permissions and launch IMDB-Scrape via:
```bash
$ git clone https://github.com/at1as/book-database.git

# Replace "<YOUR-DESIRED-PATH>" with the path to your book directory
$ gsed -i 's/saved_books_dir = "\/Volumes\/5TB-MEDIA\/Books\/"/saved_books_dir = "<YOUR-DESIRED-PATH>"/g' generate.rb  
$ ruby generate.py
```


## Requirements

* Requires `Ruby` with the `liquid` gem (written and tested on jRuby, but should not have a specific version dependency)


## Notes



* All files should be in the format `<Author> - <Title> (YYYY).<Extension>` (Example `Niccolo Machiavelli - The Prince (1550).pdf`)
* Files with multiple extensions should have the exact same name or they will be listed twice
* Field separators cannot be an m-dash or n-dash, a standard hyphen ("-") is expected
* Does not gather external information such as genre, etc.
* Does not yet read file metadata
* Does not descend directories (skips subdirectories)


