module 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::bps {
    public fun denominator() : u64 {
        10000
    }

    public fun mul_bps(arg0: u64, arg1: u64, arg2: 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::RoundingMode) : u64 {
        let v0 = 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::u64::try_mul_div(arg0, arg1, 10000, arg2);
        assert!(0x1::option::is_some<u64>(&v0), 400);
        0x1::option::destroy_some<u64>(v0)
    }

    // decompiled from Move bytecode v7
}

