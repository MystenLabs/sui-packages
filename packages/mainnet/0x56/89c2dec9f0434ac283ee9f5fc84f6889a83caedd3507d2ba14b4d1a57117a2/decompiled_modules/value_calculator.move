module 0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0xda89b111cc86b01f38acf4b68987e400a7019c743f82b2490fe1cb66dac5205a::u64::mul_div(0x1::fixed_point32::get_raw_value(arg0), arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

