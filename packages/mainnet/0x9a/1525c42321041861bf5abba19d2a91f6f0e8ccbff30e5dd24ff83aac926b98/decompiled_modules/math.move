module 0x9a1525c42321041861bf5abba19d2a91f6f0e8ccbff30e5dd24ff83aac926b98::math {
    public fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) + (arg1 as u128)) as u64)
    }

    public fun safe_div_u64(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) / (arg1 as u128)) as u64)
    }

    public fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128)) as u64)
    }

    public fun safe_sub_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            return 0
        };
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

