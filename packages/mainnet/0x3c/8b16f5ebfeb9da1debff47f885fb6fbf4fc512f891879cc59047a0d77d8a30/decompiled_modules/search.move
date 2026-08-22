module 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search {
    public fun check_bounds(arg0: u64, arg1: u64, arg2: u8) {
        assert!(arg2 <= 24, 10);
        assert!(arg0 <= arg1, 11);
    }

    public fun left(arg0: u64, arg1: u128) : u64 {
        arg0 + ((arg1 * 3819660113 / 10000000000) as u64)
    }

    public fun max_probes() : u8 {
        24
    }

    public fun profit(arg0: u64, arg1: u64) : u64 {
        if (arg1 > arg0) {
            arg1 - arg0
        } else {
            0
        }
    }

    public fun right(arg0: u64, arg1: u128) : u64 {
        arg0 + ((arg1 * 6180339887 / 10000000000) as u64)
    }

    public fun score(arg0: u64, arg1: u64) : u128 {
        (arg1 as u128) + 18446744073709551616 - (arg0 as u128)
    }

    public fun shrink(arg0: u128) : u128 {
        arg0 * 6180339887 / 10000000000
    }

    // decompiled from Move bytecode v7
}

