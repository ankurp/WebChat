
#
# * GET home page.
# 
exports.index = (req, res) ->
  res.render "index",
    title: req.query.room || "New Room"

  return