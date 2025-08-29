module 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

