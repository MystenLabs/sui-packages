module 0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::level {
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

