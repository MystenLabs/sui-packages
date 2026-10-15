module 0x1a86e6adb5e871744bc2655a8b1e0ae89436aba5ed998649578b90764948ec01::num {
    public fun add_u128(arg0: u128, arg1: u128) : u128 {
        arg0 + arg1
    }

    public fun add_u256(arg0: u256, arg1: u256) : u256 {
        arg0 + arg1
    }

    public fun add_u64(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun div_u128(arg0: u128, arg1: u128) : u128 {
        arg0 / arg1
    }

    public fun div_u256(arg0: u256, arg1: u256) : u256 {
        arg0 / arg1
    }

    public fun div_u64(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    public fun mul_u128(arg0: u128, arg1: u128) : u128 {
        arg0 * arg1
    }

    public fun mul_u256(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1
    }

    public fun mul_u64(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1
    }

    public fun sub_u128(arg0: u128, arg1: u128) : u128 {
        arg0 - arg1
    }

    public fun sub_u256(arg0: u256, arg1: u256) : u256 {
        arg0 - arg1
    }

    public fun sub_u64(arg0: u64, arg1: u64) : u64 {
        arg0 - arg1
    }

    public fun u128_to_u256(arg0: u128) : u256 {
        (arg0 as u256)
    }

    public fun u128_to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 13906834277422596097);
        (arg0 as u64)
    }

    public fun u256_to_u128(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 13906834320372269057);
        (arg0 as u128)
    }

    public fun u256_to_u64(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 13906834298897432577);
        (arg0 as u64)
    }

    public fun u64_to_u128(arg0: u64) : u128 {
        (arg0 as u128)
    }

    public fun u64_to_u256(arg0: u64) : u256 {
        (arg0 as u256)
    }

    // decompiled from Move bytecode v7
}

