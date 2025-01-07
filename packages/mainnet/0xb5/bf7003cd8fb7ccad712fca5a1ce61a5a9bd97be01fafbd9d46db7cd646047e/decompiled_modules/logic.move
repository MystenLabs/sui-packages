module 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::logic {
    fun calculate_liquidation(arg0: &0x2::clock::Clock, arg1: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg2: &0xd7e35e63f6abb21bd6182db8d4d88cbbcad06f4175356fd201dcf435d0cf2306::oracle::PriceOracle, arg3: address, arg4: u8, arg5: u8, arg6: u256) : (u256, u256, u256, u256, u256, bool) {
        let (v0, v1, _) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_liquidation_factors(arg1, arg4);
        let v3 = user_collateral_value(arg0, arg2, arg1, arg4, arg3);
        let v4 = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_mul(v3, v0);
        let v5 = v4;
        let v6 = user_loan_value(arg0, arg2, arg1, arg5, arg3);
        let v7 = false;
        if (v6 < v4) {
            v5 = v6;
            v7 = true;
        };
        let v8 = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::calculator::calculate_value(arg0, arg2, arg6, 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_oracle_id(arg1, arg5));
        let v9 = if (v8 > v5) {
            v8 - v5
        } else {
            v5 = v8;
            0
        };
        let v10 = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_mul(v5, v1);
        let v11 = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_mul(v10, 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_treasury_factor(arg1, arg4));
        (0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::calculator::calculate_amount(arg0, arg2, v5, arg4), 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::calculator::calculate_amount(arg0, arg2, v5, arg5), 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::calculator::calculate_amount(arg0, arg2, v5 - v11, arg4), 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::calculator::calculate_amount(arg0, arg2, v11, arg4), 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::calculator::calculate_amount(arg0, arg2, v9 + v10, arg5), v7)
    }

    fun decrease_borrow_balance(arg0: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (_, v1) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_index(arg0, arg1);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::decrease_borrow_balance(arg0, arg1, arg2, 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_div(arg3, v1));
    }

    fun decrease_supply_balance(arg0: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (v0, _) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_index(arg0, arg1);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::decrease_supply_balance(arg0, arg1, arg2, 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_div(arg3, v0));
    }

    public fun dynamic_liquidation_threshold(arg0: &0x2::clock::Clock, arg1: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg2: &0xd7e35e63f6abb21bd6182db8d4d88cbbcad06f4175356fd201dcf435d0cf2306::oracle::PriceOracle, arg3: address) : u256 {
        let (v0, _) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_user_assets(arg1, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v6 = 0x1::vector::borrow<u8>(&v2, v3);
            let (_, _, v9) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_liquidation_factors(arg1, *v6);
            let v10 = user_collateral_value(arg0, arg2, arg1, *v6, arg3);
            v5 = v5 + 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_mul(v10, v9);
            v4 = v4 + v10;
            v3 = v3 + 1;
        };
        if (v4 > 0) {
            return 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_div(v5, v4)
        };
        0
    }

    public(friend) fun execute_borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0xd7e35e63f6abb21bd6182db8d4d88cbbcad06f4175356fd201dcf435d0cf2306::oracle::PriceOracle, arg2: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg3: u8, arg4: address, arg5: u256) {
        update_state_of_all(arg0, arg2);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::validation::validate_borrow<T0>(arg2, arg3, arg5);
        increase_borrow_balance(arg2, arg3, arg4, arg5);
        let v0 = is_loan(arg2, arg3, arg4);
        if (!v0) {
            0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::update_user_loans(arg2, arg3, arg4);
        };
        assert!(is_health(arg0, arg1, arg2, arg4), 20001);
        update_interest_rate(arg2, arg3);
    }

    public(friend) fun execute_deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg2: u8, arg3: address, arg4: u256) {
        update_state_of_all(arg0, arg1);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::validation::validate_deposit<T0>(arg1, arg2, arg4);
        increase_supply_balance(arg1, arg2, arg3, arg4);
        let v0 = is_collateral(arg1, arg2, arg3);
        if (!v0) {
            0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::update_user_collaterals(arg1, arg2, arg3);
        };
        update_interest_rate(arg1, arg2);
    }

    public(friend) fun execute_liquidate<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xd7e35e63f6abb21bd6182db8d4d88cbbcad06f4175356fd201dcf435d0cf2306::oracle::PriceOracle, arg2: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg3: address, arg4: u8, arg5: u8, arg6: u256) : (u256, u256, u256) {
        assert!(is_loan(arg2, arg5, arg3), 20004);
        assert!(is_collateral(arg2, arg4, arg3), 20003);
        update_state_of_all(arg0, arg2);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::validation::validate_liquidate<T0, T1>(arg2, arg5, arg4, arg6);
        let v0 = is_health(arg0, arg1, arg2, arg3);
        assert!(!v0, 20002);
        let (v1, v2, v3, v4, v5, v6) = calculate_liquidation(arg0, arg2, arg1, arg3, arg4, arg5, arg6);
        decrease_borrow_balance(arg2, arg5, arg3, v2);
        decrease_supply_balance(arg2, arg4, arg3, v1);
        if (v6) {
            0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::remove_user_loans(arg2, arg5, arg3);
        };
        update_interest_rate(arg2, arg4);
        update_interest_rate(arg2, arg5);
        (v3, v5, v4)
    }

    public(friend) fun execute_repay<T0>(arg0: &0x2::clock::Clock, arg1: &0xd7e35e63f6abb21bd6182db8d4d88cbbcad06f4175356fd201dcf435d0cf2306::oracle::PriceOracle, arg2: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg3: u8, arg4: address, arg5: u256) : u256 {
        let v0 = user_loan_balance(arg2, arg3, arg4);
        assert!(v0 > 0, 20006);
        update_state_of_all(arg0, arg2);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::validation::validate_repay<T0>(arg2, arg3, arg5);
        let v1 = user_loan_balance(arg2, arg3, arg4);
        let v2 = 0;
        let v3 = arg5;
        if (v1 < arg5) {
            v3 = v1;
            v2 = arg5 - v1;
        };
        decrease_borrow_balance(arg2, arg3, arg4, v3);
        if (v3 == v1) {
            0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::remove_user_loans(arg2, arg3, arg4);
        };
        update_interest_rate(arg2, arg3);
        v2
    }

    public(friend) fun execute_withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0xd7e35e63f6abb21bd6182db8d4d88cbbcad06f4175356fd201dcf435d0cf2306::oracle::PriceOracle, arg2: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg3: u8, arg4: address, arg5: u256) : u64 {
        let v0 = user_collateral_balance(arg2, arg3, arg4);
        assert!(v0 > 0, 20005);
        update_state_of_all(arg0, arg2);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::validation::validate_withdraw<T0>(arg2, arg3, arg5);
        let v1 = user_collateral_balance(arg2, arg3, arg4);
        let v2 = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::safe_math::min(arg5, v1);
        decrease_supply_balance(arg2, arg3, arg4, v2);
        assert!(is_health(arg0, arg1, arg2, arg4), 20001);
        if (v2 == v1) {
            if (is_collateral(arg2, arg3, arg4)) {
                0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::remove_user_collaterals(arg2, arg3, arg4);
            };
        };
        if (v1 > v2) {
            if (v1 - v2 <= 1000) {
                0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::increase_treasury_balance(arg2, arg3, v1 - v2);
                if (is_collateral(arg2, arg3, arg4)) {
                    0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::remove_user_collaterals(arg2, arg3, arg4);
                };
            };
        };
        update_interest_rate(arg2, arg3);
        (v2 as u64)
    }

    fun increase_borrow_balance(arg0: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (_, v1) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_index(arg0, arg1);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::increase_borrow_balance(arg0, arg1, arg2, 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_div(arg3, v1));
    }

    fun increase_supply_balance(arg0: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (v0, _) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_index(arg0, arg1);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::increase_supply_balance(arg0, arg1, arg2, 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_div(arg3, v0));
    }

    public fun is_collateral(arg0: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg1: u8, arg2: address) : bool {
        let (v0, _) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_user_assets(arg0, arg2);
        let v2 = v0;
        0x1::vector::contains<u8>(&v2, &arg1)
    }

    public fun is_health(arg0: &0x2::clock::Clock, arg1: &0xd7e35e63f6abb21bd6182db8d4d88cbbcad06f4175356fd201dcf435d0cf2306::oracle::PriceOracle, arg2: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg3: address) : bool {
        user_health_factor(arg0, arg2, arg1, arg3) >= 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray()
    }

    public fun is_loan(arg0: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg1: u8, arg2: address) : bool {
        let (_, v1) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_user_assets(arg0, arg2);
        let v2 = v1;
        0x1::vector::contains<u8>(&v2, &arg1)
    }

    fun update_interest_rate(arg0: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg1: u8) {
        let v0 = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::calculator::calculate_borrow_rate(arg0, arg1);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::update_interest_rate(arg0, arg1, v0, 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::calculator::calculate_supply_rate(arg0, arg1, v0));
    }

    fun update_state(arg0: &0x2::clock::Clock, arg1: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg2: u8) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = ((v0 - 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_last_update_timestamp(arg1, arg2)) as u256) / 1000;
        let (v2, v3) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_index(arg1, arg2);
        let (v4, v5) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_current_rate(arg1, arg2);
        let v6 = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_mul(0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::calculator::calculate_linear_interest(v1, v4), v2);
        let v7 = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_mul(0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::calculator::calculate_compounded_interest(v1, v5), v3);
        let (_, _, _, v11, _) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_borrow_rate_factors(arg1, arg2);
        let (v13, v14) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_total_supply(arg1, arg2);
        let v15 = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_div(0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_mul(0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_mul(v14, v7 - v3), v11), v7);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::update_state(arg1, arg2, v7, v6, v0, v15);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::increase_balance_for_pool(arg1, arg2, 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_div(0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_mul(v13, v6 - v2), v6), 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_div(0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_mul(v14, v7 - v3), v7) + v15);
    }

    fun update_state_of_all(arg0: &0x2::clock::Clock, arg1: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage) {
        let v0 = 0;
        while (v0 < 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_reserves_count(arg1)) {
            update_state(arg0, arg1, v0);
            v0 = v0 + 1;
        };
    }

    public fun user_collateral_balance(arg0: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg1: u8, arg2: address) : u256 {
        let (v0, _) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_user_balance(arg0, arg1, arg2);
        let (v2, _) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_index(arg0, arg1);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_mul(v0, v2)
    }

    public fun user_collateral_value(arg0: &0x2::clock::Clock, arg1: &0xd7e35e63f6abb21bd6182db8d4d88cbbcad06f4175356fd201dcf435d0cf2306::oracle::PriceOracle, arg2: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg3: u8, arg4: address) : u256 {
        let v0 = user_collateral_balance(arg2, arg3, arg4);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::calculator::calculate_value(arg0, arg1, v0, 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_oracle_id(arg2, arg3))
    }

    public fun user_health_collateral_value(arg0: &0x2::clock::Clock, arg1: &0xd7e35e63f6abb21bd6182db8d4d88cbbcad06f4175356fd201dcf435d0cf2306::oracle::PriceOracle, arg2: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg3: address) : u256 {
        let (v0, _) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_user_assets(arg2, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            let v5 = 0x1::vector::borrow<u8>(&v2, v4);
            let v6 = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_asset_ltv(arg2, *v5);
            v3 = v3 + 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_mul(user_collateral_value(arg0, arg1, arg2, *v5, arg3), v6);
            v4 = v4 + 1;
        };
        v3
    }

    public fun user_health_factor(arg0: &0x2::clock::Clock, arg1: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg2: &0xd7e35e63f6abb21bd6182db8d4d88cbbcad06f4175356fd201dcf435d0cf2306::oracle::PriceOracle, arg3: address) : u256 {
        let v0 = user_health_collateral_value(arg0, arg2, arg1, arg3);
        let v1 = dynamic_liquidation_threshold(arg0, arg1, arg2, arg3);
        let v2 = user_health_loan_value(arg0, arg2, arg1, arg3);
        if (v2 > 0) {
            0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_mul(0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_div(v0, v2), v1)
        } else {
            0x2::address::max()
        }
    }

    public fun user_health_loan_value(arg0: &0x2::clock::Clock, arg1: &0xd7e35e63f6abb21bd6182db8d4d88cbbcad06f4175356fd201dcf435d0cf2306::oracle::PriceOracle, arg2: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg3: address) : u256 {
        let (_, v1) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_user_assets(arg2, arg3);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            v3 = v3 + user_loan_value(arg0, arg1, arg2, *0x1::vector::borrow<u8>(&v2, v4), arg3);
            v4 = v4 + 1;
        };
        v3
    }

    public fun user_loan_balance(arg0: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg1: u8, arg2: address) : u256 {
        let (_, v1) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_user_balance(arg0, arg1, arg2);
        let (_, v3) = 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_index(arg0, arg1);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::ray_math::ray_mul(v1, v3)
    }

    public fun user_loan_value(arg0: &0x2::clock::Clock, arg1: &0xd7e35e63f6abb21bd6182db8d4d88cbbcad06f4175356fd201dcf435d0cf2306::oracle::PriceOracle, arg2: &mut 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::Storage, arg3: u8, arg4: address) : u256 {
        let v0 = user_loan_balance(arg2, arg3, arg4);
        0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::calculator::calculate_value(arg0, arg1, v0, 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::storage::get_oracle_id(arg2, arg3))
    }

    // decompiled from Move bytecode v6
}

