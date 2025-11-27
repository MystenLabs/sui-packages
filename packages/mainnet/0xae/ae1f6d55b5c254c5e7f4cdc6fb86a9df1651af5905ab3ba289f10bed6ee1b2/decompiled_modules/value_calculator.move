module 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::u64::mul_div(0x1::fixed_point32::get_raw_value(arg0), arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

