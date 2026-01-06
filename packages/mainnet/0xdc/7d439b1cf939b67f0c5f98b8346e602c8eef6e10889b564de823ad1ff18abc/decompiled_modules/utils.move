module 0xdc7d439b1cf939b67f0c5f98b8346e602c8eef6e10889b564de823ad1ff18abc::utils {
    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0xdc7d439b1cf939b67f0c5f98b8346e602c8eef6e10889b564de823ad1ff18abc::errors::zero_amount());
        safe_cast_to_u64((arg0 as u128) * (arg1 as u128) / (arg2 as u128))
    }

    public fun safe_cast_to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 0xdc7d439b1cf939b67f0c5f98b8346e602c8eef6e10889b564de823ad1ff18abc::errors::arithmetic_overflow());
        (arg0 as u64)
    }

    // decompiled from Move bytecode v6
}

