IRBy
======

The IRBy defines Object#irb.
It allows you to start irb super quickly.

Installation
------------

    gem install irby

Usage
------------

Call irb on current context.

    require 'irby'

    irb # start irb session

Call irb of an object.

    require 'irby'

    "test".irb #=> start irb session

Note
------------
 
Inspired by [http://d.hatena.ne.jp/ursm/20090625/1245951503](http://d.hatena.ne.jp/ursm/20090625/1245951503)


Copyright
------------

Copyright (c) 2010 jugyo. See LICENSE for details.
