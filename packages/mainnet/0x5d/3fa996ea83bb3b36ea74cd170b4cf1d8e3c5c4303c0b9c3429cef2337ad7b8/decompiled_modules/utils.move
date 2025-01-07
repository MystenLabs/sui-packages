module 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::utils {
    public fun sum_f32(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0x1::fixed_point32::get_raw_value(arg0) + 0x1::fixed_point32::get_raw_value(arg1))
    }

    // decompiled from Move bytecode v6
}

