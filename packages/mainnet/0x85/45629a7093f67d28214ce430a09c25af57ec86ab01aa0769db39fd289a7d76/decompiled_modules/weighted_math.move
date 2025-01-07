module 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math {
    struct WeightedConfig has drop, store {
        weights: vector<u64>,
        scaling_factor: vector<u256>,
        total_weight: u64,
        exit_fee_percent: u64,
    }

    public fun add_liquidity_computation(arg0: &WeightedConfig, arg1: vector<u256>, arg2: vector<u256>, arg3: u64, arg4: u256) : (u256, vector<u256>) {
        let v0 = 0x1::vector::length<u256>(&arg1);
        let v1 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::create_zero_vector_u256(v0);
        let (v2, v3) = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::get_non_zero_count_and_index_u256(arg2);
        assert!(v2 == 1 || v2 == 0x1::vector::length<u256>(&arg2), 5216);
        assert!(arg4 > 0 || v2 == 0x1::vector::length<u256>(&arg2), 5215);
        let v4 = if (v2 == 1) {
            let (v5, v6) = calc_minted_shares_given_single_asset_in(*0x1::vector::borrow<u256>(&arg2, v3), (get_weight_at_index(arg0, v3, true) as u256), *0x1::vector::borrow<u256>(&arg1, v3), arg4, arg3);
            *0x1::vector::borrow_mut<u256>(&mut v1, v3) = v6;
            v5
        } else if (arg4 == 0) {
            let v7 = false;
            let v8 = 0;
            while (v8 < v0) {
                if (*0x1::vector::borrow<u256>(&arg2, v8) >= (1000000000000000000 as u256)) {
                    v7 = true;
                    break
                };
                v8 = v8 + 1;
            };
            assert!(v7, 5211);
            100000000000000000000
        } else {
            let (v9, v10) = maximal_exact_ratio_join(arg2, arg1, arg4);
            let v11 = v10;
            let v12 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::create_zero_vector_u256(v0);
            let v13 = 0;
            while (v13 < v0) {
                let v14 = *0x1::vector::borrow<u256>(&v11, v13);
                if (v14 > 0) {
                    let (v15, v16) = calc_minted_shares_given_single_asset_in(*0x1::vector::borrow<u256>(&v11, v13), (get_weight_at_index(arg0, v13, true) as u256), *0x1::vector::borrow<u256>(&arg1, v13) + *0x1::vector::borrow<u256>(&arg2, v13) - v14, arg4 + v9, arg3);
                    *0x1::vector::borrow_mut<u256>(&mut v12, v13) = v15;
                    *0x1::vector::borrow_mut<u256>(&mut v1, v13) = v16;
                };
                v13 = v13 + 1;
            };
            v9 + 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_sum_u256(v12)
        };
        (v4, v1)
    }

    public fun calc_minted_shares_given_single_asset_in(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u64) : (u256, u256) {
        if (arg0 == 0) {
            return (0, 0)
        };
        let v0 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256(arg0, fee_ratio(arg1, (arg4 as u256)), (1000000000000000000 as u256));
        (solve_for_invariant(v0 + arg2, arg2, arg1, arg3, (1000000000000000000 as u256)), arg0 - v0)
    }

    public fun calc_shares_given_single_asset_out(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u64) : (u256, u256) {
        let v0 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256(arg3, (1000000000000000000 as u256), fee_ratio(arg0, (arg4 as u256)));
        (solve_for_invariant(arg1 - v0, arg1, arg0, arg2, (1000000000000000000 as u256)), v0 - arg3)
    }

    public fun calculate_pow(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : u256 {
        let v0 = arg0 * (1000000000000000000 as u256) / arg1;
        let v1 = arg2 * (1000000000000000000 as u256) / arg3;
        if (v1 == 0) {
            return (1000000000000000000 as u256)
        };
        if (v0 == 0) {
            return v0
        };
        assert!(v0 < ((2 * 1000000000000000000) as u256), 5213);
        let v2 = v1 / (1000000000000000000 as u256);
        let v3 = v1 % (1000000000000000000 as u256);
        let v4 = v0;
        if (v2 == 0) {
            v4 = (1000000000000000000 as u256);
        } else {
            let v5 = 1;
            while (v5 < (v2 as u128)) {
                let v6 = v4 * v0;
                v4 = v6 / (1000000000000000000 as u256);
                v5 = v5 + 1;
            };
        };
        if (v3 == 0) {
            return v4
        };
        v4 * pow_approx(v0, (v3 as u128), 1000000000000000) / (1000000000000000000 as u256)
    }

    public fun computeScalingFactor(arg0: u8) : u256 {
        assert!(18 >= arg0, 5212);
        0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::pow_10_u256(18 - arg0)
    }

    public fun compute_ask_amount(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : u256 {
        assert!(arg0 <= 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256(arg1, 300000000000000000, (1000000000000000000 as u256)), 5210);
        solve_for_invariant(arg1, arg1 + arg0, arg2, arg3, arg4)
    }

    public fun compute_offer_amount(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u64) : (u256, u256) {
        let v0 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::amm_fee_precision();
        assert!(arg0 <= 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256(arg1, 300000000000000000, (1000000000000000000 as u256)), 5210);
        let v1 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256(arg0, (v0 as u256), ((v0 - arg5) as u256));
        (solve_for_invariant(arg1, arg1 - v1, arg2, arg3, arg4), v1 - arg0)
    }

    public fun fee_ratio(arg0: u256, arg1: u256) : u256 {
        (1000000000000000000 as u256) - 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((1000000000000000000 as u256) - arg0, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256(arg1, (1000000000000000000 as u256), (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::amm_fee_precision() as u256)), (1000000000000000000 as u256))
    }

    public fun get_exit_fee(arg0: &WeightedConfig) : u64 {
        arg0.exit_fee_percent
    }

    public fun get_scaling_factor_vec(arg0: &WeightedConfig) : vector<u256> {
        arg0.scaling_factor
    }

    public fun get_weight_and_sf_at_index(arg0: &WeightedConfig, arg1: u64, arg2: bool) : (u64, u256) {
        let v0 = if (!arg2) {
            *0x1::vector::borrow<u64>(&arg0.weights, arg1)
        } else {
            (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((*0x1::vector::borrow<u64>(&arg0.weights, arg1) as u256), (1000000000000000000 as u256), (arg0.total_weight as u256)) as u64)
        };
        (v0, *0x1::vector::borrow<u256>(&arg0.scaling_factor, arg1))
    }

    public fun get_weight_at_index(arg0: &WeightedConfig, arg1: u64, arg2: bool) : u64 {
        if (!arg2) {
            *0x1::vector::borrow<u64>(&arg0.weights, arg1)
        } else {
            (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((*0x1::vector::borrow<u64>(&arg0.weights, arg1) as u256), (1000000000000000000 as u256), (arg0.total_weight as u256)) as u64)
        }
    }

    public fun get_weighted_config_params(arg0: &WeightedConfig) : (vector<u64>, vector<u256>, u64, u64) {
        (arg0.weights, arg0.scaling_factor, arg0.total_weight, arg0.exit_fee_percent)
    }

    public fun imbalanced_liquidity_withdraw(arg0: &WeightedConfig, arg1: vector<u256>, arg2: u256, arg3: vector<u256>, arg4: u64) : (u256, vector<u256>) {
        let v0 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::create_zero_vector_u256(0x1::vector::length<u256>(&arg1));
        let (v1, v2) = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::get_non_zero_count_and_index_u256(arg3);
        assert!(v1 == 1, 5214);
        let (v3, v4) = calc_shares_given_single_asset_out((get_weight_at_index(arg0, v2, true) as u256), *0x1::vector::borrow<u256>(&arg1, v2), arg2, *0x1::vector::borrow<u256>(&arg3, v2), arg4);
        *0x1::vector::borrow_mut<u256>(&mut v0, v2) = v4;
        (v3, v0)
    }

    public fun initialize_weighted_config(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<u256>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : WeightedConfig {
        assert!(0x1::vector::length<u64>(&arg0) == 1, 5218);
        assert!(0x1::vector::length<u64>(&arg1) == arg3, 5217);
        assert!(*0x1::vector::borrow<u64>(&arg0, 0) < 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::max_weighted_exit_fee(), 5220);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            assert!(*0x1::vector::borrow<u64>(&arg1, v1) > 0, 5219);
            v0 = v0 + *0x1::vector::borrow<u64>(&arg1, v1);
            v1 = v1 + 1;
        };
        WeightedConfig{
            weights          : arg1,
            scaling_factor   : arg2,
            total_weight     : v0,
            exit_fee_percent : *0x1::vector::borrow<u64>(&arg0, 0),
        }
    }

    public fun maximal_exact_ratio_join(arg0: vector<u256>, arg1: vector<u256>, arg2: u256) : (u256, vector<u256>) {
        let v0 = 0x1::vector::length<u256>(&arg0);
        let v1 = 0x1::vector::empty<u256>();
        let v2 = (1000000000000000000 as u256);
        let v3 = 0;
        let v4 = 0x1::vector::empty<u256>();
        let v5 = 0;
        while (v5 < v0) {
            let v6 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256(*0x1::vector::borrow<u256>(&arg0, v5), (1000000000000000000 as u256), *0x1::vector::borrow<u256>(&arg1, v5));
            v2 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::min_u256(v2, v6);
            v3 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::min_u256(v3, v6);
            0x1::vector::push_back<u256>(&mut v1, v6);
            v5 = v5 + 1;
        };
        v5 = 0;
        if (v2 != v3) {
            while (v5 < v0) {
                if (*0x1::vector::borrow<u256>(&v1, v5) == v2) {
                    0x1::vector::push_back<u256>(&mut v4, 0);
                    v5 = v5 + 1;
                    continue
                };
                0x1::vector::push_back<u256>(&mut v4, *0x1::vector::borrow<u256>(&arg0, v5) - 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256(v2, *0x1::vector::borrow<u256>(&arg1, v5), (1000000000000000000 as u256)));
                v5 = v5 + 1;
            };
        } else {
            while (v5 < v0) {
                0x1::vector::push_back<u256>(&mut v4, 0);
                v5 = v5 + 1;
            };
        };
        (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256(v2, arg2, (1000000000000000000 as u256)), v4)
    }

    public fun pow_approx(arg0: u256, arg1: u128, arg2: u64) : u256 {
        let (v0, v1) = sub_sign(arg0, (1000000000000000000 as u256));
        let v2 = (1000000000000000000 as u256);
        let v3 = v2;
        let v4 = false;
        let v5 = 0;
        let v6 = 1;
        while (v2 >= (arg2 as u256) && v6 < (32 as u128)) {
            let (v7, v8) = sub_sign((arg1 as u256), v5);
            let v9 = ((v6 * 1000000000000000000) as u256);
            v5 = v9;
            let v10 = v2 * v7 / (1000000000000000000 as u256) * v0 / v9;
            v2 = v10;
            if (v10 == 0) {
                break
            };
            if (v1) {
                v4 = !v4;
            };
            if (v8) {
                v4 = !v4;
            };
            if (v4) {
                v3 = v3 - v10;
            } else {
                v3 = v3 + v10;
            };
            v6 = v6 + 1;
        };
        v3
    }

    public fun solve_for_invariant(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : u256 {
        0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256(arg3, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::subtract_mod_u256((1000000000000000000 as u256), calculate_pow(arg0, arg1, arg2, arg4)), (1000000000000000000 as u256))
    }

    fun sub_sign(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg0 >= arg1) {
            return (arg0 - arg1, false)
        };
        (arg1 - arg0, true)
    }

    public fun update_weighted_config(arg0: &mut WeightedConfig, arg1: vector<u64>, arg2: u64) {
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg0.weights), 5217);
        assert!(arg2 < 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::max_weighted_exit_fee(), 5220);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            assert!(*0x1::vector::borrow<u64>(&arg1, v1) > 0, 5219);
            v0 = v0 + *0x1::vector::borrow<u64>(&arg1, v1);
            v1 = v1 + 1;
        };
        arg0.exit_fee_percent = arg2;
        arg0.total_weight = v0;
        arg0.weights = arg1;
    }

    // decompiled from Move bytecode v6
}

