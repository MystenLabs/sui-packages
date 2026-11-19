module 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils {
    public fun calculate_compounded_interest(arg0: u256, arg1: u64, arg2: u64) : u256 {
        let v0 = ((arg2 - arg1) as u256);
        if (v0 == 0) {
            0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::wad_ray_math::ray()
        } else {
            let v2 = v0 - 1;
            let v3 = if (v0 > 2) {
                v0 - 2
            } else {
                0
            };
            let v4 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::wad_ray_math::ray_mul(arg0, arg0) / 31536000 * 31536000;
            0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::wad_ray_math::ray() + arg0 * v0 / 31536000 + v0 * v2 * v4 / 2 + v0 * v2 * v3 * 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::wad_ray_math::ray_mul(v4, arg0) / 31536000 / 6
        }
    }

    public fun safe_cast(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 0);
        (arg0 as u64)
    }

    public fun safe_cast_2(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 0);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v7
}

