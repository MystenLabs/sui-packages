module 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

