module 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::level {
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

