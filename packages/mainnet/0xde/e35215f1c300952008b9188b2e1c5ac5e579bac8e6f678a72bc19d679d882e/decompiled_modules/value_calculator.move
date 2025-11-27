module 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::u64::mul_div(0x1::fixed_point32::get_raw_value(arg0), arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

