local Config = {}

-- ========================
-- Resolution Presets
-- ========================
Config.presets = {
    low = {
        width = 854,
        height = 480,
        scale = 1
    },
    medium = {
        width = 1280,
        height = 720,
        scale = 2
    },
    high = {
        width = 1920,
        height = 1080,
        scale = 3
    },
    ultra = {
        width = 2560,
        height = 1440,
        scale = 4
    }
}

-- ========================
-- Active Preset
-- ========================
Config.current = Config.presets.medium

-- ========================
-- Window Settings
-- ========================
Config.window = {
    width = Config.current.width,
    height = Config.current.height,
    fullscreen = false,
    vsync = true
}

-- ========================
-- Tile Settings
-- ========================
Config.tile = {
    size = 16,
    scale = Config.current.scale
}

Config.tile.render_size = Config.tile.size * Config.tile.scale

-- ========================
-- Character Settings
-- ========================
Config.character = {
    original_size = 100,
    target_size = Config.tile.render_size * 2
}

Config.character.scale = Config.character.target_size / Config.character.original_size

-- ========================
-- World Settings
-- ========================
Config.world = {
    tile_width = math.floor(Config.window.width / Config.tile.render_size),
    tile_height = math.floor(Config.window.height / Config.tile.render_size)
}

-- ========================
-- Camera Settings
-- ========================
Config.virtual = {
    width = 320,   -- 20 tiles * 16
    height = 180   -- 16:9 ratio
}
return Config
