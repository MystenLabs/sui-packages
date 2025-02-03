module 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

