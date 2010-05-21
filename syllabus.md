# Metaprogramming II: This Time It's Meta

## Overview

* *what:* practical applications of metaprogramming
* *where:* Saturday, June 5th, 2010
* *when:* 9:00 AM to 12:00 PM at Viget Labs in Falls Church, VA
* *why:* improving your skill with and appreciation for metaprogramming, both as an advanced refactoring and for the insights it provides into how Ruby works under the covers
* *who:* any and all interested parties

## Getting Prepared

We encourage you to bring a laptop and follow along with us. Although most of the examples will be done in Ruby 1.9, everything is applicable to 1.8 as well, and we'll note the few exceptions that arise.

If you don't bring a laptop, you will certainly want to at least to bring something to write with, so that you can jot down questions you might have or areas you want to explore on your own later.

## Format

We will have three sessions of about forty-five to fifty minutes each.

* Session one: First, a review of the Ruby object model. It's important to have a solid understanding of this before you go onto the other parts, because without a working mental understanding of how the pieces fit together, it will be too difficult to mentally evaluate your programs. We'll also develop a unit-testing suite that we can use to verify and prove our understanding of how Ruby works under the covers.

* Session two: Next we'll explore the use cases of two of the most challenging tricks in your metaprogramming bag: `instance_eval` and `class_eval`, each of which offers the potential t

* Session three: Using the previous two sessions, we'll approach metaprogramming as simply a logical extension of refactoring. Finally, we'll wrap up with a from-scratch demo of a practical (but tiny) project that uses metaprogramming as its core rather than merely a refactoring. Revel in your newfound skills, but remember: with great power comes great responsibility.

Humans don't learn effectively without some breaks in between to absorb information, so there's some breathing room between each session, about ten minutes. All told, there should be about three hours of instruction.

Afterwards, the plan is to head out to lunch as a group somewhere locally.

## Syllabus

#### Part I: Yo dawg, I put some code in your code so you can code while you code

* What is metaprogramming?
* Finding your `self`
  - `self` as implicit receiver
  - when `self` changes

* Objects and modules
  - conventional creation (`(class|module) Foo ...`) vs. metaprogramming approach (`o = (Class|Object).new ...`, `const_set ...`, etc.)
  - instance variables
  - methods
  - inheritance and the ancestor chain
  - proxy classes
  - constants
  - load(..., true) vs. require()
  
* Methods, blocks
  - procs/blocks/lambdas
  - "right then up" MRO rule
  - how proxy classes work in MRO
  
* Scope rules

* [eigen/meta|super]classes and their relationship to each other

* Grand unified theory of the Ruby object model:
  - [objects] all objects (Employee, String, Class, etc.) are of a single kind (Object)
  - [modules] all modules (Class, metaclasses, proxy classes, etc.) are of a single kind (Module)
  - [methods] all methods are of a single kind (Method), and they live in a module (usually a Class)
  - [eigenclasses] all objects have exactly one eigenclass
  - [superclasses] all objects have exactly one superclass (which could be nil)
  - [MRO] method resolution order is always "right, then up": visit "right" to eigenclass, then "up" through ancestor chain
  - [relationship between eigenclasses and superclasses] obj.class.meta.super == obj.class.super.meta

#### Part II: `eval` and friends

* What `eval` means

* `instance_eval`, `module_eval`, `class_eval`
  - compare and contrast differences
  - when to use?
  - when not to use?
  - when it's overkill?

* Some simple examples

#### Part III: Metaprogramming as a refactoring

* Metaprogramming can (and should) be viewed as a potential refactoring for reducing repetitiveness in code
  - show simple examples and how the evolution is natural

* Tradeoffs of refactoring via metaprogramming
  - big one: reduced code duplication vs. potential for obscuring intent/decreasing readability

* Develop a simple soup-to-nuts metaprogramming project
  
#### What now?

[links to explore/further study]

## Hackday Organizers

* Matt Swasey (@therealmig)
* Justin Marney (@gotascii)
* John Feminella (@superninjarobot)
