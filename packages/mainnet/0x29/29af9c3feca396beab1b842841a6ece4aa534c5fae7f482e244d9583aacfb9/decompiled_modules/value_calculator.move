module 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

