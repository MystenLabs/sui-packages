module 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

