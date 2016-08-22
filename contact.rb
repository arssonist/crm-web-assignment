require 'active_record'
require 'mini_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3',database: 'crm-web.sqlite3')

class Contact < ActiveRecord::Base
#class inherits from active record which includes all setters and getters for the strings below, and also tracks new contacts by ID

field :first_name, as: :string
field :last_name,  as: :string
field :email,      as: :string
field :note,       as: :text

  def full_name
      @first_name + " " + @last_name

  end
end

Contact.auto_upgrade!
# takes care of chages to underlying structure to tables or columns
