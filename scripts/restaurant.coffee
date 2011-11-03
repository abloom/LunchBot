# Manage the list of restaurants in Lunchbot
#
# add <restaurant name> - add a restaurant
# remove <restaurant name> - remove a restaurant
# show <restaurant name>|all - show restaurant stats
# <restaurant name> was (not) <adverb> - vote for a restaurant
# whats for lunch|wfl

module.exports = (robot) ->
  robot.brain.data.restaurants ||= {}

  robot.respond /add (.*)$/i, (msg) ->
    name = msg.match[1]
    robot.brain.data.restaurants[name] = 0
    count = Object.keys(robot.brain.data.restaurants).length

    msg.send "added #{name} to my list, bringing the total to #{count}"

  robot.respond /remove (.*)$/i, (msg) ->
    name = msg.match[1]
    delete robot.brain.data.restaurants[name]
    count = Object.keys(robot.brain.data.restaurants).length

    msg.send "removed #{name} from my list, bringing the total to #{count}"

  robot.respond /show (.*)$/i, (msg) ->
    name = msg.match[1]

    if name is "all"
      response = for name, votes of robot.brain.data.restaurants
        "#{name}: #{votes}"

      response.sort()
      response.push "Total: #{response.length}"
      msg.send response.join "\n"

    else
      msg.send "#{name}: #{robot.brain.data.restaurants[name]}"

  robot.respond /(.*) was (not )?(.*)$/, (msg) ->
    name = msg.match[1]
    vote = !msg.match[2]
    adverb = msg.match[3]

    response = if vote
      robot.brain.data.restaurants[name] ||= 0
      robot.brain.data.restaurants[name]++
      "glad you liked it!"
    else
      robot.brain.data.restaurants[name] ||= 0
      robot.brain.data.restaurants[name]--
      "sorry you didn't enjoy it"

    count = robot.brain.data.restaurants[name]
    msg.send "#{name} is now at #{count}. #{response}"

  robot.hear /(what'?s for lunch|wfl)/i, (msg) ->
    count = robot.brain.data.restaurants
    rand = Math.floor(Math.random() * count)
    names = Object.keys(robot.brain.data.restaurants)
    name = names[rand]

    msg.send "How about #{name}?"
