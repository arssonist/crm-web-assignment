require_relative 'contact'

class CRM



  def main_menu
    while true
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts "[1] Add a new conact"
    puts "[2] Modify an existing account"
    puts "[3] Delete a contact"
    puts "[4] Display all the contacts"
    puts "[5] Search by attribute"
    puts "[6] Exit"
    puts "Enter a selection"
    # puts "\e[H\e[2J"
  end

  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5 then search_by_attribute
    when 6 then exit
    end
  end


  def add_new_contact
    print 'Enter First Name: '
    first_name = gets.chomp

    print 'Enter Last Name: '
    last_name = gets.chomp

    print 'Enter Email Address: '
    email = gets.chomp

    print 'Enter a Note: '
    note = gets.chomp

    Contact.create(first_name, last_name, email, note)
  end


  def modify_existing_contact
    puts "What is last name of contact?"
    modified_contact = gets.chomp
    modified_conact = Contact.find_by("last_name", modified_conact)

#Create confirmation for modification
    # puts "Is this the correct contact name?"
    # puts modified_conact

  end

  def delete_contact
      puts "What is the last name of the user you want to delete?"
      deleted_user = gets.chomp
      deleted_user = Contact.find_by("last_name", deleted_user)
      deleted_user.delete


  end

  # This method should accept as an argument an array of contacts
  # and display each contact in that array
  def display_contacts

    # HINT: Make use of this method in the display_all_contacts and search_by_attribute methods to keep your code DRY
  end

  def display_all_contacts
    all_contacts = Contact.all
    all_contacts.each do |i|
      puts i.inspect
    end
  end
  #if empty print :no contacts
    # HINT: Make use of the display_contacts method to keep your code DRY


  def search_by_attribute
    puts "Do you want to use to search by first_name,last_name, email or ID?"
    found_attr1 = gets.chomp
    puts "What #{found_attr1} do you want to search for?"
    found_attr2 = gets.chomp
    new_found_attribute =  Contact.find_by(found_attr1, found_attr2)
    puts new_found_attribute.inspect
    # HINT: Make use of the display_contacts method to keep your code DRY
  end

  # Add other methods here, if you need them.

end

c = CRM.new
c.main_menu
