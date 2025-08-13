module 0xba453454bda67420ced70678b11204ff001c8a76a834bfdad92ed44f9ddd1fb4::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        safe_from_u128(0xba453454bda67420ced70678b11204ff001c8a76a834bfdad92ed44f9ddd1fb4::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128)))
    }

    public fun safe_from_u128(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 1);
        (arg0 as u64)
    }

    public fun safe_from_u256(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 1);
        (arg0 as u64)
    }

    // decompiled from Move bytecode v6
}

