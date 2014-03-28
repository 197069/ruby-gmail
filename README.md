# Ruby::Gmail

A rubyesque interface to Gmail, with all the tools you'll need. Search, read and send multipart emails. Archive, mark as read/unread, and delete emails. Manage labels!

## Installation

Add this line to your application's Gemfile:

    gem 'ruby-gmail'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-gmail

## Usage

### Some quick notes

* It's entirely possible this will only support ruby 2.1 and above
* One goal is to clean up the rough edges of the dsl. The original is
  really good, but it needs to be super consistent.
* Another goal is to have really really good tests
* And the most important goal is to do as little as possible to
  accomplish the other goals. That means using the mail gem for almost
  everything, not trying to be too clever, probably other things I
  haven't thought of.

### Basics

```ruby
require 'gmail'

gmail = Gmail.new(user, pass)

# ... do things

gmail.logout


Gmail.new(user, pass) do |gmail|
  # ... do things
end
```

# Search your messages

```ruby
# Get counts for messages in the inbox
gmail.inbox.count
gmail.inbox.where(read: false).count
gmail.inbox.where(read: true).count

# Count with some criteria
gmail.inbox.where(after: "2010-02-20", before: "2010-03-20").count
gmail.inbox.where(on: "2010-04-15").count
gmail.inbox.where(from: "myfriend@gmail.com").count
gmail.inbox.where(to: "directlytome@gmail.com").count

# Combine flags and options
gmail.inbox.where(read: false, from: "myboss@gmail.com").count

# Labels work the same way as inbox
gmail.labels[:Urgent].count

# Getting messages
gmail.inbox.where(read: false, before: "2010-04-20", from: "myboss@gmail.com").to_a
# or
gmail.inbox.where(read: false, before: "2010-04-20", from: "myboss@gmail.com").messages

# Get messages without marking them as read on the server
gmail.peek = true
gmail.inbox.where(read: false, before: "2010-04-20", from: "myboss@gmail.com").to_a
# or
gmail.peek do
  gmail.inbox.where(read: false, before: "2010-04-20", from: "myboss@gmail.com").first
end
```

# Work with messages

```ruby
# any news older than 4-20, mark as read and archive it...
gmail.inbox.where(before: Date.parse("2010-04-20"), from: "news@nbcnews.com").each do |message|
  message.mark(:read) # can also mark :unread or :spam
  message.archive!
end

# delete emails from X...
gmail.inbox.emails(from: "x-fiancé@gmail.com").each do |message|
  message.delete!
end

# Save all attachments in the "Faxes" label to a folder
folder = "/where/ever"
gmail.labels[:Faxes].each do |message|
  message.attachments.each do |attachment|
    filename = File.join(folder, attachment.filename)
    begin
      File.open(filename, "w+b", 0644) do |f|
        f.write attachment.body.decoded
      end
    rescue => e
      puts "Unable to save data for #{filename} because #{e.message}"
    end
  end
end

# Add a label to a message
email.labels << "Faxes"
```

### Create new emails

```ruby
gmail.deliver do
  to "email@example.com"
  subject "Having fun in Puerto Rico!"
  text_part do
    body "Text of plaintext message."
  end
  html_part do
    body "<p>Text of <em>html</em> message.</p>"
  end
  add_file "/path/to/some_image.jpg"
end

# Or, generate the message first and send it later

message = gmail.new do
  to "email@example.com"
  subject "Having fun in Puerto Rico!"
  body "Spent the day on the road..."
end

# ... add some parts

message.deliver!
# Or...
gmail.deliver(message)
```

## Contributing

1. Fork it ( http://github.com/myobie/ruby-gmail/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
