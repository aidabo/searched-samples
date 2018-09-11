
A solution with support for comments (# style). See comments in code for explanation.

test.properties:

# some comment with = char, empty line below

#invalid.property=1
some.property=2
some.property=3
# not sure if this is supported by .properties syntax
text=asd=f
properties-read.bat:

@echo off

rem eol stops comments from being parsed
rem otherwise split lines at the = char into two tokens
for /F "eol=# delims== tokens=1,*" %%a in (test.properties) do (

    rem proper lines have both a and b set
    rem if okay, assign property to some kind of namespace
    rem so some.property becomes test.some.property in batch-land
    if NOT "%%a"=="" if NOT "%%b"=="" set test.%%a=%%b
)

rem debug namespace test.
set test.

rem do something useful with your vars

rem cleanup namespace test.
rem nul redirection stops error output if no test. var is set
for /F "tokens=1 delims==" %%v in ('set test. 2^>nul') do (
    set %%v=
)