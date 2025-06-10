module 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::math_v1 {
    struct PoolMath has copy, drop {
        k: 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256,
        x: 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256,
        y: 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256,
        n: 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256,
        p: 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256,
    }

    public(friend) fun add_liquidity(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        if (arg0 == 0 && arg1 == 0) {
            return (arg2, arg3)
        };
        let v0 = 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::math::mul_div(arg2, arg1, arg0);
        if (v0 <= arg3) {
            return (arg2, v0)
        };
        (0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::math::mul_div(arg3, arg0, arg1), arg3)
    }

    fun common_value(arg0: &PoolMath) : (0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256, 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256, 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256, 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256) {
        let v0 = 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::from_u64(2);
        let v1 = 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::constants::float_scaling_i256();
        let v2 = 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::div(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(arg0.k, arg0.p), arg0.p), 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(v0, 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::add(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(arg0.x, arg0.p), 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(arg0.y, v1))));
        (v2, 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::sub(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(v0, v2), arg0.n), 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(arg0.p, v1)), v0, v1)
    }

    public(friend) fun new(arg0: u64, arg1: 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256, arg2: 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256, arg3: 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256, arg4: u64) : PoolMath {
        PoolMath{
            k : 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::from_u64(arg0),
            x : arg1,
            y : arg2,
            n : arg3,
            p : 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::from_u64(arg4),
        }
    }

    public(friend) fun remove_liquidity(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        (0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::math::mul_div(arg3, arg0, arg2), 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::math::mul_div(arg3, arg1, arg2))
    }

    public(friend) fun swap_x_to_y(arg0: &PoolMath, arg1: 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256) : 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256 {
        let (v0, v1, _, v3) = common_value(arg0);
        let v4 = 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::div(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::div(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::add(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(v0, arg1), arg1), 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(v1, arg1)), v3), v3);
        assert!(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::is_neg(v4), 0);
        v4
    }

    public(friend) fun swap_y_to_x(arg0: &PoolMath, arg1: 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256) : 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256 {
        let (v0, v1, v2, v3) = common_value(arg0);
        let v4 = 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::zero();
        let v5 = v4;
        let v6 = v4;
        let v7 = 0;
        while (v7 < 255) {
            v5 = 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::sub(v5, 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::div(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::sub(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::add(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(v0, v5), v5), 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(v1, v5)), 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(arg1, v3), v3)), 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::add(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(v2, v0), v5), v1)));
            v6 = v5;
            if (0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::abs_u256(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::sub(v5, v4)) < 100) {
                break
            };
            v7 = v7 + 1;
        };
        assert!(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::is_neg(v6), 0);
        v6
    }

    // decompiled from Move bytecode v6
}

