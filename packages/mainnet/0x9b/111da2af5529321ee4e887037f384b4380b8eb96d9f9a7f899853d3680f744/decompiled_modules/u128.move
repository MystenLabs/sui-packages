module 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::u128 {
    public fun mul_div(arg0: u128, arg1: u128, arg2: u128, arg3: 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::RoundingMode) : u128 {
        let v0 = try_mul_div(arg0, arg1, arg2, arg3);
        assert!(0x1::option::is_some<u128>(&v0), 351);
        0x1::option::destroy_some<u128>(v0)
    }

    public fun try_mul_div(arg0: u128, arg1: u128, arg2: u128, arg3: 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::RoundingMode) : 0x1::option::Option<u128> {
        assert!(arg2 != 0, 350);
        let v0 = (arg2 as u256);
        let v1 = (arg0 as u256) * (arg1 as u256);
        let v2 = v1 / v0;
        let v3 = v2;
        if (v1 % v0 != 0 && 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::is_up(&arg3)) {
            v3 = v2 + 1;
        };
        if (v3 > 340282366920938463463374607431768211455) {
            0x1::option::none<u128>()
        } else {
            0x1::option::some<u128>((v3 as u128))
        }
    }

    // decompiled from Move bytecode v7
}

