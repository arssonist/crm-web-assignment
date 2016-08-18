<<<<<<< HEAD
# Customer Relationship Manager - Web (CRM-Web) Assignment

The assignment is to implement a web version of the CRM application which you already built.

Please use the below as a guide and not as an exact "how-to" to implement your solution. Use common sense and judgement where appropriate.

Be sure to read over the entire assignment first to get a general feeling and overview of what you have to do, before digging into each part.

## Introduction

We're working our way towards using Rails, which is a pretty hefty framework with lots of concepts to learn all at once. Our first simple project will allow us to explore all the different aspects of making web applications, but by working at a smaller scale, it allows us to hone in on specific concepts. Instead of using all of the framework at once, we will building our way towards it, piece by piece, using Sinatra.

Before we get started, there are a few concepts to introduce to you, and a few chores to do.

## 1. Requests and Responses

When clients make HTTP requests, they pass along a URL, a method (or verb), a series of headers and sometimes a body containing data. When servers return HTTP responses, they pass along a response code (status code), headers and the response body containing the requested data. We care especially about two properties in general: **request methods** and **response codes**: they are able to help describe the nature of a request or response.

![Image of Request & Response](https://github.com/Lundalogik/HTTP-explained/blob/master/presentation/img/http1-req-res-details.png)

### Request Methods

#### What is CRUD?

A request method is important because it tells us what we should be doing with the request data. A server can not only retrieve data, but is also in charge of managing any changes to it as well. A request method is always combined with a URL.

Here a the most common request methods, you should be comfortable with these:

**GET**: _fetch_ or _read_ a resource. The URL contains all the necessary information the server needs to locate and return the resource.

**POST**: _create_ a new resource. POST requests usually carry a request body that specifies the data for the new resource.

**PUT**: _change_ or _update_ a resource. PUTS request should also carry a request body with the updated data

**DELETE**: _delete_ a resource.

These also correspond to what we refer to as the **CRUD** actions. **C**reate, **R**ead, **U**pdate, and **D**elete.

#### Submitting Data over the Web

Making a **GET** request is pretty straightforward. Every time you enter a URL in your browser or click on a link, you're making a GET request. They don't require anything more than a URL.

In order to make other types of requests with a browser, you will need to provide an HTML form that your user can submit. Inside the form element, you can specify which "method" to use.

Here's an example using POST

```html
<form action="/" method="post">
    <input type="text" name="first_name">
    <input type="text" name= "last_name">
    <input type="submit" value="Submit">
</form>
```

### Response Codes

Response codes are important because they let the browser know exactly what happened with the request. Was it successful? Was the resource found? Did it move from where it used to be? Did the server crash? All of these events can be described to the browser with a response code.

Response codes are grouped by number, some of them you may have heard of before, like *200 OK* and *404 Not Found*.

**1xx: Informational**
These types of response codes aren't really used. They were added in HTTP 1.1

**2xx: Success**
This tells the client that the request was successfully processed. The most common code is *200 OK*. For a GET request, the server sends the resource in the message body.

**3xx: Redirection**
This requires the client to take additional action. The most common use-case is to jump to a different URL in order to fetch the resource.

**4xx: Client Error**
These codes are used when the server thinks that the client is at fault, either by requesting an invalid resource or making a bad request. The most popular code in this class is 404 Not Found, which I think every one of us has seen. 404 indicates that the resource is invalid and does not exist on the server.

**5xx: Server Error**
This class of codes are used to indicate a server failure while processing the request. The most commonly used error code is 500 Internal Server Error.

*A full list of all response codes is available inside the [HTTP official spec](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.1.1).*

## 2. Sinatra

Now that you're familiar with the nitty-gritty details of how a simple web server works, we're going to add a bit of complexity. Given the fact that every single web application requires running atop a web server, we programmers don't tend to "reinvent the wheel" each time, we use well-written, well-supported libraries that'll do this for us!

There also comes a time where it makes sense to start separating the application code with the server code. It makes things a lot easier to read if both concerns are well-separated. By using an existing library for your server, you don't really ever need to look at this code, you can focus on making things instead!

For this assignment, you'll be working with the Sinatra web framework. It's a pretty "lightweight" framework that doesn't offer too many bells and whistles, but it provides enough functionality to help you build great web applications.

### Install Sinatra

Unlike sockets, which we used in the 'Build Your Own Web Server' assignment, Sinatra isn't part of the the Ruby standard library. It's available as a *Ruby Gem* (a prepackaged piece of ) that you will need to download and install with the following command.

```bash
$ gem install sinatra
```
Once it's installed, you'll be able to `require` it inside your project, just like sockets.

A sample `hello_world.rb` using Sinatra:

```ruby
require 'sinatra'

get '/' do
  'Hello World'
end

```

As you can see, it really doesn't take much to get started with Sinatra! The blocks (aka routes) you provide in your application are what define the responses the corresponding request method and matching url.

## 3. Code Reuse

#### Re-use the `Contact` Class

We are now almost ready to start this assignment!

But first, please copy & paste the `Contact` class from your crm assignment into the provided `contact.rb` file that has been provided to you. We are going to reuse that class in this assignment.

After you've copied & pasted the `Contact` class into `contact.rb`, run the following at the command line:

```bash
ruby test/contact_test.rb
```

If your `Contact` class has been implemented "correctly", you should see something like the following:

```
$ ruby test/contact_test.rb
Run options: --seed 13446

# Running:

.......

Finished in 0.001099s, 6369.0612 runs/s, 6369.0612 assertions/s.

7 runs, 7 assertions, 0 failures, 0 errors, 0 skips
```

Isn't that awesome? This is part of the power of testing, in that you can be sure a certain piece of code still works even if you use it in another project. We'll be learning more about testing in the coming weeks.

If your `Contact` class didn't quite pass muster and some of the tests are failing, don't sweat it. We don't want you to get hung up here. Ask an Instructor nicely and they'll provide you with a `Contact` class that'll work for the purposes of this assignment.

Go ahead and commit your changes now that you've updated the `Contact` class.

#### What about the `CRM` Class?

What about the `CRM` class from the non-web CRM assignment? I'm glad you asked! The previous `CRM` class was built as a command-line interface. But now we are going to build a web interface, so the old `CRM` class is obsolete and we won't be using it here!

That's the great thing about classes in that you can build them in such a way that you can re-use them across projects! As we upgrade parts of the application, we can get rid of obsolete parts and keep the parts that don't have anything to do with what we're upgrading.

## 4. Assignment Parts

This is a fairly large assignment that is spread out over four days/parts. On each day, follow the instructions on the following pages:

* Part 1: [Requests & Responses](https://github.com/bitmakerlabs/crm-web-assignment/wiki/Part-1:-Requests-&-Responses)
* Part 2: [Layouts, HTML, & CSS](https://github.com/bitmakerlabs/crm-web-assignment/wiki/Part-2:-Layouts,-HTML,-&-CSS)
* Part 3: [Working with Forms](https://github.com/bitmakerlabs/crm-web-assignment/wiki/Part-3:-Working-with-Forms)
* Part 4: [Saving your Data](https://github.com/bitmakerlabs/crm-web-assignment/wiki/Part-4:-Saving-your-Data)

As you are working on this assignment, you should be getting in the habit of commit each significant piece of work throughout the day. At the end of each day don't forget to push your code to Github!

## Additional Resources

* [HTTP: The Protocol Every Web Developer Must Know - Part 1](http://code.tutsplus.com/tutorials/http-the-protocol-every-web-developer-must-know-part-1--net-31177)
* [The HTTP Spec](http://www.w3.org/Protocols/rfc2616/rfc2616.html)
* [The Sinatra Web Framework](http://www.sinatrarb.com/)
=======
# Customer Relationship Manager (CRM) Assignment

The assignment is to implement a customer relationship management (CRM) application.

Be sure to start by reading over the entire assignment to get a general overview of what you have to do.

## User Stories

Software developers use "user stories" as a guide to know what to implement. They serve as descriptions of the interactions that users should be able to have with the application. Below we have written out all of the user stories for the CRM. Use these as a to-do list or guide when making your app.

* As a user, upon starting the CRM, I am presented with a prompt to **add**, **modify**, **delete**, **display all**, **search by attribute**,  and **exit**.
* As a user, if I select **add** I am prompted to enter a 'first name', 'last name', 'email' and 'note'.
* As a user, if I select **modify** I am prompted to enter an id for the contact to be modified.
* As a user, when I enter the id of the user I want to modify I am then prompted to select which attribute I want to change from the list 'first name', 'last name', 'email', or 'note'.
* As a user, when I enter the attribute I want to change I am then prompted to enter a new value for the attribute.
* As a user, if I select **delete** I am then prompted to enter the id of the contact I want to delete.
* As a user, if I select **display all** I am then shown all of the contacts that exist.
* As a user, if **search by attribute** is selected, I am prompted to select which attribute I want to search by.
* As a user, when I choose which attribute I want to search by, I am then prompted to enter the search term.
* As a user, when I enter the search term I am then presented with the first contact who matches my search.
* As a user, if I select **exit** I am returned to the command line.

Below is a guide on how to get started, how to implement the first few user stories, and some examples of how to work with classes, objects, instance variables and other things you will need.  However, this guide is not meant to be enough to get you through this assignment from start to finish.  Writing your first multi-class program is challenging and we anticipate that you will get stuck more than once in the process.  Asking for help is encouraged and expected!

## Creating a Contact class

First, let's get to the crux of this app: How are we going to store all of the contacts' information?

We could store it into an array or hash. Something like this:

```ruby
contacts = [
  {
    first_name: 'Betty',
    last_name: 'Maker',
    email: 'bettymakes@gmail.com',
    note: 'Loves Pokemon.'
  },
  {
    first_name: 'Octo',
    last_name: 'Cat',
    email: 'octocat@github.com',
    note: 'Is it an octopus? Is it a cat?'
  }
]
```

We can do better though. We could make a class called `Contact`.

What are classes and why do we use them? It's similar to the reason why we use methods – they let us organize our code.

Imagine if we had dozens of methods floating around with no structure – classes let us organize these methods into categories.

Open up the provided `contact.rb` file. You'll see that it's got a bunch of empty methods waiting for you to implement them.

Go ahead and implement the `initialize` method in the `Contact` class:

*Note: Vertical dots indicate omitted code for brevity's sake.*

```ruby
class Contact
  .
  .
  .
  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end
  .
  .
  .
end
```

Now whenever we want to make a new contact, we could do something like this:

```ruby
contact = Contact.new('Betty', 'Maker', 'bettymakes@gmail.com', 'Loves Pokemon')
```

### Using Getters and Setters

What if after we want to find out what the contact's email is after we've created it?  Or change the notes?

```ruby
contact = Contact.new(
  'Betty',
  'Maker',
  'bettymakes@gmail.com',
  'Loves Pokemon'
)
# How can I get contact's email?
# Then how can I change contact's note to 'Loves HTML & CSS'?
```

We need some attribute 'getters' (or 'readers') and 'setters' (or 'writers') inside the `Contact` class. In this scenario we need to be able to 'get' the email and 'set' the note of a contact.

```ruby
class Contact
  .
  .
  .
  # a getter (*get* the value of an attribute)
  def email
    @email
  end

  # a setter (*set* the value of an attribute)
  def note=(note)
    @note = note
  end
  .
  .
  .
end

# now we can do this:
contact.email # => 'bettymakes@gmail.com'
contact.note = 'Loves HTML & CSS'
```

Instead of writing out these methods ourselves like we did in the above code snippet, we could just use `attr_accessor`, `attr_reader`, and `attr_writer`.

These are special Ruby methods that will automatically create getters and setters for you.

* `attr_accessor` will give you both getters and setters,
* `attr_reader` gives you just getters, and
* `attr_writer` gives you just setters.

```ruby
class Contact
  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :note
  .
  .
  .
end
```

After you add `attr_reader` and `attr_accessor`, be sure to remove the `email` and `note=` methods if you actually implemented them in your class. As mentioned before, the getters and setters will be automatically created for you.

If you don't add getters and setters to your class's attributes then you won't be able to access or update those attributes from the code outside of your class definition:

```ruby
class Contact
.
.
.
  #no getters or setters here!
.
.
.
end

contact.email # this is cause an error!
contact.note = "new note" # this will also cause an error!
```

### Storing all new Contacts in a list

We need to store our newly created `Contact` objects somewhere. Since it will be a list of contacts, the best object type to use would be an `Array`, since it represents an ordered list of objects. We want our `Contact` class to keep track of this list, so we'll store it in a **class variable**.

### Class variables

A class variable is a variable that's declared at the class level and shared across all objects of the same type. In our case, we'll setup a class variable to store the array of all the contacts we create. We'll also create a class variable called `@@id` to ensure that our contacts each have a unique identifier.

```ruby
class Contact
  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :note

  @@contacts = []
  @@id = 1
  .
  .
  .
end
```

These variables will be available to all `Contact` object instances.

### Add a method to create new Contacts

Adding a contact to our CRM has two steps: first we need to make ("instantiate") a new contact object and then we need to save it into the list of contacts. We want to keep our methods focused and simple so we'll separate the functionality of instantiating an object from the functionality of adding it to our list with a new **class method**.

### Class methods

So far, all of the methods we've created were **instance methods**. Instance methods can only be used by a specific instance of an object, not the class itself (hence the name!).  Put another way, and instance method is an action that an instance knows how to perform.

Class methods are performed by the class itself and are usually reserved for actions that operate on the whole set of objects of that type. Instantiating a new contact and storing it in the list of all contacts affects the collection of all contacts so it's a good use case for a class method. It wouldn't make senese to give that responsibility to any single contact object.  You can call a class method on the name of the class itself, eg. `Contact.super_fun_class_method`. 

You define a class method by prefixing the name of the method with `self`.

What purpose do class methods serve and why would we want to use them? This is a great example of where object oriented design comes into play. Instance methods should involve logic that only make sense being applied to *an instance* of something, such as updating the email of *a specific person*.  A class method involves logic that should be applied on the whole scale of the model, such as cleaning up the email addresses of all the contacts. So the first example would be `some_contact.update_email(email)` and the second `Contact.clean_email_addresses`.

Go ahead and implement the `create` method as follows:

```ruby
# remember, we preface the method name with 'self.' if it is a class method
def self.create(first_name, last_name, email, note)
  new_contact = Contact.new(first_name, last_name, email, note)
  @@contacts << new_contact
  return new_contact
end
```

Our initialize method should be responsible for setting the first name, last name, email, and note that get passed in from the `create` method.  Additionally, it should set the id of the contact and increment the class `@@id` variable so that the next contact will get a different id.

```ruby
def initialize(first_name, last_name, email, note)
  .
  .
  .
  @id = @@id
  @@id += 1 # this way the next contact will get a different id
end
```

### Other Methods

The implementation of the following methods are left up to you:

* `self.all`
* `self.find`
* `self.find_by`
* `self.delete_all`
* `full_name`
* `update`
* `delete`

## Creating a CRM Class

Open up the provided `crm.rb` file, and again you'll see that it has a bunch of empty methods waiting for you to implement them.

### Creating the Menu

If you look at our user stories, you'll see we need to be able to prompt the user to select from a main menu. The code for that might look something like this:

```ruby
def main_menu
  while true # repeat indefinitely
    print_main_menu
    user_selected = gets.to_i
    call_option(user_selected)
  end
end

def print_main_menu
  puts '[1] Add a new contact'
  puts '[2] Modify an existing contact'
  puts '[3] Delete a contact'
  puts '[4] Display all the contacts'
  puts '[5] Search by attribute'
  puts '[6] Exit'
  puts 'Enter a number: '
end
```

We have two methods: `print_main_menu` prints out the menu and `main_menu` calls `print_main_menu` and then stores the user input (a number) into a variable called `user_selected`. That variable then gets passed as an argument into a method we haven't defined yet called `call_option`.

What do you think `call_option` should do? Remember, `user_selected` is going to be a number. What we want to do in this method is call other methods based on the number. We've started off this method for you:

```ruby
def call_option(user_selected)
  case user_selected
  when 1 then add_new_contact
  when 2 then modify_existing_contact
  # Finish off the rest for 3 through 6
  # To be clear, the methods add_new_contact and modify_existing_contact
  # haven't been implemented yet
  end
end
```

*Question:* What should happen when option 6 is selected? Hint: Google 'How to exit a Ruby program'.

### Menu Actions

You will need to implement several methods for the menu to call.

  * `add_new_contact`
  * `modify_existing_contact`
  * `delete_contact`
  * `display_all_contacts`
  * `search_by_attribute`

The `add_new_contact` method might looks something like this:

```ruby
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
```

### Other Methods

Implementation of the following methods are you to you.

* `modify_existing_contact`
* `delete_contact`
* `display_contacts`
* `display_all_contacts`
* `search_by_attribute`

### Requiring Files

Note that the `CRM` class needs to makes use of the `Contact` class, for example in the `add_new_contact` method. Many of the other methods in the `CRM` class will also make use of the `Contact` class.

Classes work together to make the entire program functional. We let classes use other classes by *importing* a file. The way this is done is using a method called `require_relative`, and basically what it does is get that file and stick it right in that line where the `require_relative` method was called.

Open up **`crm.rb`** and insert the following `require_relative` statement:

```ruby
require_relative 'contact'

class CRM
  .
  .
  .
end
```

Now, the `CRM` class will be able to make use of the `Contact` class.

### Using the CRM class

Now how do we call methods that are inside of classes? Like this:

```ruby
a_crm_app = CRM.new
a_crm_app.main_menu
```

If we wanted to call `print_main_menu` instead, that would look like:

```ruby
a_crm_app.print_main_menu
```

When we do:

```ruby
a_crm_app = CRM.new
```

We're creating a *new instance* of the class CRM, and we're saving that new instance into a variable called `a_crm_app`. This is just like having a blueprint of a house, and every time you build a house off the blueprint you create a new instance of a house.

Then we can **call** the methods that we defined inside the class **on** the instance. `main_menu` and `print_main_menu` are methods inside of the class CRM, and we can call them on `a_crm_app`, which is an instance of the class. For example, `a_crm_app.main_menu` tells `a_crm_app` to perform the `main_menu` action.

### Passing in Arguments when Initializing

When we want to create a new instance of a class, we call a method named `new` (as in `CRM.new`). In some cases we want it so that arguments have to be passed in, for example the new instance you make has to be given a name. In other words, you want to see something like this: `CRM.new("My CRM App")`.

For this to be done we need to manipulate a method named `initialize` in the class.

```ruby
class CRM
  .
  .
  .
  def initialize(name)
    puts "Okay, this CRM has the name " + name
  end
  .
  .
  .
end
```

`initialize` and `new` are synonymous, so when you call `new`, you're calling `initialize`.

### Instance Variables versus Local Variables

This bridges us over into another great point for OOP: instance variables.

```ruby
class CRM
  .
  .
  .
  def initialize(name_being_passed_in)
    name = name_being_passed_in
  end

  # Can I access name here, outside of the method?
  # No, and this is because the variable only has a local scope.

  .
  .
  .
end
```

How could we make it so that the variable `name` would be available outside of the `initialize` method? We could make it an instance variable, and the way we do this is by prepending the symbol `@` in front of the name. Like this:

```ruby
class CRM
  .
  .
  .

  def initialize(name_being_passed_in)
    @name = name_being_passed_in
  end

  # Now I can access name here, outside of the method.
  # It's a Ruby thing, if a variable starts with the symbol @,
  # I can access it outside of the method it was defined in.

  .
  .
  .
end
```

And why would we want to do this?

Why of course, to do something like this, just like in the `Contact` class:

```ruby
class CRM

  def initialize(name)
    @name = name # this is how the variable naming is normally done BTW
  end

  def what_is_the_name_of_this_CRM_again
    "Oh master, how could you forget? It was " + @name
  end
  .
  .
  .
end
```

You don't have to implement the `what_is_the_name_of_this_CRM_again` method, it was just for fun to show you how the `@name` instance variable can be used.



## Running the Program

Run the CRM program at the command line:

```bash
ruby crm.rb
```

If all goes well, you will be presented with the main menu, from where you can then manually try out your program.  

If nothing happens, maybe you forgot to create an instance of the CRM outside of the class definition, or maybe you forgot to tell that instance to do anything.  Which method should you call in order to start the program?

## What We've Learned

* Writing classes and creating new instances of them
* Instance methods
* Manipulating the initialize method
* Instance variables (for example `@name`)
* Getters and setters
* Class variables
* Class methods
* How to "import" a file with `require_relative`

And that is our first practical look at OOP! Please feel free to take your application to the next level by adding your own functionality where you see fit.

## Tips & Tricks

To enhance the user experience of your program, you can use `puts "\e[H\e[2J"` to clear your terminal screen.

## Additional Resources

* [Stack Overflow: `attr_accessor`, `attr_reader`, `attr_writer`](http://stackoverflow.com/questions/5046831/why-use-rubys-attr-accessor-attr-reader-and-attr-writer)
* [Blog - User Stories](http://codesqueeze.com/the-easy-way-to-writing-good-user-stories/)
* [Instance Method versus Class Method – Stack Overflow](http://stackoverflow.com/questions/11655593/ruby-on-rails-should-i-use-class-method-or-instance-method-and-why)
>>>>>>> 16c57c824a8c2f440e1a2623bfbd54422784be47
