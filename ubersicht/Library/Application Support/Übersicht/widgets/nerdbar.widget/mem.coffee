command: "ESC=`printf \"\e\"`; ps -A -o %mem | awk '{s+=$1} END {print \"\" s}'"

refreshFrequency: 30000 # ms

render: (output) ->
  """
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
  <div class="mem"
    <span></span>
    <span class="icon"></span>
  </div>
  """

update: (output, el) ->
    $(".mem span:first-child", el).text("  #{output}")
    $icon = $(".mem span.icon", el)
    $icon.removeClass().addClass("icon")
    $icon.addClass("fa fa-hdd-o")

style: """
  -webkit-font-smoothing: antialiased
  color: #98d1ce
  font: 10px Pragmata Pro
  right: 210px
  top: 6px
"""
