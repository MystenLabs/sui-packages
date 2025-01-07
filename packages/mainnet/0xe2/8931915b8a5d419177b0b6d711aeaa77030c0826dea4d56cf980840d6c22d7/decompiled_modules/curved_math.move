module 0xe28931915b8a5d419177b0b6d711aeaa77030c0826dea4d56cf980840d6c22d7::curved_math {
    struct CurvedPoolConfig has drop, store {
        scaling_factor: vector<u256>,
        init_A_gamma_time: u64,
        future_A_gamma_time: u64,
        init_amp: u64,
        next_amp: u64,
        init_gamma: u256,
        next_gamma: u256,
        mid_fee: u64,
        out_fee: u64,
        fee_gamma: u64,
        ma_half_time: u256,
        allowed_extra_profit: u256,
        adjustment_step: u256,
        price_scale: vector<u256>,
        oracle_prices: vector<u256>,
        last_prices: vector<u256>,
        last_prices_timestamp: u64,
        _D: u256,
        virtual_price: u256,
        xcp_profit: u256,
        not_adjusted: bool,
    }

    public fun add_liquidity_computation(arg0: &0x2::clock::Clock, arg1: &mut CurvedPoolConfig, arg2: vector<u256>, arg3: vector<u256>, arg4: u256) : (u256, vector<u256>) {
        let v0 = 0x1::vector::length<u256>(&arg2);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        let (v2, v3) = get_cur_A_gamma(arg0, arg1);
        let v4 = 0;
        let v5 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::create_zero_vector_u256(v0);
        let v6 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::add_vectors_u256(arg2, arg3);
        let v7 = v0;
        let v8 = 0;
        while (v8 < v0) {
            let v9 = *0x1::vector::borrow<u256>(&arg1.price_scale, v8);
            *0x1::vector::borrow_mut<u256>(&mut arg2, v8) = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg2, v8), v9, 1000000000000000000);
            *0x1::vector::borrow_mut<u256>(&mut v6, v8) = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&v6, v8), v9, 1000000000000000000);
            if (*0x1::vector::borrow<u256>(&arg3, v8) > 0) {
                if (v7 == v0) {
                    v7 = v8;
                } else {
                    v7 = v0 + 1;
                };
            };
            v8 = v8 + 1;
        };
        let v10 = if (arg1.future_A_gamma_time > v1) {
            solve_D(v3, (v2 as u256), arg2)
        } else {
            arg1._D
        };
        let v11 = solve_D(v3, (v2 as u256), v6);
        if (v10 == 0) {
            v4 = get_xcp(v11, arg1.price_scale, (v0 as u256));
        };
        if (v10 > 0) {
            let v12 = 0;
            while (v12 < v0) {
                *0x1::vector::borrow_mut<u256>(&mut v5, v12) = calculate_fee_charged(*0x1::vector::borrow<u256>(&arg2, v12), *0x1::vector::borrow<u256>(&v6, v12), v10, v11, *0x1::vector::borrow<u256>(&arg1.price_scale, v12), 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(fee(v6, arg1.mid_fee, arg1.out_fee, (arg1.fee_gamma as u256)), (v0 as u256), 4 * ((v0 as u256) - 1)));
                v12 = v12 + 1;
            };
            let v13 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg4, solve_D(v3, (v2 as u256), xp(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::subtract_vectors_u256(v6, v5), arg1.price_scale)), v10) - arg4;
            v4 = v13;
            let v14 = arg4 + v13;
            let v15 = 0;
            if (v13 > 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(5) && v7 < v0) {
                let v16 = 0;
                let v17 = 0;
                while (v17 < v0) {
                    if (v17 != v7) {
                        v16 = v16 + 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&v6, v17), *0x1::vector::borrow<u256>(&arg1.last_prices, v17), 1000000000000000000);
                    };
                    v17 = v17 + 1;
                };
                v15 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v16, v13, v14), 1000000000000000000, *0x1::vector::borrow<u256>(&arg3, v7) - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v13, *0x1::vector::borrow<u256>(&v6, v7), v14));
            };
            let v18 = arg1.last_prices_timestamp;
            let v19 = arg1.last_prices;
            tweak_price(arg1, v3, (v2 as u256), v6, v7, v15, v11, v14, v18, v1, v19);
        } else {
            arg1._D = v11;
            arg1.virtual_price = 1000000000000000000;
            arg1.xcp_profit = 1000000000000000000;
        };
        assert!(v4 > 0, 5022);
        (v4, v5)
    }

    public fun assert_new_config_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        if (arg0 > 0) {
            assert!(1000000 <= arg0 && arg0 <= 100000000, 5023);
        };
        if (arg1 > 0) {
            assert!(1000000 <= arg1 && arg1 <= 100000000, 5025);
        };
        if (arg2 > 0) {
            assert!(5000000000000 <= arg2 && arg2 <= 100000000000000000, 5026);
        };
        if (arg4 > 0) {
            assert!(10000000000 <= (arg4 as u256) && (arg4 as u256) <= 1000000000000000, 5027);
        };
        if (arg5 > 0) {
            assert!(10000000000 <= (arg5 as u256) && (arg5 as u256) <= 1000000000000000, 5028);
        };
        if (arg3 > 0) {
            assert!(30000 <= arg3 && arg3 <= 3600000, 5024);
        };
    }

    public fun calc_geometric_mean(arg0: vector<u256>, arg1: bool) : u256 {
        let v0 = 0x1::vector::length<u256>(&arg0);
        let v1 = arg0;
        if (arg1) {
            let v2 = v1;
            v1 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::sort_u256(v2);
        };
        let v3 = *0x1::vector::borrow<u256>(&v1, 0);
        let v4 = 0;
        while (v4 < 255) {
            let v5 = v3;
            let v6 = 1000000000000000000;
            let v7 = 0;
            while (v7 < v0) {
                v6 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v6, *0x1::vector::borrow<u256>(&v1, v7), v3);
                v7 = v7 + 1;
            };
            v3 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v3, ((v0 - 1) as u256) * 1000000000000000000 + v6, (v0 as u256) * 1000000000000000000);
            let v8 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::subtract_mod_u256(v3, v5);
            if (v8 <= 1 || v8 * 1000000000000000000 < v3) {
                return v3
            };
            v4 = v4 + 1;
        };
        abort 5001
    }

    public fun calc_withdraw_one_coin(arg0: &0x2::clock::Clock, arg1: &mut CurvedPoolConfig, arg2: vector<u256>, arg3: u256, arg4: u64, arg5: u256, arg6: bool, arg7: bool) : u256 {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x1::vector::length<u256>(&arg2);
        let (v2, v3) = get_cur_A_gamma(arg0, arg1);
        if (arg1.future_A_gamma_time > v0) {
            arg6 = true;
        };
        let v4 = 0;
        let v5 = 0;
        while (v5 < v1) {
            let v6 = *0x1::vector::borrow<u256>(&arg1.price_scale, v5);
            *0x1::vector::borrow_mut<u256>(&mut arg2, v5) = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg2, v5), v6, 1000000000000000000);
            if (v5 == arg4) {
                v4 = v6;
            };
            v5 = v5 + 1;
        };
        let v7 = if (arg6) {
            solve_D(v3, (v2 as u256), arg2)
        } else {
            arg1._D
        };
        let v8 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg5, v7, arg3);
        let v9 = v7 - v8 - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v8, fee(arg2, arg1.mid_fee, arg1.out_fee, (arg1.fee_gamma as u256)), ((2 * 10000000000) as u256)) + 1;
        let v10 = newton_y((v3 as u256), (v2 as u256), arg2, v9, arg4);
        let v11 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg2, arg4) - v10, 1000000000000000000, v4);
        *0x1::vector::borrow_mut<u256>(&mut arg2, arg4) = v10;
        let v12 = 0;
        if (arg7 && v11 > 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(5) && arg5 > 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(5)) {
            let v13 = 0;
            let v14 = 0;
            while (v14 < v1) {
                if (v14 != arg4) {
                    v13 = v13 + 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg2, v14), *0x1::vector::borrow<u256>(&arg1.last_prices, v14), 1000000000000000000);
                };
                v14 = v14 + 1;
            };
            v12 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v13, v8, v7), 1000000000000000000, v11 - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v8, *0x1::vector::borrow<u256>(&arg2, arg4), v7));
        };
        let v15 = arg1.last_prices_timestamp;
        let v16 = arg1.last_prices;
        tweak_price(arg1, v3, (v2 as u256), arg2, (arg4 as u64), v12, v9, arg3 - arg5, v15, v0, v16);
        v11
    }

    public fun calculate_fee_charged(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : u256 {
        0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::subtract_mod_u256(arg1, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg3, arg0, arg2)), 1000000000000000000, arg4), arg5, (10000000000 as u256))
    }

    public fun compute_ask_amount(arg0: &0x2::clock::Clock, arg1: &mut CurvedPoolConfig, arg2: u64, arg3: u64, arg4: u256, arg5: vector<u256>, arg6: u256) : (u256, u256) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        0x1::vector::length<u256>(&arg5);
        let (v1, v2) = get_cur_A_gamma(arg0, arg1);
        let v3 = arg3;
        let v4 = arg5;
        *0x1::vector::borrow_mut<u256>(&mut v4, arg2) = *0x1::vector::borrow<u256>(&arg5, arg2) + arg4;
        let v5 = v4;
        v4 = xp(v5, arg1.price_scale);
        if (arg1.init_A_gamma_time < v0 && arg1.future_A_gamma_time > v0) {
            *0x1::vector::borrow_mut<u256>(&mut v4, arg2) = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg5, arg2), *0x1::vector::borrow<u256>(&arg1.price_scale, arg2), 1000000000000000000);
            arg1._D = solve_D(v2, (v1 as u256), v4);
            *0x1::vector::borrow_mut<u256>(&mut v4, arg2) = *0x1::vector::borrow<u256>(&v4, arg2);
        };
        let v6 = *0x1::vector::borrow_mut<u256>(&mut v4, arg3) - newton_y((v2 as u256), (v1 as u256), v4, (arg1._D as u256), arg3);
        *0x1::vector::borrow_mut<u256>(&mut v4, arg3) = *0x1::vector::borrow<u256>(&v4, arg3) - v6;
        let v7 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v6 - 1, 1000000000000000000, *0x1::vector::borrow<u256>(&arg1.price_scale, arg3));
        let v8 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(fee(v4, arg1.mid_fee, arg1.out_fee, (arg1.fee_gamma as u256)), v7, (10000000000 as u256));
        *0x1::vector::borrow_mut<u256>(&mut v4, arg3) = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg5, arg3) - v7 - v8, *0x1::vector::borrow<u256>(&arg1.price_scale, arg3), 1000000000000000000);
        let v9 = 0;
        if (arg4 > 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(5) && v7 > 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(5)) {
            if (arg2 != 0 && arg3 != 0) {
                v9 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg4, *0x1::vector::borrow<u256>(&arg1.last_prices, arg2), v7);
            } else if (arg2 == 0) {
                v9 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg4, 1000000000000000000, v7);
            } else {
                v9 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v7, 1000000000000000000, arg4);
                v3 = arg2;
            };
        };
        let v10 = arg1.last_prices_timestamp;
        let v11 = arg1.last_prices;
        let v12 = arg1._D;
        tweak_price(arg1, v2, (v1 as u256), v4, v3, v9, v12, arg6, v10, v0, v11);
        (v7, v8)
    }

    public fun compute_offer_amount(arg0: &0x2::clock::Clock, arg1: &mut CurvedPoolConfig, arg2: u64, arg3: u64, arg4: u256, arg5: vector<u256>, arg6: u256) : (u256, u256) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        0x1::vector::length<u256>(&arg5);
        let (v1, v2) = get_cur_A_gamma(arg0, arg1);
        let v3 = arg2;
        let v4 = arg5;
        let v5 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg4, (10000000000 as u256), (10000000000 as u256) - fee(xp(arg5, arg1.price_scale), arg1.mid_fee, arg1.out_fee, (arg1.fee_gamma as u256)));
        *0x1::vector::borrow_mut<u256>(&mut v4, arg3) = *0x1::vector::borrow<u256>(&arg5, arg3) - v5;
        let v6 = v4;
        v4 = xp(v6, arg1.price_scale);
        if (arg1.init_A_gamma_time < v0 && arg1.future_A_gamma_time > v0) {
            *0x1::vector::borrow_mut<u256>(&mut v4, arg3) = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg5, arg3), *0x1::vector::borrow<u256>(&arg1.price_scale, arg3), 1000000000000000000);
            arg1._D = solve_D(v2, (v1 as u256), v4);
            *0x1::vector::borrow_mut<u256>(&mut v4, arg3) = *0x1::vector::borrow<u256>(&v4, arg3);
        };
        let v7 = newton_y((v2 as u256), (v1 as u256), v4, (arg1._D as u256), arg2) - *0x1::vector::borrow_mut<u256>(&mut v4, arg2);
        *0x1::vector::borrow_mut<u256>(&mut v4, arg2) = *0x1::vector::borrow<u256>(&v4, arg2) + v7;
        let v8 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v7 + 1, 1000000000000000000, *0x1::vector::borrow<u256>(&arg1.price_scale, arg2));
        *0x1::vector::borrow_mut<u256>(&mut v4, arg2) = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg5, arg2) + v8, *0x1::vector::borrow<u256>(&arg1.price_scale, arg2), 1000000000000000000);
        let v9 = 0;
        if (v5 > 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(5) && v8 > 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(5)) {
            if (arg2 != 0 && arg3 != 0) {
                v9 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v5, *0x1::vector::borrow<u256>(&arg1.last_prices, arg3), v8);
            } else if (arg3 == 0) {
                v9 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v5, 1000000000000000000, v8);
            } else {
                v9 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v8, 1000000000000000000, v5);
                v3 = arg3;
            };
        };
        let v10 = arg1.last_prices_timestamp;
        let v11 = arg1.last_prices;
        let v12 = arg1._D;
        tweak_price(arg1, v2, (v1 as u256), v4, v3, v9, v12, arg6, v10, v0, v11);
        (v8, v5 - arg4)
    }

    fun ema_recorder(arg0: &mut CurvedPoolConfig, arg1: u256, arg2: u256, arg3: vector<u256>, arg4: u64) {
        let v0 = 0x1::vector::empty<u256>();
        if (arg2 > arg1) {
            let v1 = arg0.oracle_prices;
            let v2 = halfpow(arg2 - arg1, arg0.ma_half_time, (10000000000 as u256));
            let v3 = 0;
            while (v3 < arg4) {
                0x1::vector::push_back<u256>(&mut v0, (*0x1::vector::borrow<u256>(&arg3, v3) * (1000000000000000000 - v2) + *0x1::vector::borrow<u256>(&v1, v3) * v2) / 1000000000000000000);
                v3 = v3 + 1;
            };
            arg0.oracle_prices = v0;
            arg0.last_prices_timestamp = (arg2 as u64);
        };
    }

    public fun fee(arg0: vector<u256>, arg1: u64, arg2: u64, arg3: u256) : u256 {
        let v0 = reduction_coefficient(arg0, arg3);
        ((arg1 as u256) * v0 + (arg2 as u256) * (1000000000000000000 - v0)) / 1000000000000000000
    }

    public fun get_cur_A_gamma(arg0: &0x2::clock::Clock, arg1: &CurvedPoolConfig) : (u256, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = arg1.future_A_gamma_time;
        let v2 = arg1.next_gamma;
        let v3 = arg1.next_amp;
        if (arg1.init_A_gamma_time < v0 && v0 < v1) {
            let v6 = arg1.init_A_gamma_time;
            let v7 = arg1.init_gamma;
            let v8 = arg1.init_amp;
            let v9 = v0 - v6;
            let v10 = v1 - v6;
            let v11 = if (v2 > v7) {
                v7 + 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::max_u256(v2, v7) - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::min_u256(v2, v7), (v9 as u256), (v10 as u256))
            } else {
                v7 - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::max_u256(v2, v7) - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::min_u256(v2, v7), (v9 as u256), (v10 as u256))
            };
            let v12 = if (v3 > v8) {
                v8 + 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::max_u64(v3, v8) - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::min_u64(v3, v8), v9, v10)
            } else {
                v8 - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::max_u64(v3, v8) - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::min_u64(v3, v8), v9, v10)
            };
            (v11, v12)
        } else {
            (v2, v3)
        }
    }

    public fun get_curved_config_amp_gamma_params(arg0: &CurvedPoolConfig) : (u64, u64, u64, u64, u256, u256) {
        (arg0.init_A_gamma_time, arg0.future_A_gamma_time, arg0.init_amp, arg0.next_amp, arg0.init_gamma, arg0.next_gamma)
    }

    public fun get_curved_config_fee_params(arg0: &CurvedPoolConfig) : (u64, u64, u64, u256, u256, u256) {
        (arg0.mid_fee, arg0.out_fee, arg0.fee_gamma, arg0.ma_half_time, arg0.allowed_extra_profit, arg0.adjustment_step)
    }

    public fun get_curved_config_prices_info(arg0: &CurvedPoolConfig) : (vector<u256>, vector<u256>, vector<u256>, u64) {
        (arg0.price_scale, arg0.oracle_prices, arg0.last_prices, arg0.last_prices_timestamp)
    }

    public fun get_curved_config_scaling_factor(arg0: &CurvedPoolConfig) : vector<u256> {
        arg0.scaling_factor
    }

    public fun get_curved_config_xcp_params(arg0: &CurvedPoolConfig) : (u256, u256, u256, bool) {
        (arg0._D, arg0.virtual_price, arg0.xcp_profit, arg0.not_adjusted)
    }

    public fun get_dx(arg0: vector<u256>, arg1: vector<u256>, arg2: u64, arg3: u256, arg4: u64, arg5: u64, arg6: u256, arg7: u256, arg8: u64, arg9: u64, arg10: u256) : (u256, u256) {
        let v0 = arg0;
        let v1 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg10, (10000000000 as u256), (10000000000 as u256) - fee(xp(arg0, arg1), arg4, arg5, arg6));
        *0x1::vector::borrow_mut<u256>(&mut v0, arg9) = *0x1::vector::borrow<u256>(&arg0, arg9) - v1;
        let v2 = v0;
        v0 = xp(v2, arg1);
        let v3 = newton_y((arg2 as u256), (arg3 as u256), v0, arg7, arg8) - *0x1::vector::borrow_mut<u256>(&mut v0, arg8);
        *0x1::vector::borrow_mut<u256>(&mut v0, arg8) = *0x1::vector::borrow<u256>(&v0, arg8) + v3;
        (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v3 + 1, 1000000000000000000, *0x1::vector::borrow<u256>(&arg1, arg8)), v1 - arg10)
    }

    public fun get_dy(arg0: vector<u256>, arg1: vector<u256>, arg2: u64, arg3: u256, arg4: u64, arg5: u64, arg6: u256, arg7: u256, arg8: u256, arg9: u64, arg10: u64) : (u256, u256) {
        *0x1::vector::borrow_mut<u256>(&mut arg0, arg9) = *0x1::vector::borrow<u256>(&arg0, arg9) + arg8;
        let v0 = xp(arg0, arg1);
        let v1 = newton_y((arg2 as u256), (arg3 as u256), v0, arg7, arg10);
        let v2 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&v0, arg10) - v1 - 1, 1000000000000000000, *0x1::vector::borrow<u256>(&arg1, arg10));
        *0x1::vector::borrow_mut<u256>(&mut v0, arg10) = v1;
        (v2, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(fee(v0, arg4, arg5, arg6), v2, (10000000000 as u256)))
    }

    fun get_max_amp(arg0: u64) : u64 {
        arg0 * arg0 * 10000 * 1000
    }

    fun get_min_amp(arg0: u64) : u64 {
        arg0 * arg0 * 10000 / 100
    }

    public fun get_xcp(arg0: u256, arg1: vector<u256>, arg2: u256) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        while (v1 < (arg2 as u64)) {
            0x1::vector::push_back<u256>(&mut v0, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg0, 1000000000000000000, arg2 * *0x1::vector::borrow<u256>(&arg1, v1)));
            v1 = v1 + 1;
        };
        calc_geometric_mean(v0, true)
    }

    public fun halfpow(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = (arg0 as u256) * 1000000000000000000 / (arg1 as u256);
        let v1 = v0 / 1000000000000000000;
        let v2 = v0 % 1000000000000000000;
        if (v1 > 59) {
            return 0
        };
        if (v2 == 0) {
            return 1000000000000000000 / 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_u256(2, (v1 as u128))
        } else {
            let v3 = 1000000000000000000;
            let v4 = v3;
            let v5 = v3;
            let v6 = false;
            let v7 = 1;
            while (v7 < 256) {
                let v8 = v7 * 1000000000000000000;
                let v9 = v8 - 1000000000000000000;
                let v10 = if (v2 > v9) {
                    v6 = !v6;
                    v2 - v9
                } else {
                    v9 - v2
                };
                v4 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v4, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v10, 5 * 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(17), 1000000000000000000), v8);
                if (v6) {
                    v5 = v5 - v4;
                } else {
                    v5 = v5 + v4;
                };
                if (v4 < arg2) {
                    return 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v5, 1000000000000000000 / 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_u256(2, (v1 as u128)), 1000000000000000000)
                };
                v7 = v7 + 1;
            };
            abort 5001
        };
    }

    public fun initialize_curved_config(arg0: &0x2::clock::Clock, arg1: vector<u64>, arg2: vector<u256>, arg3: vector<u256>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : CurvedPoolConfig {
        assert!(0x1::vector::length<u64>(&arg1) == 8, 5003);
        assert!(0x1::vector::length<u256>(&arg2) == (arg4 as u64), 5003);
        assert!(*0x1::vector::borrow<u256>(&arg2, 0) == 1000000000000000000, 5019);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = *0x1::vector::borrow<u64>(&arg1, 0) * 10000;
        let v2 = (*0x1::vector::borrow<u64>(&arg1, 1) as u256);
        let v3 = *0x1::vector::borrow<u64>(&arg1, 2);
        let v4 = *0x1::vector::borrow<u64>(&arg1, 3);
        let v5 = (*0x1::vector::borrow<u64>(&arg1, 4) as u256);
        let v6 = *0x1::vector::borrow<u64>(&arg1, 5);
        let v7 = (*0x1::vector::borrow<u64>(&arg1, 6) as u256);
        let v8 = *0x1::vector::borrow<u64>(&arg1, 7);
        assert!((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow(arg4, arg4) as u64) * 10000 / 100 <= v1 && v1 <= (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow(arg4, arg4) as u64) * 10000 * 1000, 5016);
        assert!(10000000000 <= v2 && v2 <= 500000000000000000, 5020);
        assert!(30000 <= v8 && v8 <= 3600000, 5024);
        assert!(1000000 <= v3 && v3 <= 100000000, 5023);
        assert!(1000000 <= v4 && v4 <= 100000000, 5025);
        assert!(5000000000000 <= v6 && v6 <= 100000000000000000, 5026);
        assert!(10000000000 <= v5 && v5 <= 1000000000000000, 5027);
        assert!(10000000000 <= v7 && v7 <= 1000000000000000, 5028);
        CurvedPoolConfig{
            scaling_factor        : arg3,
            init_A_gamma_time     : v0,
            future_A_gamma_time   : v0,
            init_amp              : v1,
            next_amp              : v1,
            init_gamma            : v2,
            next_gamma            : v2,
            mid_fee               : v3,
            out_fee               : v4,
            fee_gamma             : v6,
            ma_half_time          : (v8 as u256),
            allowed_extra_profit  : v5,
            adjustment_step       : v7,
            price_scale           : arg2,
            oracle_prices         : arg2,
            last_prices           : arg2,
            last_prices_timestamp : v0,
            _D                    : 0,
            virtual_price         : 0,
            xcp_profit            : 0,
            not_adjusted          : true,
        }
    }

    fun newton_D(arg0: u64, arg1: u256, arg2: vector<u256>, arg3: u256) : u256 {
        let v0 = 0x1::vector::length<u256>(&arg2);
        assert!(arg0 > get_min_amp(v0) - 1 && arg0 < get_max_amp(v0) + 1, 5006);
        assert!(arg1 > 10000000000 - 1 && arg1 < 500000000000000000 + 1, 5007);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u256>(&arg2)) {
            v1 = v1 + *0x1::vector::borrow<u256>(&arg2, v2);
            v2 = v2 + 1;
        };
        let v3 = 0;
        while (v3 < 255) {
            let v4 = arg3;
            let v5 = 1000000000000000000;
            let v6 = 0;
            while (v6 < v0) {
                v5 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v5, *0x1::vector::borrow<u256>(&arg2, v6) * (v0 as u256), arg3);
                v6 = v6 + 1;
            };
            let v7 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::subtract_mod_u256(arg1 + 1000000000000000000, v5) + 1;
            let v8 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(1000000000000000000, arg3, arg1), v7, arg1), v7 * (10000 as u256), (arg0 as u256));
            let v9 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(2 * 1000000000000000000 * (v0 as u256), v5, v7);
            let v10 = v1 + v1 * v9 / 1000000000000000000 + 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v8, (v0 as u256), v5) - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v9, arg3, 1000000000000000000);
            assert!(v10 > 0, 5021);
            let v11 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg3, v10 + v1, v10);
            let v12 = if (1000000000000000000 > v5) {
                0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg3, arg3, v10) + 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg3, v8 / v10, 1000000000000000000), 1000000000000000000 - v5, v5)
            } else {
                0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg3, arg3, v10) - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg3, v8 / v10, 1000000000000000000), v5 - 1000000000000000000, v5)
            };
            if (v11 > v12) {
                arg3 = v11 - v12;
            } else {
                arg3 = (v12 - v11) / 2;
            };
            if (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::subtract_mod_u256(arg3, v4) * 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(14) <= 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::max_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(16), arg3)) {
                let v13 = 0;
                while (v13 < v0) {
                    let v14 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg2, v13), 1000000000000000000, arg3);
                    assert!(v14 > 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(16) - 1 && v14 < 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(20) + 1, 5005);
                    v13 = v13 + 1;
                };
                return arg3
            };
            v3 = v3 + 1;
        };
        abort 5001
    }

    public fun newton_y(arg0: u256, arg1: u256, arg2: vector<u256>, arg3: u256, arg4: u64) : u256 {
        let v0 = 0x1::vector::length<u256>(&arg2);
        assert!((arg0 as u64) > get_min_amp(v0) - 1 && (arg0 as u64) < get_max_amp(v0) + 1, 5006);
        assert!(arg1 > 10000000000 - 1 && arg1 < 500000000000000000 + 1, 5007);
        assert!(arg3 > 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(17) - 1 && arg3 < 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(15) * 1000000000000000000 + 1, 5007);
        let v1 = 0;
        while (v1 < v0) {
            if (v1 != arg4) {
                let v2 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg2, v1), 1000000000000000000, arg3);
                assert!(v2 > 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(16) - 1 && v2 < 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(20) + 1, 5005);
            };
            v1 = v1 + 1;
        };
        let v3 = arg3 / (v0 as u256);
        let v4 = 1000000000000000000;
        let v5 = 0;
        *0x1::vector::borrow_mut<u256>(&mut arg2, (arg4 as u64)) = 0;
        let v6 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::sort_u256(arg2);
        0x1::vector::pop_back<u256>(&mut v6);
        let v7 = v0 - 2;
        while (v7 <= v0 - 2) {
            let v8 = *0x1::vector::borrow<u256>(&v6, v7);
            v3 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v3, arg3, v8 * (v0 as u256));
            v5 = v5 + v8;
            if (v7 == 0) {
                break
            };
            v7 = v7 - 1;
        };
        v7 = 0;
        while (v7 < v0 - 1) {
            v4 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v4, *0x1::vector::borrow<u256>(&v6, v7) * (v0 as u256), arg3);
            v7 = v7 + 1;
        };
        v7 = 0;
        while (v7 < 256) {
            let v9 = v3;
            let v10 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v4, v3 * (v0 as u256), arg3);
            let v11 = v5 + v3;
            let v12 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::subtract_mod_u256(arg1 + 1000000000000000000, v10) + 1;
            let v13 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(1000000000000000000, arg3, arg1), v12, arg1), v12 * (10000 as u256), arg0);
            let v14 = 1000000000000000000 + 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v10, 2 * 1000000000000000000, v12);
            let v15 = v3 * 1000000000000000000 + v11 * v14 + v13;
            let v16 = arg3 * v14;
            if (v15 < v16) {
                v3 = v3 / 2;
                continue
            };
            let v17 = v15 - v16;
            let v18 = v17 / v3;
            let v19 = v13 / v18;
            let v20 = (v17 + arg3 * 1000000000000000000) / v18 + 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v19, 1000000000000000000, v10);
            let v21 = v19 + 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v11, 1000000000000000000, v18);
            if (v20 < v21) {
                v3 = v3 / 2;
            } else {
                v3 = v20 - v21;
            };
            if (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::subtract_mod_u256(v3, v9) < 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::max_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::max_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::max_u256(*0x1::vector::borrow<u256>(&v6, 0) / 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(14), arg3 / 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(14)), 100), v3 / 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(14))) {
                let v22 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v3, 1000000000000000000, arg3);
                assert!(v22 > 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(16) - 1 && v22 < 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(20) + 1, 5005);
                return v3
            };
            v7 = v7 + 1;
        };
        abort 5001
    }

    public fun query_ask_amount(arg0: &0x2::clock::Clock, arg1: &CurvedPoolConfig, arg2: vector<u256>, arg3: u256, arg4: u64, arg5: u64) : (u256, u256) {
        let (v0, v1) = get_cur_A_gamma(arg0, arg1);
        get_dy(arg2, arg1.price_scale, v1, v0, arg1.mid_fee, arg1.out_fee, (arg1.fee_gamma as u256), arg1._D, arg3, arg4, arg5)
    }

    public fun query_offer_amount(arg0: &0x2::clock::Clock, arg1: &CurvedPoolConfig, arg2: vector<u256>, arg3: u256, arg4: u64, arg5: u64) : (u256, u256) {
        let (v0, v1) = get_cur_A_gamma(arg0, arg1);
        get_dx(arg2, arg1.price_scale, v1, v0, arg1.mid_fee, arg1.out_fee, (arg1.fee_gamma as u256), arg1._D, arg4, arg5, arg3)
    }

    public fun reduce_d(arg0: &mut CurvedPoolConfig, arg1: u256, arg2: u256) {
        arg0._D = arg0._D - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg0._D, arg1, arg2);
    }

    public fun reduction_coefficient(arg0: vector<u256>, arg1: u256) : u256 {
        let v0 = 0x1::vector::length<u256>(&arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u256>(&arg0, v2);
            v2 = v2 + 1;
        };
        let v3 = 1000000000000000000;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = v3 * (v0 as u256);
            v3 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v5, *0x1::vector::borrow<u256>(&arg0, v4), v1);
            v4 = v4 + 1;
        };
        if (arg1 > 0) {
            let v6 = arg1 + 1000000000000000000 - v3;
            v3 = arg1 * 1000000000000000000 / v6;
        };
        v3
    }

    public fun solve_D(arg0: u64, arg1: u256, arg2: vector<u256>) : u256 {
        let v0 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::sort_u256(arg2);
        let v1 = *0x1::vector::borrow<u256>(&v0, 0);
        assert!(v1 > 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(9) - 1 && v1 < 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10_u256(15) * 1000000000000000000 + 1, 5005);
        newton_D(arg0, arg1, v0, (0x1::vector::length<u256>(&arg2) as u256) * calc_geometric_mean(v0, false))
    }

    fun tweak_price(arg0: &mut CurvedPoolConfig, arg1: u64, arg2: u256, arg3: vector<u256>, arg4: u64, arg5: u256, arg6: u256, arg7: u256, arg8: u64, arg9: u64, arg10: vector<u256>) {
        let v0 = 0x1::vector::length<u256>(&arg0.last_prices);
        ema_recorder(arg0, (arg8 as u256), (arg9 as u256), arg10, v0);
        let v1 = arg6;
        if (arg6 == 0) {
            v1 = solve_D(arg1, arg2, arg3);
        };
        if (arg5 > 0) {
            if (arg4 > 0) {
                *0x1::vector::borrow_mut<u256>(&mut arg0.last_prices, arg4) = arg5;
            } else {
                let v2 = 1;
                while (v2 < v0) {
                    *0x1::vector::borrow_mut<u256>(&mut arg0.last_prices, v2) = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg0.last_prices, v2), 1000000000000000000, arg5);
                    v2 = v2 + 1;
                };
            };
        } else {
            let v3 = *0x1::vector::borrow<u256>(&arg3, 0) / (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow_10(6) as u256);
            *0x1::vector::borrow_mut<u256>(&mut arg3, 0) = *0x1::vector::borrow<u256>(&arg3, 0) + v3;
            let v4 = 1;
            while (v4 < v0) {
                *0x1::vector::borrow_mut<u256>(&mut arg0.last_prices, v4) = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg0.price_scale, v4), v3, *0x1::vector::borrow<u256>(&arg3, v4) - newton_y((arg1 as u256), arg2, arg3, v1, v4));
                v4 = v4 + 1;
            };
        };
        let v5 = arg0.virtual_price;
        let v6 = 0x1::vector::empty<u256>();
        let v7 = 0;
        while (v7 < v0) {
            0x1::vector::push_back<u256>(&mut v6, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v1, 1000000000000000000, *0x1::vector::borrow<u256>(&arg0.price_scale, v7) * (v0 as u256)));
            v7 = v7 + 1;
        };
        let v8 = 1000000000000000000;
        let v9 = 1000000000000000000;
        if (v5 > 0) {
            let v10 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(1000000000000000000, calc_geometric_mean(v6, true), arg7);
            v9 = v10;
            v8 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg0.xcp_profit, v10, v5);
            let v11 = v10 < v5 && arg0.future_A_gamma_time < arg9;
            assert!(!v11, 5029);
        };
        arg0.xcp_profit = v8;
        let v12 = arg0.not_adjusted;
        let v13 = v12;
        if (!v12 && v9 * 2 - 1000000000000000000 > v8 + 2 * arg0.allowed_extra_profit) {
            v13 = true;
            arg0.not_adjusted = true;
        };
        if (v13) {
            let v14 = arg0.adjustment_step;
            let v15 = 0;
            let v16 = 1;
            while (v16 < v0) {
                let v17 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::subtract_mod_u256(0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg0.oracle_prices, v16), 1000000000000000000, *0x1::vector::borrow<u256>(&arg0.price_scale, v16)), 1000000000000000000);
                v15 = v15 + v17 * v17;
                v16 = v16 + 1;
            };
            if (v15 > v14 * v14 && v5 > 0) {
                let v18 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::sqrt_int_u256(v15 / 1000000000000000000);
                let v19 = 0x1::vector::empty<u256>();
                0x1::vector::push_back<u256>(&mut v19, 1000000000000000000);
                let v20 = 1;
                while (v20 < v0) {
                    0x1::vector::push_back<u256>(&mut v19, (*0x1::vector::borrow<u256>(&arg0.price_scale, v20) * (v18 - v14) + v14 * *0x1::vector::borrow<u256>(&arg0.oracle_prices, v20)) / v18);
                    v20 = v20 + 1;
                };
                v20 = 1;
                while (v20 < v0) {
                    *0x1::vector::borrow_mut<u256>(&mut arg3, v20) = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg3, v20), *0x1::vector::borrow<u256>(&v19, v20), *0x1::vector::borrow<u256>(&arg0.price_scale, v20));
                    v20 = v20 + 1;
                };
                let v21 = solve_D(arg1, arg2, arg3);
                v20 = 0;
                while (v20 < v0) {
                    *0x1::vector::borrow_mut<u256>(&mut arg3, v20) = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v21, 1000000000000000000, *0x1::vector::borrow<u256>(&v19, v20) * (v0 as u256));
                    v20 = v20 + 1;
                };
                let v22 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(calc_geometric_mean(arg3, true), 1000000000000000000, arg7);
                if (v22 > 1000000000000000000 && 2 * v22 - 1000000000000000000 > v8) {
                    arg0.price_scale = v19;
                    arg0._D = v21;
                    arg0.virtual_price = v22;
                    return
                };
                arg0.not_adjusted = false;
            };
        };
        arg0._D = v1;
        arg0.virtual_price = v9;
    }

    public fun update_A_and_gamma(arg0: &mut CurvedPoolConfig, arg1: u64, arg2: u64, arg3: u256, arg4: u64) {
        let v0 = (0x1::vector::length<u256>(&arg0.last_prices) as u128);
        let v1 = (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::pow(v0, v0) as u64);
        assert!(v1 * 10000 / 100 < arg2 && arg2 < v1 * 10000 * 1000, 5016);
        assert!(arg3 >= 10000000000 && arg3 <= 500000000000000000 + 1, 5020);
        assert!(arg2 >= arg0.init_amp && arg2 <= arg0.init_amp * 10 || arg2 < arg0.init_amp && arg2 * 10 >= arg0.init_amp, 5018);
        assert!(arg4 > arg1 && arg4 - arg1 > 86400000, 5017);
        arg0.init_A_gamma_time = arg1;
        arg0.next_amp = arg2;
        arg0.next_gamma = arg3;
        arg0.future_A_gamma_time = arg4;
    }

    public fun update_config_fee_params(arg0: &mut CurvedPoolConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        if (arg1 > 0) {
            assert!(1000000 <= arg1 && arg1 <= 100000000, 5023);
            arg0.mid_fee = arg1;
        };
        if (arg2 > 0) {
            assert!(1000000 <= arg2 && arg2 <= 100000000, 5025);
            arg0.out_fee = arg2;
        };
        assert!(arg0.mid_fee <= arg0.out_fee, 5012);
        if (arg3 > 0) {
            assert!(5000000000000 <= arg3 && arg3 <= 100000000000000000, 5026);
            arg0.fee_gamma = arg3;
        };
        if (arg5 > 0) {
            assert!(10000000000 <= (arg5 as u256) && (arg5 as u256) <= 1000000000000000, 5027);
            arg0.allowed_extra_profit = (arg5 as u256);
        };
        if (arg6 > 0) {
            assert!(10000000000 <= (arg6 as u256) && (arg6 as u256) <= 1000000000000000, 5028);
            arg0.adjustment_step = (arg6 as u256);
        };
        if (arg4 > 0) {
            assert!(30000 <= arg4 && arg4 <= 3600000, 5024);
            arg0.ma_half_time = (arg4 as u256);
        };
    }

    public fun xp(arg0: vector<u256>, arg1: vector<u256>) : vector<u256> {
        assert!(0x1::vector::length<u256>(&arg0) == 0x1::vector::length<u256>(&arg1), 5002);
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&arg0)) {
            0x1::vector::push_back<u256>(&mut v0, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg0, v1), *0x1::vector::borrow<u256>(&arg1, v1), 1000000000000000000));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

