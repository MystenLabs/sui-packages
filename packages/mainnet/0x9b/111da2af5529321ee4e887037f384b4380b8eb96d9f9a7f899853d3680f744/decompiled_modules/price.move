module 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::price {
    public fun compute_usd_value(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::RoundingMode) : u64 {
        if (arg0 == 0) {
            return 0
        };
        assert!(arg1 > 0, 102);
        narrow((arg0 as u256) * (arg1 as u256) * (1000000000 as u256), (pow10(arg2) as u256) * (pow10((arg3 as u64)) as u256), arg4)
    }

    public fun compute_value(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u8, arg7: 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::RoundingMode) : u64 {
        if (arg0 == 0) {
            return 0
        };
        assert!(arg1 > 0, 102);
        assert!(arg4 > 0, 102);
        narrow((arg0 as u256) * (arg1 as u256) * (pow10(arg5) as u256) * (pow10((arg6 as u64)) as u256), (arg4 as u256) * (pow10(arg2) as u256) * (pow10((arg3 as u64)) as u256), arg7)
    }

    fun narrow(arg0: u256, arg1: u256, arg2: 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::RoundingMode) : u64 {
        let v0 = arg0 / arg1;
        let v1 = v0;
        if (arg0 % arg1 != 0 && 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::is_up(&arg2)) {
            v1 = v0 + 1;
        };
        assert!(v1 <= 18446744073709551615, 100);
        (v1 as u64)
    }

    public fun pow10(arg0: u64) : u64 {
        assert!(arg0 <= 18, 101);
        0x1::u64::pow(10, (arg0 as u8))
    }

    public fun precision() : u64 {
        1000000000
    }

    // decompiled from Move bytecode v7
}

