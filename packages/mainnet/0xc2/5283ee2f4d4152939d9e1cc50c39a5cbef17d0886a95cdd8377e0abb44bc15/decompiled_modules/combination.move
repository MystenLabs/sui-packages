module 0xc25283ee2f4d4152939d9e1cc50c39a5cbef17d0886a95cdd8377e0abb44bc15::combination {
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

