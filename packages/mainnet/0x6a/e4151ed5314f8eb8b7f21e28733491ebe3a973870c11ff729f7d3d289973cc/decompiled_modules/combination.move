module 0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::combination {
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

