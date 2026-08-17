local settings = require "settings"
settings.window.home_page = "https://github.com/tim-littlefair/balena-block-experiments"

-- On RPi 3A+ 02W the WebKitWebProcess started by
-- Luakit seems to freeze and crash the device before
-- the default web URL (the b-b-e project's README.md on GitHub)
-- is fully rendered.
-- It may be that this relates to the Luakit issue below, which 
-- advises that disabling accelerated compositing ('AC mode')
-- may be a workaround to avoid the freeze.
-- https://github.com/luakit/luakit/issues/1081
settings.webview.hardware_acceleration_policy = "never"
