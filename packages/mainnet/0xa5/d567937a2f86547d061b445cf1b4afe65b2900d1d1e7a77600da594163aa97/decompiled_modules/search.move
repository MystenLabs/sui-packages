module 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search {
    public fun e_bad_bounds() : u64 {
        11
    }

    public fun e_too_many_probes() : u64 {
        10
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

    public fun score(arg0: u64, arg1: u64) : u128 {
        (arg1 as u128) + 18446744073709551616 - (arg0 as u128)
    }

    // decompiled from Move bytecode v7
}

