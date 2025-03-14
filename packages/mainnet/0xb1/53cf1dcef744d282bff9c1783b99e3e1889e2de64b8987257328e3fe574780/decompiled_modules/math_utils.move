module 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::math_utils {
    public fun add_div_fixed64(arg0: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::add(arg0, div_fixed64(arg1, arg2))
    }

    public fun div_fixed64(arg0: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(arg0), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(arg1))
    }

    public fun muldiv_fixed64_u64_u64(arg0: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg1: u64, arg2: u64) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_raw_value((((0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(arg0) as u256) * (arg1 as u256) / (arg2 as u256)) as u128))
    }

    public fun sub_div_fixed64(arg0: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::sub(arg0, div_fixed64(arg1, arg2))
    }

    // decompiled from Move bytecode v6
}

