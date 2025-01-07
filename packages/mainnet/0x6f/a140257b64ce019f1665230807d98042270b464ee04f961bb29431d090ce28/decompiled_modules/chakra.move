module 0x6fa140257b64ce019f1665230807d98042270b464ee04f961bb29431d090ce28::chakra {
    struct CHAKRA has drop {
        dummy_field: bool,
    }

    struct Chakra has drop, store {
        points: u64,
    }

    public fun create(arg0: u64) : Chakra {
        Chakra{points: arg0}
    }

    public(friend) fun points(arg0: &Chakra) : u64 {
        arg0.points
    }

    public fun set_points(arg0: &mut Chakra, arg1: u64) {
        arg0.points = arg1;
    }

    // decompiled from Move bytecode v6
}

