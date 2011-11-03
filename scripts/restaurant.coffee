# Manage the list of restaurants in Lunchbot
#
# add <restaurant name> - add a restaurant
# remove <restaurant name> - remove a restaurant
# show <restaurant name>|all - show restaurant stats
# <restaurant name> was (not) <adverb> - vote for a restaurant
#

module.exports = (robot) ->
  robot.brain.data.restaurants ||= {}

  robot.respond /add (.*)/i, (msg) ->
    name = msg.match[0]
    robot.brain.data.restaurants[name] = 0
    count = Object.keys(robot.brain.data.restaurants).length

    msg.send "add #{name} to my list, bringing the total to #{count}"

