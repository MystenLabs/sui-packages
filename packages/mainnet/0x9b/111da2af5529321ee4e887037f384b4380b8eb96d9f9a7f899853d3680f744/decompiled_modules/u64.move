module 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64, arg3: 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::RoundingMode) : u64 {
        let v0 = try_mul_div(arg0, arg1, arg2, arg3);
        assert!(0x1::option::is_some<u64>(&v0), 301);
        0x1::option::destroy_some<u64>(v0)
    }

    public fun try_mul_div(arg0: u64, arg1: u64, arg2: u64, arg3: 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::RoundingMode) : 0x1::option::Option<u64> {
        assert!(arg2 != 0, 300);
        let v0 = (arg2 as u256);
        let v1 = (arg0 as u256) * (arg1 as u256);
        let v2 = v1 / v0;
        let v3 = v2;
        if (v1 % v0 != 0 && 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::is_up(&arg3)) {
            v3 = v2 + 1;
        };
        if (v3 > 18446744073709551615) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>((v3 as u64))
        }
    }

    // decompiled from Move bytecode v7
}

