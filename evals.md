Object#instance_eval
====================

Evaluates a block of code with self set to the receiving object.

In this example, instance eval is being called within a instance method, so at the time of evaluation, self will be set to the instance of Person.

    class Person
      def name
        instance_eval { puts 'hi' }
      end
    end

In this example, instance_eval is being called within the class definition, so at the time of evaluation, self is the class Person.

    class Person
      instance_eval { puts 'hi' }
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
    
Because instance_eval is capable of taking a block, it also has access to it's enclosing variable scope!

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
    
Module#class_eval
=================

Evaluates a block of code in the context of an existing class.

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