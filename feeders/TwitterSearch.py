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
import ConfigParser
from ConfigParser import SafeConfigParser
from twython import Twython

config = SafeConfigParser()
config.read('../config/config.ini')

search_terms = config.get('twitter','keywords')
search_terms_list = search_terms.split(',')

twitter = Twython(config.get('twitter','consumer_key'), config.get('twitter','consumer_secret'), config.get('twitter','access_token_key'), config.get('twitter','access_token_secret'))

tweet_history = open("newest-tweet.lock","r")
newest_tweet = tweet_history.readline()
tweet_history.close()
newest_tweet = int(newest_tweet)

lookup_user = ''

for term in search_terms_list:
	search = twitter.search(q=term,since_id=newest_tweet,count=100)

	for message in search['statuses']:
		keywords = config.get('twitter','keywords')
                r_keywords = keywords.split(",")
                r_pattern = '(^|)'
                for word in r_keywords:
                        r_pattern += '(' + word + ')|'
                r_pattern += ' ( |$)'
                matches = re.search(r_pattern,message.get('text'), re.I|re.M)
                if matches:
                        print 'Matched: %s' % matches.group()
                        print 'User: %s' % message['user'].get('screen_name')
                        print 'User ID: %s' % message['user'].get('id_str')
                        print 'Got tweet with text: %s' % message.get('text')
                        print 'Tweet ID: %s' % message.get('id')
                        for mention in message['entities']['user_mentions']:
                                print 'Mentioned: %s' %mention.get('screen_name')
                                print 'Mentioned ID: %s' % mention.get('id_str')
                        for hashtag in message['entities']['hashtags']:
                                print 'Hashtag: %s' % hashtag.get('text')
                        for url in message['entities']['urls']:
                                print 'URL: %s' % url.get('expanded_url')
                        print 'Timestamp: %s' % message.get('created_at')
			print 'Coordinates: %s' % message.get('coordinates')
			print 'Retweeted: %s' % message.get('retweeted')
			print 'Retweet Count: %s' % message.get('retweet_count')

			lookup_user += message['user'].get('id_str') + ","

		if int(message.get('id')) > newest_tweet:
			newest_tweet = message.get('id')

	print twitter.get_lastfunction_header('x-rate-limit-remaining')

if lookup_user:
	lookup_user = twitter.lookup_user(user_id=lookup_user)
	for user in lookup_user:
		print 'User: %s' % user.get('id_str')
		print 'Name: %s' % user.get('name')
		print 'Screen Name: %s' % user.get('screen_name')
		print 'Profile Image: %s' % user.get('profile_image_url')
		print 'User Location: %s' % user.get('location')
		print 'Created: %s' % user.get('created_at')
		print 'URL: %s' % user.get('url')
		print 'Follower Count: %s' % user.get('followers_count')
		print 'Description: %s' % user.get('description')
		print 'Verified: %s' % user.get('verified')

tweet_history = open("newest-tweet.lock","w")
tweet_history.write(str(newest_tweet))
tweet_history.close()

