module 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

