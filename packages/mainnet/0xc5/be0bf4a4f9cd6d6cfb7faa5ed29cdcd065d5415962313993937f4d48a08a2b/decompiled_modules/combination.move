module 0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::combination {
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

