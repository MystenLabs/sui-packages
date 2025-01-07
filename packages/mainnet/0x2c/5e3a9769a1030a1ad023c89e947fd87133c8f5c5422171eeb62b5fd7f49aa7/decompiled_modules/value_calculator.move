module 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

