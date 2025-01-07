module 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::math_utils {
    public fun calculate_compounded_interest(arg0: &0x2::clock::Clock, arg1: u256, arg2: u64) : u256 {
        calculate_compounded_interest_(arg1, arg2, 0x2::clock::timestamp_ms(arg0))
    }

    public fun calculate_compounded_interest_(arg0: u256, arg1: u64, arg2: u64) : u256 {
        let v0 = 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::safe_math::sub((arg2 as u256), (arg1 as u256));
        if (v0 == 0) {
            return 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray()
        };
        let v1 = v0 - 1;
        let v2 = 0;
        if (v0 > 2) {
            v2 = v0 - 2;
        };
        let v3 = 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::safe_math::div(arg0, 31536000);
        let v4 = 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(v3, v3);
        0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::safe_math::add(0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray(), 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::safe_math::add(0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::safe_math::add(0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::safe_math::mul(v3, v0), 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::safe_math::mul(0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::safe_math::mul(v0, v1), v4) / 2), 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::safe_math::mul(0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::safe_math::mul(0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::safe_math::mul(v0, v1), v2), 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(v4, v3)) / 6))
    }

    public fun calculate_linear_interest(arg0: &0x2::clock::Clock, arg1: u256, arg2: u64) : u256 {
        0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::safe_math::add(0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::safe_math::mul(arg1, ((0x2::clock::timestamp_ms(arg0) - arg2) as u256)) / 31536000, 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray())
    }

    // decompiled from Move bytecode v6
}

