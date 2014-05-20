reinarb
=======

A toolset for Apertium written in Ruby

# Usage

## Example

### Stream parser

```ruby
require "reina/stream_parser.rb"
require "pp"

txt = <<TXT
^ให้การ/ให้การ<vblex><x><y>$ ^ฝึกฝน/ฝึกฝน<vblex>$
TXT

parser = Reina::StreamParser.new
PP.pp parser.parse(txt)
```

### Expanded dix loader

```ruby
# -*- coding: utf-8 -*-
require "./lib/reina/ldix_loader.rb"
require "pp"
require "stringio"

ldix = <<DIXEOF
กำลัง:กำลัง<vblex>
สนิท:สนิท<adj>
DIXEOF

file = StringIO.new(ldix)

PP.pp Reina::LdixLoader.load(file)
```
