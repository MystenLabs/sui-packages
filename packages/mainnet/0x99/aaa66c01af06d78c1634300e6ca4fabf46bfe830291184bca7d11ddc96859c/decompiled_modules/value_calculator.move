module 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

