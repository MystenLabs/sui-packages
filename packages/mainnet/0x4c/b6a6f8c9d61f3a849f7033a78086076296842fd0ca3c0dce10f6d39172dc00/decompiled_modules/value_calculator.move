module 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x2483a99369bbbcfe0dd45bb0b2725310d171dbbc0deda421115bbb84c31fd12d::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

