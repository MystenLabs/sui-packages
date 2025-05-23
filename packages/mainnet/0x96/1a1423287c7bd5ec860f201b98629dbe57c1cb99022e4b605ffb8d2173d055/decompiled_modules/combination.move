module 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination {
    struct Combination has copy, drop, store {
        normal_hits: u8,
        special_hits: u8,
    }

    public fun new(arg0: u8, arg1: u8) : Combination {
        Combination{
            normal_hits  : arg0,
            special_hits : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

