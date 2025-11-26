module 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::u64::mul_div(0x1::fixed_point32::get_raw_value(arg0), arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

