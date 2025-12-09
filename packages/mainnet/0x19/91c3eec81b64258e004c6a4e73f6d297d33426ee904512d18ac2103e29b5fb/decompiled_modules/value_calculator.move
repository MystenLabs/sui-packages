module 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::u64::mul_div(0x1::fixed_point32::get_raw_value(arg0), arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

