module 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::clmm_math {
    public fun compute_swap_step(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: bool) : (u64, u64, u128, u64) {
        let v0 = 0;
        let v1 = v0;
        if (arg2 == 0 || arg0 == arg1) {
            return (0, 0, arg1, v0)
        };
        if (arg5) {
            assert!(arg0 > arg1, 13835904928344047623);
        } else {
            assert!(arg0 < arg1, 13835904936933982215);
        };
        let (v2, v3, v4) = if (arg7) {
            let v5 = if (arg6 == arg5) {
                0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u64::mul_div_floor(arg3, 1000000000 - arg4, 1000000000)
            } else {
                arg3
            };
            let v6 = get_delta_up_from_input(arg0, arg1, arg2, arg5);
            let (v2, v4) = if (v6 > (v5 as u256)) {
                if (arg6 == arg5) {
                    v1 = arg3 - v5;
                };
                (v5, get_next_sqrt_price_from_input(arg0, arg2, v5, arg5))
            } else {
                let v7 = (v6 as u64);
                if (arg6 == arg5) {
                    v1 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u64::mul_div_ceil(v7, arg4, 1000000000 - arg4);
                };
                (v7, arg1)
            };
            let v8 = get_delta_down_from_output(arg0, v4, arg2, arg5);
            assert!(v8 <= 18446744073709551615, 13836468101636030475);
            let v9 = (v8 as u64);
            let v3 = v9;
            if (arg6 != arg5) {
                let v10 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u64::mul_div_ceil(v9, arg4, 1000000000);
                v1 = v10;
                v3 = v9 - v10;
            };
            (v2, v3, v4)
        } else {
            let v11 = get_delta_down_from_output(arg0, arg1, arg2, arg5);
            if (arg6 != arg5) {
                let v12 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u64::mul_div_ceil(arg3, arg4, 1000000000 - arg4);
                v1 = v12;
                assert!((v12 as u128) + (arg3 as u128) <= 18446744073709551615, 13836468196125310987);
            };
            let (v3, v4) = if (v11 > ((v1 + arg3) as u256)) {
                let v4 = get_next_sqrt_price_from_output(arg0, arg2, arg3 + v1, arg5);
                (arg3, v4)
            } else {
                if (arg6 != arg5) {
                    v1 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u64::mul_div_ceil((v11 as u64), arg4, 1000000000);
                };
                let v3 = (v11 as u64) - v1;
                (v3, arg1)
            };
            let v13 = get_delta_up_from_input(arg0, v4, arg2, arg5);
            assert!(v13 <= 18446744073709551615, 13836468324974329867);
            let v14 = (v13 as u64);
            if (arg6 == arg5) {
                let v15 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u64::mul_div_ceil(v14, arg4, 1000000000 - arg4);
                v1 = v15;
                assert!((v15 as u128) + (v14 as u128) <= 18446744073709551615, 13836468372218970123);
            };
            (v14, v3, v4)
        };
        (v2, v3, v4, v1)
    }

    public fun get_amount_by_liquidity(arg0: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg1: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg2: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg3: u128, arg4: u128, arg5: bool) : (u64, u64) {
        if (arg4 == 0) {
            return (0, 0)
        };
        assert!(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::lt(arg0, arg1), 13837031502561280015);
        if (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::lt(arg2, arg0)) {
            (get_delta_a(0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::get_sqrt_price_at_tick(arg0), 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::get_sqrt_price_at_tick(arg1), arg4, arg5), 0)
        } else if (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::lt(arg2, arg1)) {
            (get_delta_a(arg3, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::get_sqrt_price_at_tick(arg1), arg4, arg5), get_delta_b(0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::get_sqrt_price_at_tick(arg0), arg3, arg4, arg5))
        } else {
            (0, get_delta_b(0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::get_sqrt_price_at_tick(arg0), 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::get_sqrt_price_at_tick(arg1), arg4, arg5))
        }
    }

    public fun get_delta_a(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        if (v0 == 0 || arg2 == 0) {
            return 0
        };
        let (v1, v2) = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::checked_shlw(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::full_mul(arg2, v0));
        if (v2) {
            abort 13835621743970222085
        };
        let v3 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::div_round(v1, 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::full_mul(arg0, arg1), arg3);
        assert!(v3 <= 18446744073709551615, 13836466186080616459);
        (v3 as u64)
    }

    public fun get_delta_b(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        if (v0 == 0 || arg2 == 0) {
            return 0
        };
        let v1 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::full_mul(arg2, v0);
        if (arg3 && v1 & 18446744073709551615 > 0) {
            assert!((v1 >> 64) + 1 <= 18446744073709551615, 13836466375059177483);
            return (((v1 >> 64) + 1) as u64)
        };
        assert!(v1 >> 64 <= 18446744073709551615, 13836466387944079371);
        ((v1 >> 64) as u64)
    }

    public fun get_delta_down_from_output(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u256 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        if (v0 == 0 || arg2 == 0) {
            return 0
        };
        if (arg3) {
            0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::full_mul(arg2, v0) >> 64
        } else {
            let (v2, v3) = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::checked_shlw(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::full_mul(arg2, v0));
            if (v3) {
                abort 13835623195669168133
            };
            0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::div_round(v2, 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::full_mul(arg0, arg1), false)
        }
    }

    public fun get_delta_up_from_input(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u256 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        if (v0 == 0 || arg2 == 0) {
            return 0
        };
        if (arg3) {
            let (v2, v3) = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::checked_shlw(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::full_mul(arg2, v0));
            if (v3) {
                abort 13835622925086228485
            };
            0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::div_round(v2, 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::full_mul(arg0, arg1), true)
        } else {
            let v4 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::full_mul(arg2, v0);
            if (v4 & 18446744073709551615 > 0) {
                return (v4 >> 64) + 1
            };
            v4 >> 64
        }
    }

    public fun get_liquidity_by_amount(arg0: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg1: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg2: u128, arg3: u64, arg4: bool) : (u128, u64, u64) {
        let v0 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::get_sqrt_price_at_tick(arg0);
        let v1 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::get_sqrt_price_at_tick(arg1);
        let v2 = 0;
        let v3 = 0;
        let v4 = if (arg4) {
            assert!(arg2 < v1, 13837313239531126801);
            let v4 = if (arg2 <= v0) {
                get_liquidity_from_a(v0, v1, arg3, false)
            } else {
                let v5 = get_liquidity_from_a(arg2, v1, arg3, false);
                v3 = get_delta_b(arg2, v0, v5, true);
                v5
            };
            v2 = arg3;
            v4
        } else {
            assert!(arg2 > v0, 13837313286775767057);
            let v4 = if (arg2 >= v1) {
                get_liquidity_from_b(v0, v1, arg3, false)
            } else {
                let v6 = get_liquidity_from_b(v0, arg2, arg3, false);
                v2 = get_delta_a(arg2, v1, v6, true);
                v6
            };
            v3 = arg3;
            v4
        };
        (v4, v2, v3)
    }

    public fun get_liquidity_from_a(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        assert!(arg0 != arg1, 13835902785155366919);
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        assert!(arg0 <= 79226673515401279992447579055, 13835902819515105287);
        assert!(arg1 <= 79226673515401279992447579055, 13835902823810072583);
        let v1 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::div_round(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::full_mul(arg0, arg1) * (arg2 as u256), (v0 as u256) << 64, arg3);
        assert!(v1 <= 340282366920938463463374607431768211455, 13836747261625499661);
        (v1 as u128)
    }

    public fun get_liquidity_from_b(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        assert!(arg0 != arg1, 13835902974133927943);
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        let v1 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::div_round((arg2 as u256) << 64, (v0 as u256), arg3);
        assert!(v1 <= 340282366920938463463374607431768211455, 13836747450604060685);
        (v1 as u128)
    }

    public fun get_next_sqrt_price_a_up(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        if (arg2 == 0) {
            return arg0
        };
        let (v0, v1) = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::checked_shlw(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::full_mul(arg0, arg1));
        if (v1) {
            abort 13835622164877017093
        };
        let v2 = (arg1 as u256) << 64;
        let v3 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::full_mul(arg0, (arg2 as u128));
        let v4 = if (arg3) {
            0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::div_round(v0, v2 + v3, true)
        } else {
            if (v2 <= v3) {
                abort 13836185153485406217
            };
            0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::div_round(v0, v2 - v3, true)
        };
        assert!(v4 >= 4295048016, 13835340745734750211);
        assert!(v4 <= 79226673515401279992447579055, 13835059275052875777);
        (v4 as u128)
    }

    public fun get_next_sqrt_price_b_down(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        let v0 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u128::checked_div_round((arg2 as u128) << 64, arg1, !arg3);
        let v1 = if (arg3) {
            arg0 + v0
        } else {
            if (arg0 < v0) {
                abort 13836185363938803721
            };
            arg0 - v0
        };
        if (v1 > 79226673515401279992447579055) {
            abort 13835059489801240577
        };
        if (v1 < 4295048016) {
            abort 13835340973368016899
        };
        v1
    }

    public fun get_next_sqrt_price_from_input(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        if (arg3) {
            get_next_sqrt_price_a_up(arg0, arg1, arg2, true)
        } else {
            get_next_sqrt_price_b_down(arg0, arg1, arg2, true)
        }
    }

    public fun get_next_sqrt_price_from_output(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        if (arg3) {
            get_next_sqrt_price_b_down(arg0, arg1, arg2, false)
        } else {
            get_next_sqrt_price_a_up(arg0, arg1, arg2, false)
        }
    }

    // decompiled from Move bytecode v6
}

