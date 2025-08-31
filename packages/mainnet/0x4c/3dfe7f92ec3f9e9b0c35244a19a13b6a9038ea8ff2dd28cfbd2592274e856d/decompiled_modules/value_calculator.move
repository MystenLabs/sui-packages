module 0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

