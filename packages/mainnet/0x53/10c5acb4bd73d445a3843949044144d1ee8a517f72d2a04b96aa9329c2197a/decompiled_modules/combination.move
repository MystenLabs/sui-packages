module 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination {
    struct Combination has copy, drop, store {
        normal_hits: u8,
        special_hits: u8,
    }

    public fun default() : Combination {
        new(5, 2)
    }

    public fun new(arg0: u8, arg1: u8) : Combination {
        Combination{
            normal_hits  : arg0,
            special_hits : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

