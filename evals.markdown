Object#instance_eval
====================

Evaluates a block of code with self set to the receiving object.

In this example, instance eval is being called within a instance method, so at the time of evaluation, self will be set to the instance of Person.

    class Person
      attr_accessor :first_name, :last_name

      def name
        instance_eval { puts "#{first_name} #{last_name}" }
      end
    end

    p = Person.new
    p.first_name = "Hoban"
    p.last_name = "Washburne"
    p.name


In this example, instance_eval is being called within the class definition, so at the time of evaluation, self is the class Person.

    class Person
      def self.population
        22
      end

      instance_eval { puts population }
    end

Since instance_eval is evaluated on the receivers self, it has access to all private methods and instance variables of the receiver.

    class Person
      private
      def destroy
        puts 'i want to live!'
      end
    end

    p = Person.new
    p.instance_eval { destroy }

and...

    class Person
      def initialize(name)
        @name = name
      end
    end
    
    p = Person.new('brutus')
    p.instance_eval { puts @name }
    
Because instance_eval is capable of taking a block, it also has access to it's enclosing variable scope.

    class Person
      def initialize(name)
        @name = name
      end
    end

    p = Person.new('brutus')
    p.instance_eval { puts @name }
    
    new_name = 'balzak'
    p.instance_eval { @name = new_name }
    p.instance_eval { puts @name }

Method definition is tricky.

  class Person
  end

  Person.instance_eval do
    def class_or_instance?
      puts self
    end
  end

  Person.class_or_instance?
  
It created a class method, otherwise known as a method on Person's metaclass. This is default behavior of def outside of a class context as created by the class keyword. You can see here that instance_eval creates a basic context with self set to the Person class instance.

Module#class_eval
=================

Evaluates a block of code in the context of an existing class aka a class context.

    class Person
    end

    Person.class_eval {
      def self.hi
        puts 'hi from Person'
      end

      def hi
        puts 'hi from instance of Person'
      end
    }

We are simply opening up the class, just like the Ruby keyword 'class' does, and sending code to it.  The big difference, is that the Ruby keyword defines a new scope, where as class_eval, taking a block, maintains the variable scope that it was called in.

Knowing what instance_eval and class_eval do in respect to the objects receiving them, we can now understand the following:

    class Person
    end

    Person.instance_eval { def hi;end }  # creates a class method
    Person.class_eval { def hi;end } # creates an instance method

From the previous discussion surrounding the behavior of def inside a class context we know that called def without a receiver will put the method into the classes lookup table. Since class_eval specifically creates a class context calling def does the same thing as calling def in a class definition. Note that this is different from calling instance_eval which creates a normal context.