module 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

