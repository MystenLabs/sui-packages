module 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::level {
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

