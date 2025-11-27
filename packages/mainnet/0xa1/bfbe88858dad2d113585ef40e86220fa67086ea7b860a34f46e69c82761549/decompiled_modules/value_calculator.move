module 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::u64::mul_div(0x1::fixed_point32::get_raw_value(arg0), arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

