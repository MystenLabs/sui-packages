module 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::u64::mul_div(0x1::fixed_point32::get_raw_value(arg0), arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

