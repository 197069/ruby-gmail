class Gmail
  class Mailbox
    attr_reader :name

    def initialize(gmail, name)
      @gmail = gmail
      @name = name
    end

    def inspect
      "<#Mailbox name=#{@name}>"
    end

    def to_s
      name
    end

    # Method: emails
    # Args: [ :all | :unread | :read ]
    def emails(key = :all)
      aliases = {
        :all => ['ALL'],
        :unread => ['UNSEEN'],
        :read => ['SEEN']
      }
      # puts "Gathering #{(aliases[key] || key).inspect} messages for mailbox '#{name}'..."
      @gmail.in_mailbox(self) do
        @gmail.imap.uid_search(aliases[key] || key).collect { |uid| messages[uid] ||= Message.new(@gmail, self, uid) }
      end
    end

    def messages
      @messages ||= {}
    end
  end
end
