module 0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v7
}

