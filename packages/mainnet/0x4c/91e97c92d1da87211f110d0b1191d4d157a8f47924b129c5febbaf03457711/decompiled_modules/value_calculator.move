module 0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

