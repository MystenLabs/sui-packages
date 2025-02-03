module 0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

