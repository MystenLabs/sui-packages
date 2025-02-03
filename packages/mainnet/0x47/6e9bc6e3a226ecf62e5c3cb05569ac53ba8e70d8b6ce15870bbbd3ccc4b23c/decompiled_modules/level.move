module 0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::level {
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

