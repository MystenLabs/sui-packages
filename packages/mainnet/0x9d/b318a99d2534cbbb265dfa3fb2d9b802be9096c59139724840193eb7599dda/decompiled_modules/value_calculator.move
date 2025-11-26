module 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::u64::mul_div(0x1::fixed_point32::get_raw_value(arg0), arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

