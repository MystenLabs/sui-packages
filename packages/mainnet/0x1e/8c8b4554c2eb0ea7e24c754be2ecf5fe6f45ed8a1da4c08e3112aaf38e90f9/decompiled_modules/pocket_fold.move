module 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::pocket_fold {
    fun ceil_div_capped(arg0: u256, arg1: u256) : u64 {
        if (arg1 == 0) {
            return 0
        };
        (0x1::u256::min((arg0 + arg1 - 1) / arg1, 18446744073709551615) as u64)
    }

    public fun fold(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        let v0 = part(arg3, arg2, arg4);
        if (v0 == 0) {
            return (0, arg1)
        };
        (v0, ceil_div_capped((arg0 as u256) * (arg1 as u256), (arg0 as u256) + (v0 as u256)))
    }

    public fun minted(arg0: u64, arg1: u64) : u64 {
        part(arg0, arg1, arg1)
    }

    fun part(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / ((arg2 as u128) + (1000 as u128))) as u64)
    }

    public fun residue_cost(arg0: u64, arg1: u64, arg2: u64) : u128 {
        if (arg2 >= arg1) {
            return 0
        };
        (arg0 as u128) * ((arg1 - arg2) as u128)
    }

    public fun residue_entry(arg0: u128, arg1: u64) : u64 {
        ceil_div_capped((arg0 as u256), (arg1 as u256))
    }

    public fun residue_unwind(arg0: u64, arg1: u64, arg2: u128, arg3: u16) : (u64, u128) {
        let v0 = (arg1 as u128) * (1000000000 as u128);
        if (v0 <= arg2) {
            return (0, arg2 - v0)
        };
        ((((arg0 as u256) * (arg3 as u256) * ((v0 - arg2) as u256) / (10000 as u256) * (v0 as u256)) as u64), 0)
    }

    public fun share_of(arg0: u64, arg1: u64, arg2: u64) : u64 {
        part(arg0, arg1, arg2)
    }

    public fun unwind(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u16) : (u64, u64) {
        if (arg3 == 0) {
            return (0, arg1)
        };
        let v0 = (arg0 as u256) * (arg1 as u256);
        let v1 = (arg3 as u256) * (1000000000 as u256);
        let v2 = (arg0 as u256) * (arg4 as u256) + v1;
        if (v2 <= v0) {
            return (0, ceil_div_capped(v0 - v1, (arg0 as u256)))
        };
        ((((arg2 as u256) * (arg5 as u256) * (v2 - v0) / (10000 as u256) * v2) as u64), ceil_div_capped(v0 * (arg4 as u256), v2))
    }

    public fun virtual_shares() : u64 {
        1000
    }

    // decompiled from Move bytecode v7
}

