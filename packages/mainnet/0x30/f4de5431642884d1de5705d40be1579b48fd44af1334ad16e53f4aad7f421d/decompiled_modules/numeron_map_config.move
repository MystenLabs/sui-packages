module 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_map_config {
    struct MapConfig has copy, drop, store {
        width: u64,
        height: u64,
        background: 0x1::ascii::String,
    }

    public fun get(arg0: &MapConfig) : (u64, u64, 0x1::ascii::String) {
        (arg0.width, arg0.height, arg0.background)
    }

    public fun get_background(arg0: &MapConfig) : 0x1::ascii::String {
        arg0.background
    }

    public fun get_height(arg0: &MapConfig) : u64 {
        arg0.height
    }

    public fun get_width(arg0: &MapConfig) : u64 {
        arg0.width
    }

    public fun new(arg0: u64, arg1: u64, arg2: 0x1::ascii::String) : MapConfig {
        MapConfig{
            width      : arg0,
            height     : arg1,
            background : arg2,
        }
    }

    public(friend) fun set(arg0: &mut MapConfig, arg1: u64, arg2: u64, arg3: 0x1::ascii::String) {
        arg0.width = arg1;
        arg0.height = arg2;
        arg0.background = arg3;
    }

    public(friend) fun set_background(arg0: &mut MapConfig, arg1: 0x1::ascii::String) {
        arg0.background = arg1;
    }

    public(friend) fun set_height(arg0: &mut MapConfig, arg1: u64) {
        arg0.height = arg1;
    }

    public(friend) fun set_width(arg0: &mut MapConfig, arg1: u64) {
        arg0.width = arg1;
    }

    // decompiled from Move bytecode v6
}

