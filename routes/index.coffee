
#
# * GET home page.
# 
exports.index = (req, res) ->
  res.render "index",
    title: "New Room"

  return