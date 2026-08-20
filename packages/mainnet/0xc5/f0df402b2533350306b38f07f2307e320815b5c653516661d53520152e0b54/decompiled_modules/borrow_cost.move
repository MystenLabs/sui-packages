module 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::borrow_cost {
    public fun compute_borrow_cost(arg0: u64, arg1: u64, arg2: u128, arg3: u128) : u64 {
        if (arg2 <= arg3) {
            return 0
        };
        (((arg0 as u128) * (arg1 as u128) / 1000000000 * (arg2 - arg3) / 1000000000000000000) as u64)
    }

    public fun compute_borrow_cost_from_rate(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg0 == 0
        };
        if (v0) {
            return 0
        };
        (((arg0 as u128) * (arg1 as u128) / 1000000000 * (arg2 as u128) * (arg3 as u128) / 31536000 * 10000) as u64)
    }

    public fun direction_short() : u8 {
        1
    }

    public fun is_short(arg0: u8) : bool {
        arg0 == 1
    }

    // decompiled from Move bytecode v7
}

