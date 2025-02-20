module 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(0x1::fixed_point32::get_raw_value(arg0), arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

