-- refers to grid.lua in this directory, taken from the Hydra wiki: https://github.com/sdegutis/hydra/wiki/Useful-Hydra-libraries
dofile(package.searchpath("grid", package.path))

hydra.alert "Hydra, at your service."

pathwatcher.new(os.getenv("HOME") .. "/.hydra/", hydra.reload):start()
autolaunch.set(true)

menu.show(function()
  return {
  {title = "About Hydra", fn = hydra.showabout},
  {title = "-"},
  {title = "Quit", fn = os.exit},
}
end)

local mash = {"cmd", "alt", "ctrl"}

local mashshift = {"cmd", "alt", "ctrl", "shift"}

local function opendictionary()
hydra.alert("Lexicon, at your service.", 0.75)
application.launchorfocus("Dictionary")
end

--hotkey.bind(mash, 'D', opendictionary)

hotkey.bind(mashshift, ';', function() ext.grid.snap(window.focusedwindow()) end)
hotkey.bind(mashshift, "'", function() fnutils.map(window.visiblewindows(), ext.grid.snap) end)

hotkey.bind(mashshift, '=', function() ext.grid.adjustwidth( 1) end)
hotkey.bind(mashshift, '-', function() ext.grid.adjustwidth(-1) end)

-- hotkey.bind(mash, 'H', function() window.focusedwindow():focuswindow_west() end)
-- hotkey.bind(mash, 'L', function() window.focusedwindow():focuswindow_east() end)
-- hotkey.bind(mash, 'K', function() window.focusedwindow():focuswindow_north() end)
-- hotkey.bind(mash, 'J', function() window.focusedwindow():focuswindow_south() end)

hotkey.bind(mash, 'M', ext.grid.maximize_window)

hotkey.bind(mash, 'N', ext.grid.pushwindow_nextscreen)
--hotkey.bind(mash, 'P', ext.grid.pushwindow_prevscreen)

hotkey.bind(mashshift, 'DOWN', ext.grid.pushwindow_down)
hotkey.bind(mashshift, 'UP', ext.grid.pushwindow_up)
hotkey.bind(mashshift, 'LEFT', ext.grid.pushwindow_left)
hotkey.bind(mashshift, 'RIGHT', ext.grid.pushwindow_right)

hotkey.bind(mash, 'UP', ext.grid.resizewindow_smaller)
hotkey.bind(mash, 'DOWN', ext.grid.resizewindow_taller)
hotkey.bind(mash, 'RIGHT', ext.grid.resizewindow_wider)
hotkey.bind(mash, 'LEFT', ext.grid.resizewindow_thinner)

-- open or focus applications
hotkey.bind(mash, 'G', function() application.launchorfocus("Brave Browser") end)
hotkey.bind(mash, 'W', function() application.launchorfocus("Franz") end)
hotkey.bind(mash, 'D', function() application.launchorfocus("Dash") end)
hotkey.bind(mash, 'E', function() application.launchorfocus("Finder") end)
hotkey.bind(mash, 'F', function() application.launchorfocus("Firefox") end)
hotkey.bind(mash, 'S', function() application.launchorfocus("Sublime Text") end)
hotkey.bind(mash, 'V', function() application.launchorfocus("Visual Studio Code") end)
hotkey.bind(mash, 'C', function() application.launchorfocus("Slack") end)
hotkey.bind(mash, 'T', function() application.launchorfocus("iTerm") end)
hotkey.bind(mash, 'q', function() application.launchorfocus("Queue") end)
hotkey.bind(mash, 'i', function() application.launchorfocus("investing") end)
hotkey.bind(mash, 'p', function() application.launchorfocus("Brave Browser Beta") end)
-- hotkey.bind(mash, 'I', function() application.launchorfocus("Textual Trial") end)
-- hotkey.bind(mash, 'P', function() application.launchorfocus("Marked") end)

hotkey.bind(mash, 'X', logger.show)
hotkey.bind(mash, "R", repl.open)

function checkforupdates()
  -- I'm fine with making this a global; then I can call it in the REPL if I want.
  updates.check(function(hasone)
    if hasone then
      notify.show("Hydra update available", "Go download it!", "Click here to see the release notes.", "hasupdate")
    end
    end)
end
notify.register("hasupdate", function() os.execute("open " .. updates.changelogurl) end)

checkforupdates()

timer.new(timer.days(1), checkforupdates):start()
