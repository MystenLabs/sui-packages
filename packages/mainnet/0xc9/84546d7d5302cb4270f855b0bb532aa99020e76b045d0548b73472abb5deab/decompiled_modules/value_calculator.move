module 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::u64::mul_div(0x1::fixed_point32::get_raw_value(arg0), arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

