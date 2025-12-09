module 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::pricing {
    fun base_cost_down(arg0: vector<u64>, arg1: u64, arg2: u8) : u64 {
        assert!(!0x1::vector::is_empty<u64>(&arg0), 1);
        assert!(arg1 != 0, 0);
        let v0 = 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::u64_to_fixed18(arg1, arg2);
        let v1 = 0x1::vector::empty<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>();
        0x1::vector::reverse<u64>(&mut arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg0)) {
            0x1::vector::push_back<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&mut v1, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::u64_to_fixed18(0x1::vector::pop_back<u64>(&mut arg0), arg2));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg0);
        0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::to_u64(0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::mul_down(v0, log_sum_exp_scaled(v1, v0)), arg2)
    }

    fun base_cost_up(arg0: vector<u64>, arg1: u64, arg2: u8) : u64 {
        let v0 = base_cost_down(arg0, arg1, arg2);
        if (v0 == 0) {
            v0
        } else {
            v0 + 1
        }
    }

    public fun cost(arg0: u64, arg1: u64, arg2: vector<u64>, arg3: u64, arg4: u64, arg5: u8) : u64 {
        assert!(arg1 != 0, 2);
        assert!(!0x1::vector::is_empty<u64>(&arg2), 1);
        assert!(arg0 < 0x1::vector::length<u64>(&arg2), 3);
        let v0 = 0;
        let v1 = vector[];
        0x1::vector::reverse<u64>(&mut arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg2)) {
            let v3 = if (v0 == arg0) {
                0x1::vector::pop_back<u64>(&mut arg2) + arg1
            } else {
                0x1::vector::pop_back<u64>(&mut arg2)
            };
            v0 = v0 + 1;
            0x1::vector::push_back<u64>(&mut v1, v3);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg2);
        base_cost_up(v1, effective_liquidity(v1, arg3, arg4), arg5) - base_cost_down(arg2, effective_liquidity(arg2, arg3, arg4), arg5)
    }

    public fun cost_all(arg0: vector<u64>, arg1: u64, arg2: u64, arg3: u64, arg4: u8) : u64 {
        assert!(arg1 != 0, 2);
        assert!(!0x1::vector::is_empty<u64>(&arg0), 1);
        let v0 = vector[];
        0x1::vector::reverse<u64>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x1::vector::push_back<u64>(&mut v0, 0x1::vector::pop_back<u64>(&mut arg0) + arg1);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg0);
        base_cost_up(v0, effective_liquidity(v0, arg2, arg3), arg4) - base_cost_down(arg0, effective_liquidity(arg0, arg2, arg3), arg4)
    }

    public fun effective_liquidity(arg0: vector<u64>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0;
        0x1::vector::reverse<u64>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            v0 = v0 + 0x1::vector::pop_back<u64>(&mut arg0);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg0);
        if (v0 == 0) {
            return arg2
        };
        arg2 + 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_up(v0, arg1, 10000)
    }

    fun log_sum_exp_scaled(arg0: vector<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>, arg1: 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18) : 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18 {
        let v0 = scale_quantities_by_liquidity(arg0, arg1);
        let v1 = *0x1::vector::borrow<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(&v0, 0);
        0x1::vector::reverse<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(&mut v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(&v0)) {
            let v3 = 0x1::vector::pop_back<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(&mut v0);
            if (0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::gt(v3, v1)) {
                v1 = v3;
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(v0);
        let v4 = 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::zero();
        let v5 = &v0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(v5)) {
            v4 = 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::add(v4, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::exp(0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::sub(*0x1::vector::borrow<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(v5, v6), v1)));
            v6 = v6 + 1;
        };
        0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::from_raw_u256(0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::to_u256(0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::add(v1, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::ln(v4))))
    }

    public fun payout(arg0: u64, arg1: u64, arg2: vector<u64>, arg3: u64, arg4: u64, arg5: u8) : u64 {
        assert!(!0x1::vector::is_empty<u64>(&arg2), 1);
        assert!(arg1 != 0, 2);
        assert!(arg0 < 0x1::vector::length<u64>(&arg2), 3);
        assert!(*0x1::vector::borrow<u64>(&arg2, arg0) >= arg1, 2);
        let v0 = 0;
        let v1 = vector[];
        0x1::vector::reverse<u64>(&mut arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg2)) {
            let v3 = if (v0 == arg0) {
                0x1::vector::pop_back<u64>(&mut arg2) - arg1
            } else {
                0x1::vector::pop_back<u64>(&mut arg2)
            };
            v0 = v0 + 1;
            0x1::vector::push_back<u64>(&mut v1, v3);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg2);
        base_cost_down(arg2, effective_liquidity(arg2, arg3, arg4), arg5) - base_cost_up(v1, effective_liquidity(v1, arg3, arg4), arg5)
    }

    public fun price(arg0: u64, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: u8) : u64 {
        assert!(!0x1::vector::is_empty<u64>(&arg1), 1);
        assert!(arg0 < 0x1::vector::length<u64>(&arg1), 3);
        price_internal(arg1, arg0, effective_liquidity(arg1, arg2, arg3), arg4)
    }

    fun price_internal(arg0: vector<u64>, arg1: u64, arg2: u64, arg3: u8) : u64 {
        assert!(arg2 != 0, 0);
        assert!(arg1 < 0x1::vector::length<u64>(&arg0), 3);
        let v0 = 0x1::vector::empty<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>();
        0x1::vector::reverse<u64>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x1::vector::push_back<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&mut v0, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::u64_to_fixed18(0x1::vector::pop_back<u64>(&mut arg0), arg3));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg0);
        let (v2, _) = scaled_exps(v0, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::u64_to_fixed18(arg2, arg3));
        let v4 = v2;
        let v5 = 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::zero();
        0x1::vector::reverse<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&mut v4);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&v4)) {
            v5 = 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::add(v5, 0x1::vector::pop_back<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&mut v4));
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(v4);
        0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::to_u64(0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::div_down(*0x1::vector::borrow<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&v4, arg1), v5), arg3)
    }

    public fun prices(arg0: vector<u64>, arg1: u64, arg2: u64, arg3: u8) : vector<u64> {
        assert!(!0x1::vector::is_empty<u64>(&arg0), 1);
        prices_internal(arg0, effective_liquidity(arg0, arg1, arg2), arg3)
    }

    fun prices_internal(arg0: vector<u64>, arg1: u64, arg2: u8) : vector<u64> {
        assert!(arg1 != 0, 0);
        let v0 = 0x1::vector::empty<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>();
        0x1::vector::reverse<u64>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x1::vector::push_back<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&mut v0, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::u64_to_fixed18(0x1::vector::pop_back<u64>(&mut arg0), arg2));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg0);
        let (v2, _) = scaled_exps(v0, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::u64_to_fixed18(arg1, arg2));
        let v4 = 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::zero();
        let v5 = v2;
        0x1::vector::reverse<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&v5)) {
            v4 = 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::add(v4, 0x1::vector::pop_back<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&mut v5));
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(v5);
        let v7 = 0x1::vector::empty<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>();
        let v8 = v2;
        0x1::vector::reverse<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&mut v8);
        let v9 = 0;
        while (v9 < 0x1::vector::length<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&v8)) {
            0x1::vector::push_back<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&mut v7, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::div_down(0x1::vector::pop_back<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&mut v8), v4));
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(v8);
        let v10 = vector[];
        0x1::vector::reverse<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&mut v7);
        let v11 = 0;
        while (v11 < 0x1::vector::length<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&v7)) {
            0x1::vector::push_back<u64>(&mut v10, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::to_u64(0x1::vector::pop_back<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&mut v7), arg2));
            v11 = v11 + 1;
        };
        0x1::vector::destroy_empty<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(v7);
        v10
    }

    fun scale_quantities_by_liquidity(arg0: vector<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>, arg1: 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18) : vector<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256> {
        let v0 = 0x1::vector::empty<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>();
        0x1::vector::reverse<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&arg0)) {
            let v2 = &mut v0;
            let v3 = 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::div_down(0x1::vector::pop_back<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&mut arg0), arg1);
            assert!(0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::raw_value(v3) <= 3394200909562557497344, 4);
            0x1::vector::push_back<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(v2, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::from_u256(0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::raw_value(v3)));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(arg0);
        v0
    }

    fun scaled_exps(arg0: vector<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>, arg1: 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18) : (vector<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256) {
        let v0 = scale_quantities_by_liquidity(arg0, arg1);
        let v1 = *0x1::vector::borrow<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(&v0, 0);
        0x1::vector::reverse<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(&mut v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(&v0)) {
            let v3 = 0x1::vector::pop_back<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(&mut v0);
            if (0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::gt(v3, v1)) {
                v1 = v3;
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(v0);
        let v4 = 0x1::vector::empty<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>();
        0x1::vector::reverse<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(&mut v0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(&v0)) {
            0x1::vector::push_back<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::Fixed18>(&mut v4, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18::from_raw_u256(0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::to_u256(0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::exp(0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::sub(0x1::vector::pop_back<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(&mut v0), v1)))));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::i256::I256>(v0);
        (v4, v1)
    }

    // decompiled from Move bytecode v6
}

