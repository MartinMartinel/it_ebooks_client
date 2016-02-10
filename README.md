## A Ruby client for the it-ebooks API

This is a very simple ruby client that can interact with the it-ebooks API.

## Usage
---
#### Search the API
```ruby
#Returns a collection of Book objects
books = Itebooks::Book.search('ruby')
```

#### Retrieve a single book by ID

```ruby
book = Itebooks::Book.find(2973000696)

p book.title # "Metaprogramming Ruby"
p book.sub_title # "Program Like the Ruby Pros"
p book.download # "http://filepi.com/i/a16hVNr" Download link (requires captcha completion)

p book.inspect # displays all attributes for a book
```

### Version
0.0.1

License
----

MIT


**Free Software, Hell Yeah!**