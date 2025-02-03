module 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

