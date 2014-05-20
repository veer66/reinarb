reinarb
=======

A toolset for Apertium written in Ruby

# Usage

## Example

	```ruby
	require "reina/stream_parser.rb"
	require "pp"

	txt = <<TXT
	^ให้การ/ให้การ<vblex><x><y>$ ^ฝึกฝน/ฝึกฝน<vblex>$
	TXT

	parser = Reina::StreamParser.new
	PP.pp parser.parse(txt)
	'''
