package.cpath = "./?.so"
hello = require "hello"

print("Testing say_hello()")
assert("hello world!" == hello.say_hello())
