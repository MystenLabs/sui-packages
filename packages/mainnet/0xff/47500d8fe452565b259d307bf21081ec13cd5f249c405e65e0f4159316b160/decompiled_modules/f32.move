module 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::f32 {
    public fun convert_from_u64(arg0: u64) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_rational(arg0, 1)
    }

    public fun diff(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0x1::fixed_point32::get_raw_value(arg0) - 0x1::fixed_point32::get_raw_value(arg1))
    }

    public fun is_equal(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : bool {
        0x1::fixed_point32::get_raw_value(arg0) == 0x1::fixed_point32::get_raw_value(arg1)
    }

    public fun is_greater_than(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : bool {
        0x1::fixed_point32::get_raw_value(arg0) > 0x1::fixed_point32::get_raw_value(arg1)
    }

    public fun is_greater_than_or_equal(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : bool {
        0x1::fixed_point32::get_raw_value(arg0) >= 0x1::fixed_point32::get_raw_value(arg1)
    }

    public fun is_lesser_than(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : bool {
        0x1::fixed_point32::get_raw_value(arg0) < 0x1::fixed_point32::get_raw_value(arg1)
    }

    public fun is_lesser_than_or_equal(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : bool {
        0x1::fixed_point32::get_raw_value(arg0) <= 0x1::fixed_point32::get_raw_value(arg1)
    }

    public fun product(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value((((0x1::fixed_point32::get_raw_value(arg0) as u128) * (0x1::fixed_point32::get_raw_value(arg1) as u128) >> 32) as u64))
    }

    public fun quotient(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_rational(0x1::fixed_point32::get_raw_value(arg0), 0x1::fixed_point32::get_raw_value(arg1))
    }

    public fun sum(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0x1::fixed_point32::get_raw_value(arg0) + 0x1::fixed_point32::get_raw_value(arg1))
    }

    public fun zero() : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_rational(0, 1)
    }

    // decompiled from Move bytecode v6
}

