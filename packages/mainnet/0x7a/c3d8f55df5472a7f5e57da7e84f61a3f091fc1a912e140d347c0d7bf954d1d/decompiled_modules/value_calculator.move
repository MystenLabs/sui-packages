module 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::u64::mul_div(0x1::fixed_point32::get_raw_value(arg0), arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

