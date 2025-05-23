module 0xc4dc3689be30df2366705e110f7766eda47a72c5e023c331167ad30c4b276ea3::combination {
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

