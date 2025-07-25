module 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::range {
    struct Range has copy, drop, store {
        min: u8,
        max: u8,
    }

    public fun length(arg0: &Range) : u8 {
        let (v0, v1) = inner(arg0);
        v1 - v0 + 1
    }

    public fun contains(arg0: &Range, arg1: &u8) : bool {
        let (v0, v1) = inner(arg0);
        *arg1 >= v0 && *arg1 <= v1
    }

    fun err_invalid_range_settings() {
        abort 0
    }

    public fun fold(arg0: &Range, arg1: u256) : u8 {
        arg0.min + ((arg1 % (length(arg0) as u256)) as u8)
    }

    public fun inner(arg0: &Range) : (u8, u8) {
        (arg0.min, arg0.max)
    }

    public fun new(arg0: u8, arg1: u8) : Range {
        if (arg0 > arg1) {
            err_invalid_range_settings();
        };
        Range{
            min : arg0,
            max : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

