module 0x2f3bfde0b46644deb1ba583b60c054965d485482e25ab3465526f6165e145f9b::clmm_math {
    public fun get_amount0_delta(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u64 {
        let (v0, v1) = if (arg0 > arg1) {
            (arg1, arg0)
        } else {
            (arg0, arg1)
        };
        assert!(v0 > 0, 1);
        let v2 = if (arg3) {
            0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::div_up(0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up((arg2 as u256) << 64, ((v1 - v0) as u256), (v1 as u256)), (v0 as u256))
        } else {
            0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down((arg2 as u256) << 64, ((v1 - v0) as u256), (v1 as u256)) / (v0 as u256)
        };
        assert!(v2 <= 18446744073709551615, 2);
        (v2 as u64)
    }

    public fun get_amount1_delta(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u64 {
        let (v0, v1) = if (arg0 > arg1) {
            (arg1, arg0)
        } else {
            (arg0, arg1)
        };
        let v2 = if (arg3) {
            (arg2 as u256) * ((v1 - v0) as u256) + 18446744073709551615 >> 64
        } else {
            (arg2 as u256) * ((v1 - v0) as u256) >> 64
        };
        assert!(v2 <= 18446744073709551615, 2);
        (v2 as u64)
    }

    public fun get_next_sqrt_price_from_amount0_rounding_up(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0, 3);
        if (arg2 == 0) {
            arg0
        } else {
            let v1 = (arg1 as u256) << 64;
            let v2 = (arg0 as u256);
            let v3 = (arg2 as u256) * v2;
            if (arg3) {
                (0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(v1, v2, v1 + v3) as u128)
            } else {
                assert!(v1 > v3, 4);
                let v4 = v1 - v3;
                assert!(0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(v1, v2, 340282366920938463463374607431768211455) <= v4, 4);
                (0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(v1, v2, v4) as u128)
            }
        }
    }

    public fun get_next_sqrt_price_from_amount1_rounding_down(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        assert!(arg1 > 0, 3);
        let v0 = (arg0 as u256);
        if (arg3) {
            let v2 = v0 + ((arg2 as u256) << 64) / (arg1 as u256);
            assert!(v2 <= 340282366920938463463374607431768211455, 4);
            (v2 as u128)
        } else {
            let v3 = 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::div_up((arg2 as u256) << 64, (arg1 as u256));
            assert!(v0 > v3, 5);
            ((v0 - v3) as u128)
        }
    }

    public fun get_next_sqrt_price_from_input(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0, 3);
        if (arg3) {
            get_next_sqrt_price_from_amount0_rounding_up(arg0, arg1, arg2, true)
        } else {
            get_next_sqrt_price_from_amount1_rounding_down(arg0, arg1, arg2, true)
        }
    }

    public fun get_next_sqrt_price_from_output(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0, 3);
        if (arg3) {
            get_next_sqrt_price_from_amount1_rounding_down(arg0, arg1, arg2, false)
        } else {
            get_next_sqrt_price_from_amount0_rounding_up(arg0, arg1, arg2, false)
        }
    }

    // decompiled from Move bytecode v7
}

