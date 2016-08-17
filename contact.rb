class Contact

  attr_reader :id, :contacts
  attr_accessor :first_name, :last_name, :email, :note

  @@contacts = []
  @@id = 1

  # This method should initialize the contact's attributes
  def initialize(first_name, last_name, email, note)
      @first_name = first_name
      @last_name = last_name
      @email = email
      @note = note
      @id = @@id
      @@id += 1
  end

  # This method should call the initializer,
  # store the newly created contact, and then return it
  def self.create(first_name, last_name, email, note)
    new_contact = Contact.new(first_name, last_name, email, note)
    @@contacts << new_contact
    return new_contact
  end

  # This method should return all of the existing contact.
  def self.all
    @@contacts
  end

  # This method should accept an id as an argument
  # and return the contact who has that id
  def self.find(id)
    @@contacts.each do |object|
      if object.id == id
        return object
      else
        puts "That is not a valid ID."  
      end
    end
  end

  # This method should allow you to specify
  # 1. which of the contact's attributes you want to update
  # 2. the new value for that attribute
  # and then make the appropriate change to the contact
  ##attribute- which of four attributes being updated
  #value- actual name that it is being changed to.

  # def update(first_name, "d")
    #@first_name =
  def update(attribute_as_string, value)
    if attribute_as_string == "first_name"
      @first_name = value
    elsif attribute_as_string == "last_name"
      @last_name = value
    elsif attribute_as_string == "email"
      @email = value
    elsif attribute_as_string == "note"
      @note = value
    end
  end

  # This method should work similarly to the find method above
  # but it should allow you to search for a contact using attributes other than id
  # by specifying both the name of the attribute and the value
  # eg. searching for 'first_name', 'Betty' should return the first contact named Betty
  def self.find_by(attribute_as_string, value)
      @@contacts.each do |object|

        if object.first_name == value && attribute_as_string == "first_name"
          return object
        elsif object.last_name == value && attribute_as_string == "last_name"
          return object
        elsif object.email == value && attribute_as_string == "email"
          return object
        elsif object.note == value && attribute_as_string == value && attribute_as_string == "note"
          return object
        else
          return "Invalid input"
        # else
        #     return "Invalid entry"

        end
      end

  end

  # This method should delete all of the contacts
  #This must be called on an instance of the conact class to empty the class contents.
  def self.delete_all
      @@contacts = []
  end

  def full_name
      @first_name + " " + @last_name

  end

  # This method should delete the contact
  # HINT: Check the Array class docs for built-in methods that might be useful here
  def delete(contact)


  end

  # Feel free to add other methods here, if you need them.

end
