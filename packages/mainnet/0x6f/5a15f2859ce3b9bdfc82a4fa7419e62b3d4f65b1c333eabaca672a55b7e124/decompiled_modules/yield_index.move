module 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index {
    struct Index has copy, drop, store {
        value: u128,
        scale: u64,
        generation: u64,
    }

    public fun advance(arg0: &mut Index, arg1: u128, arg2: u128) {
        assert!(arg1 != 0, 1);
        assert!(arg0.value >= 18446744073709551616, 6);
        if (arg2 == 0) {
            reset(arg0);
            return
        };
        let v0 = (arg0.value as u256) * (arg2 as u256);
        let v1 = (arg1 as u256);
        let v2 = v0 / v1;
        let v3 = v2;
        if (v2 < (18446744073709551616 as u256)) {
            let v4 = if (v0 < v1) {
                2
            } else {
                1
            };
            assert!(arg0.scale >= v4, 2);
            let v5 = if (v4 == 2) {
                (18446744073709551616 as u256) * (18446744073709551616 as u256)
            } else {
                (18446744073709551616 as u256)
            };
            v3 = v0 * v5 / v1;
            arg0.scale = arg0.scale - v4;
        } else if (v2 > 340282366920938463463374607431768211455) {
            let v6 = v2 / (18446744073709551616 as u256);
            v3 = v6;
            let v7 = if (v6 > 340282366920938463463374607431768211455) {
                v3 = v6 / (18446744073709551616 as u256);
                2
            } else {
                1
            };
            assert!(arg0.scale <= 18446744073709551615 - v7, 7);
            arg0.scale = arg0.scale + v7;
        };
        assert!(v3 >= (18446744073709551616 as u256) && v3 <= 340282366920938463463374607431768211455, 4);
        arg0.value = (v3 as u128);
    }

    public fun apply(arg0: u64, arg1: u64, arg2: Index, arg3: Index) : (u64, u64) {
        if (arg2.value == 0) {
            return (arg0, 0)
        };
        if (arg2.generation != arg3.generation) {
            return (0, 0)
        };
        if (is_loss(&arg2, &arg3)) {
            let v0 = ratio_floor((arg0 as u128), &arg2, &arg3);
            assert!(v0 <= 18446744073709551615, 4);
            return ((v0 as u64), 0)
        };
        if (arg0 == 0) {
            return (0, arg1)
        };
        let v1 = (arg0 as u256) * (18446744073709551616 as u256) + (arg1 as u256);
        assert!(v1 <= 340282366920938463463374607431768211455, 4);
        let v2 = ratio_floor((v1 as u128), &arg2, &arg3);
        let v3 = v2 / 18446744073709551616;
        assert!(v3 <= 18446744073709551615, 4);
        ((v3 as u64), ((v2 % 18446744073709551616) as u64))
    }

    public fun generation(arg0: &Index) : u64 {
        arg0.generation
    }

    fun is_loss(arg0: &Index, arg1: &Index) : bool {
        arg1.scale < arg0.scale || arg1.scale == arg0.scale && arg1.value < arg0.value
    }

    public fun new() : Index {
        Index{
            value      : 18446744073709551616,
            scale      : 9223372036854775808,
            generation : 0,
        }
    }

    fun ratio_floor(arg0: u128, arg1: &Index, arg2: &Index) : u128 {
        assert!(arg1.value >= 18446744073709551616, 6);
        assert!(arg2.value >= 18446744073709551616, 6);
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 as u256) * (arg2.value as u256);
        if (arg2.scale >= arg1.scale) {
            let v1 = arg2.scale - arg1.scale;
            assert!(v1 <= 2, 5);
            let v2 = if (v1 == 0) {
                1
            } else if (v1 == 1) {
                (18446744073709551616 as u256)
            } else {
                (18446744073709551616 as u256) * (18446744073709551616 as u256)
            };
            assert!(v0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v2, 5);
            let v3 = v0 * v2 / (arg1.value as u256);
            assert!(v3 <= 340282366920938463463374607431768211455, 4);
            return (v3 as u128)
        };
        let v4 = arg1.scale - arg2.scale;
        if (v4 >= 3) {
            return 0
        };
        let v5 = if (v4 == 2) {
            v0 / (arg1.value as u256) / (18446744073709551616 as u256) / (18446744073709551616 as u256)
        } else {
            v0 / (arg1.value as u256) / (18446744073709551616 as u256)
        };
        assert!(v5 <= 340282366920938463463374607431768211455, 4);
        (v5 as u128)
    }

    public fun reset(arg0: &mut Index) {
        assert!(arg0.value >= 18446744073709551616, 6);
        assert!(arg0.generation != 18446744073709551615, 3);
        arg0.value = 18446744073709551616;
        arg0.scale = 9223372036854775808;
        arg0.generation = arg0.generation + 1;
    }

    public fun scale(arg0: &Index) : u64 {
        arg0.scale
    }

    public fun uninitialized() : Index {
        Index{
            value      : 0,
            scale      : 9223372036854775808,
            generation : 0,
        }
    }

    public fun value(arg0: &Index) : u128 {
        arg0.value
    }

    // decompiled from Move bytecode v7
}

