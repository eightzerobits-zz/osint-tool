#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright (C) 2013 Bryan Brannigan

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
import json, re
from ConfigParser import SafeConfigParser
from twython import Twython

config = SafeConfigParser()
config.read('../config/config.ini')

twitter = Twython(config.get('twitter','consumer_key'), config.get('twitter','consumer_secret'), config.get('twitter','access_token_key'), config.get('twitter','access_token_secret'))

search = twitter.search(q='bryanbrannigan',until='2013-11-30')

for message in search['statuses']:
	print message.get('text')

print twitter.get_lastfunction_header('x-rate-limit-remaining')
