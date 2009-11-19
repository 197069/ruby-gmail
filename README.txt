= ruby-gmail

* http://github.com/dcparker/ruby-gmail

== DESCRIPTION:

A Rubyesque interface to Gmail. Connect to Gmail via IMAP and manipulate emails and labels. Send email with your Gmail account via SMTP. Includes full support for parsing and generating MIME messages.

== FEATURES/PROBLEMS:

* Read emails via IMAP
* Full MIME parsing ability, with understanding of attachments
* Create, rename, and delete labels
* Label, archive, delete, mark as read/unread/spam
* Send emails via SMTP
* Full ability to generate MIME messages including inline images and attachments

== SYNOPSIS:

  gmail = Gmail.new(username, password)
  gmail.inbox.count # => {:read => 41, :unread => 2}
  unread = gmail.inbox.emails(:unread)
  unread[0].archive!
  unread[1].delete!
  unread[2].move_to('FunStuff') # => Labels 'FunStuff' and removes from inbox
  unread[3].message # => a MIME::Message, parsed from the email body
  unread[3].mark(:read)
  unread[3].message.attachments.length
  unread[4].label('FunStuff') # => Just adds the label 'FunStuff'
  unread[4].message.save_attachments_to('path/to/save/into')
  unread[5].message.attachments[0].save_to_file('path/to/save/into')
  unread[6].mark(:spam)
  
  new_email = MIME::Message.generate
  new_email.to "email@example.com"
  new_email.subject "Having fun in Puerto Rico!"
  plain, html = new_email.generate_multipart('text/plain', 'text/html')
  plain.content = "Text of plain message."
  html.content = "<p>Text of <em>html</em> message.</p>"
  new_email.attach_file('some_image.dmg')
  gmail.send_email(new_email)

== REQUIREMENTS:

* ruby
* net/smtp
* net/imap
* gem shared-mime-info

== INSTALL:

* [sudo] gem install ruby-gmail -s http://gemcutter.org

== LICENSE:

(The MIT License)

Copyright (c) 2009 BehindLogic.com

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
