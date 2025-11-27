module 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::u64::mul_div(0x1::fixed_point32::get_raw_value(arg0), arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

