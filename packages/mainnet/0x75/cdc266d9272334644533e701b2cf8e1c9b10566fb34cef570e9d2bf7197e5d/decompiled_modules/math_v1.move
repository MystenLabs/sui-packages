module 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::math_v1 {
    struct PoolMath has copy, drop {
        k: 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256,
        x: 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256,
        y: 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256,
        n: 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256,
        p: 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256,
    }

    public(friend) fun add_liquidity(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        if (arg0 == 0 && arg1 == 0) {
            return (arg2, arg3)
        };
        let v0 = 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::math::mul_div(arg2, arg1, arg0);
        if (v0 <= arg3) {
            return (arg2, v0)
        };
        (0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::math::mul_div(arg3, arg0, arg1), arg3)
    }

    fun common_value(arg0: &PoolMath) : (0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256, 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256, 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256) {
        let v0 = 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::constants::float_scaling_i256();
        let v1 = 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::div(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(arg0.k, arg0.p), arg0.p), 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul_u64(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::add(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(arg0.x, arg0.p), 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(arg0.y, v0)), 2));
        (v1, 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::sub(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul_u64(v1, 2), arg0.n), 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(arg0.p, v0)), v0)
    }

    public(friend) fun new(arg0: u64, arg1: 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256, arg2: 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256, arg3: 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256, arg4: u64) : PoolMath {
        PoolMath{
            k : 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::from_u64(arg0),
            x : arg1,
            y : arg2,
            n : arg3,
            p : 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::from_u64(arg4),
        }
    }

    public(friend) fun remove_liquidity(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        (0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::math::mul_div(arg3, arg0, arg2), 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::math::mul_div(arg3, arg1, arg2))
    }

    public(friend) fun swap_x_to_y(arg0: &PoolMath, arg1: 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256) : (0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256, u64) {
        let (v0, v1, v2) = common_value(arg0);
        let v3 = 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::div(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::div(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::add(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(v0, arg1), arg1), 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(v1, arg1)), v2), v2);
        assert!(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::is_neg(v3), 0);
        (v3, 0)
    }

    public(friend) fun swap_y_to_x(arg0: &PoolMath, arg1: 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256) : (0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256, u64) {
        let (v0, v1, v2) = common_value(arg0);
        let v3 = 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(arg1, v2), v2);
        let v4 = 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::div(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::neg(v3), 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(arg0.p, v2));
        let v5 = v4;
        let v6 = v4;
        let v7 = 0;
        while (v7 < 255) {
            v5 = 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::sub(v5, 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::div(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::sub(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::add(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(v0, v5), v5), 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(v1, v5)), v3), 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::add(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::mul_u64(v0, 2), v5), v1)));
            v6 = v5;
            if (0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::abs_u256(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::sub(v5, v4)) < 100) {
                break
            };
            v7 = v7 + 1;
        };
        assert!(0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::is_neg(v6), 0);
        (v6, v7 + 1)
    }

    // decompiled from Move bytecode v6
}

