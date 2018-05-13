package.cpath = "./?.so"
hello = require "hello"

print("Testing say_hello()")
assert("hello world!" == hello.say_hello())

test = require "hello_struct"
print(test)
print(type(test))
print(MyType)
print(type(MyType))

local value = MyType.new()
print(value)
print(type(value))