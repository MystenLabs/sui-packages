module 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::fixed_point32_empower {
    public fun add(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0x1::fixed_point32::get_raw_value(arg0) + 0x1::fixed_point32::get_raw_value(arg1))
    }

    public fun div(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_rational(0x1::fixed_point32::get_raw_value(arg0), 0x1::fixed_point32::get_raw_value(arg1))
    }

    public fun from_u64(arg0: u64) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_rational(arg0, 1)
    }

    public fun gt(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : bool {
        0x1::fixed_point32::get_raw_value(arg0) > 0x1::fixed_point32::get_raw_value(arg1)
    }

    public fun gte(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : bool {
        0x1::fixed_point32::get_raw_value(arg0) >= 0x1::fixed_point32::get_raw_value(arg1)
    }

    public fun mul(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value((((0x1::fixed_point32::get_raw_value(arg0) as u128) * (0x1::fixed_point32::get_raw_value(arg1) as u128) >> 32) as u64))
    }

    public fun sub(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0x1::fixed_point32::get_raw_value(arg0) - 0x1::fixed_point32::get_raw_value(arg1))
    }

    public fun zero() : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_rational(0, 1)
    }

    // decompiled from Move bytecode v6
}

