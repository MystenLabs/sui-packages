module 0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::level {
    struct Level has copy, drop, store {
        level: u8,
    }

    public fun get_level(arg0: &Level) : u8 {
        arg0.level
    }

    public entry fun new_level() : Level {
        Level{level: 1}
    }

    public entry fun none() : Level {
        Level{level: 0}
    }

    // decompiled from Move bytecode v6
}

