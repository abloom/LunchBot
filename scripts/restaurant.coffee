# Manage the list of restaurants in Lunchbot
#
# add <restaurant name> - add a restaurant
# remove <restaurant name> - remove a restaurant
# show <restaurant name>|all - show restaurant stats
# <restaurant name> was (not) <adverb> - vote for a restaurant
#

module.exports = (robot) ->
  robot.brain.data.restaurants ||= {}

  robot.respond /add (.*)$/i, (msg) ->
    name = msg.match[0]
    robot.brain.data.restaurants[name] = 0
    count = Object.keys(robot.brain.data.restaurants).length

    msg.send "added #{name} to my list, bringing the total to #{count}"

  robot.respond /remove (.*)$/i, (msg) ->
    name = msg.match[0]
    delete robot.brain.data.restaurants[name]
    count = Object.keys(robot.brain.data.restaurants).length

    msg.send "removed #{name} from my list, bringing the total to #{count}"

  robot.respond /show (.*)$/, (msg) ->
    name = msg.match[0]
    response = ""

    response = if name is "all"
      for name, votes of robot.brain.data.restaurants
        "#{name}: #{robot.brain.data.restaurants[name]}"
    else
      "#{name}: #{robot.brain.data.restaurants[name]}"

    msg.send response

  robot.respond /(.*) was (not) (.*)$/, (msg) ->
    msg.send "vote"
