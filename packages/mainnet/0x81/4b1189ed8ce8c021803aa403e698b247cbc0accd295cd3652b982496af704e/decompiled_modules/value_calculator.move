module 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::u64::mul_div(0x1::fixed_point32::get_raw_value(arg0), arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

