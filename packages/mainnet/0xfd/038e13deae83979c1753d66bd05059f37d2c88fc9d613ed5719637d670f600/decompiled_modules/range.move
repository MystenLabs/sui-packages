module 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range {
    struct Range has copy, drop, store {
        from: u64,
        to: u64,
    }

    public fun contains(arg0: &Range, arg1: u64) : bool {
        arg1 >= arg0.from && arg1 < arg0.to
    }

    public fun len(arg0: &Range) : u64 {
        arg0.to - arg0.from
    }

    public fun new(arg0: u64, arg1: u64) : Range {
        assert!(arg1 > arg0, 0);
        Range{
            from : arg0,
            to   : arg1,
        }
    }

    public fun new_with_len(arg0: u64, arg1: u64) : Range {
        assert!(arg1 > 0, 0);
        Range{
            from : arg0,
            to   : arg0 + arg1,
        }
    }

    public fun singleton(arg0: u64) : Range {
        new(arg0, arg0 + 1)
    }

    // decompiled from Move bytecode v6
}

