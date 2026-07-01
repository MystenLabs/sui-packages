module 0x69f56ddcf0afd984804b0a17f11539a575854cb6fac16b887328abcf8f966bc2::math {
    public fun mul_factor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        ((((arg0 as u128) * (arg1 as u128) + (arg2 as u128) / 2) / (arg2 as u128)) as u64)
    }

    public fun mul_factor_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 0);
        ((((arg0 as u256) * (arg1 as u256) + (arg2 as u256) / 2) / (arg2 as u256)) as u128)
    }

    // decompiled from Move bytecode v7
}

