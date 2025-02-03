module 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

