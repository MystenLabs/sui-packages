module 0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::combination {
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

