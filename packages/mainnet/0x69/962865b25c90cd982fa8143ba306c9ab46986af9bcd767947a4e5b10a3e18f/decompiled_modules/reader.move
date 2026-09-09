module 0x69962865b25c90cd982fa8143ba306c9ab46986af9bcd767947a4e5b10a3e18f::reader {
    public fun current<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg1: bool) : (u128, u128, u64, u64) {
        let (v0, v1, _) = 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::get_reserves<T0, T1>(arg0);
        let (v3, v4) = if (arg1) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        (to_u128(v3), to_u128(v4), 30, 10000)
    }

    fun to_u128(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v7
}

