module 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic {
    struct StateUpdated has copy, drop {
        user: address,
        asset: u8,
        user_supply_balance: u256,
        user_borrow_balance: u256,
        new_supply_index: u256,
        new_borrow_index: u256,
    }

    public fun calculate_avg_ltv(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address) : u256 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v6 = 0x1::vector::borrow<u8>(&v2, v3);
            let v7 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg2, *v6);
            let v8 = user_collateral_value(arg0, arg1, arg2, *v6, arg3);
            v4 = v4 + v8;
            v5 = v5 + 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v7, v8);
            v3 = v3 + 1;
        };
        if (v4 > 0) {
            return 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(v5, v4)
        };
        0
    }

    public fun calculate_avg_threshold(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address) : u256 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v6 = 0x1::vector::borrow<u8>(&v2, v3);
            let (_, _, v9) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg2, *v6);
            let v10 = user_collateral_value(arg0, arg1, arg2, *v6, arg3);
            v4 = v4 + v10;
            v5 = v5 + 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v9, v10);
            v3 = v3 + 1;
        };
        if (v4 > 0) {
            return 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(v5, v4)
        };
        0
    }

    fun calculate_liquidation(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: address, arg4: u8, arg5: u8, arg6: u256) : (u256, u256, u256, u256, u256, bool) {
        let (v0, v1, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg1, arg4);
        let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_treasury_factor(arg1, arg4);
        let v4 = user_collateral_value(arg0, arg2, arg1, arg4, arg3);
        let v5 = user_loan_value(arg0, arg2, arg1, arg5, arg3);
        let v6 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg1, arg4);
        let v7 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg1, arg5);
        let v8 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg0, arg2, arg6, v7);
        let v9 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v4, v0);
        let v10 = v9;
        let v11 = false;
        let v12 = if (v8 >= v9) {
            v8 - v9
        } else {
            v10 = v8;
            0
        };
        if (v10 >= v5) {
            v11 = true;
            v10 = v5;
            v12 = v8 - v5;
        };
        let v13 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v10, v1);
        let v14 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v13, v3);
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg2, v10, v6), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg2, v10, v7), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg2, v13 - v14, v6), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg2, v14, v6), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg2, v12, v7), v11)
    }

    public(friend) fun cumulate_to_supply_index(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: u256) {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::update_state(arg0, arg1, v3, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(arg2, v0) + 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray(), v2), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_last_update_timestamp(arg0, arg1), 0);
        emit_state_updated_event(arg0, arg1, @0x0);
    }

    fun decrease_borrow_balance(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::decrease_borrow_balance(arg0, arg1, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(arg3, v1));
    }

    fun decrease_supply_balance(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::decrease_supply_balance(arg0, arg1, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(arg3, v0));
    }

    public fun dynamic_liquidation_threshold(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: address) : u256 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg1, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v6 = 0x1::vector::borrow<u8>(&v2, v3);
            let (_, _, v9) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg1, *v6);
            let v10 = user_collateral_value(arg0, arg2, arg1, *v6, arg3);
            v5 = v5 + 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v10, v9);
            v4 = v4 + v10;
            v3 = v3 + 1;
        };
        if (v4 > 0) {
            return 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(v5, v4)
        };
        0
    }

    fun emit_state_updated_event(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1);
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, arg2);
        let v4 = StateUpdated{
            user                : arg2,
            asset               : arg1,
            user_supply_balance : v2,
            user_borrow_balance : v3,
            new_supply_index    : v0,
            new_borrow_index    : v1,
        };
        0x2::event::emit<StateUpdated>(v4);
    }

    public(friend) fun execute_borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: address, arg5: u256) {
        update_state_of_all(arg0, arg2);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::validation::validate_borrow<T0>(arg2, arg3, arg5);
        increase_borrow_balance(arg2, arg3, arg4, arg5);
        let v0 = is_loan(arg2, arg3, arg4);
        if (!v0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::update_user_loans(arg2, arg3, arg4);
        };
        let v1 = calculate_avg_ltv(arg0, arg1, arg2, arg4);
        let v2 = calculate_avg_threshold(arg0, arg1, arg2, arg4);
        assert!(v1 > 0 && v2 > 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::ltv_is_not_enough());
        let v3 = user_health_factor(arg0, arg2, arg1, arg4);
        assert!(v3 >= 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(v2, v1), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::user_is_unhealthy());
        update_interest_rate(arg2, arg3);
        emit_state_updated_event(arg2, arg3, arg4);
    }

    public(friend) fun execute_deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u8, arg3: address, arg4: u256) {
        update_state_of_all(arg0, arg1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::validation::validate_deposit<T0>(arg1, arg2, arg4);
        increase_supply_balance(arg1, arg2, arg3, arg4);
        let v0 = is_collateral(arg1, arg2, arg3);
        if (!v0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::update_user_collaterals(arg1, arg2, arg3);
        };
        update_interest_rate(arg1, arg2);
        emit_state_updated_event(arg1, arg2, arg3);
    }

    public(friend) fun execute_liquidate<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address, arg4: u8, arg5: u8, arg6: u256) : (u256, u256, u256) {
        assert!(is_loan(arg2, arg5, arg3), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::user_have_no_loan());
        assert!(is_collateral(arg2, arg4, arg3), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::user_have_no_collateral());
        update_state_of_all(arg0, arg2);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::validation::validate_liquidate<T0, T1>(arg2, arg5, arg4, arg6);
        let v0 = is_health(arg0, arg1, arg2, arg3);
        assert!(!v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::user_is_healthy());
        let (v1, v2, v3, v4, v5, v6) = calculate_liquidation(arg0, arg2, arg1, arg3, arg4, arg5, arg6);
        decrease_borrow_balance(arg2, arg5, arg3, v2);
        decrease_supply_balance(arg2, arg4, arg3, v1 + v3 + v4);
        if (v6) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::remove_user_loans(arg2, arg5, arg3);
        };
        update_interest_rate(arg2, arg4);
        update_interest_rate(arg2, arg5);
        emit_state_updated_event(arg2, arg4, arg3);
        emit_state_updated_event(arg2, arg5, arg3);
        (v1 + v3, v5, v4)
    }

    public(friend) fun execute_repay<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: address, arg5: u256) : u256 {
        let v0 = user_loan_balance(arg2, arg3, arg4);
        assert!(v0 > 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::user_have_no_loan());
        update_state_of_all(arg0, arg2);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::validation::validate_repay<T0>(arg2, arg3, arg5);
        let v1 = user_loan_balance(arg2, arg3, arg4);
        let v2 = 0;
        let v3 = arg5;
        if (v1 < arg5) {
            v3 = v1;
            v2 = arg5 - v1;
        };
        decrease_borrow_balance(arg2, arg3, arg4, v3);
        if (v3 == v1) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::remove_user_loans(arg2, arg3, arg4);
        };
        update_interest_rate(arg2, arg3);
        emit_state_updated_event(arg2, arg3, arg4);
        v2
    }

    public(friend) fun execute_withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: address, arg5: u256) : u64 {
        let v0 = user_collateral_balance(arg2, arg3, arg4);
        assert!(v0 > 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::user_have_no_collateral());
        update_state_of_all(arg0, arg2);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::validation::validate_withdraw<T0>(arg2, arg3, arg5);
        let v1 = user_collateral_balance(arg2, arg3, arg4);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::safe_math::min(arg5, v1);
        decrease_supply_balance(arg2, arg3, arg4, v2);
        assert!(is_health(arg0, arg1, arg2, arg4), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::user_is_unhealthy());
        if (v2 == v1) {
            if (is_collateral(arg2, arg3, arg4)) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::remove_user_collaterals(arg2, arg3, arg4);
            };
        };
        if (v1 > v2) {
            if (v1 - v2 <= 1000) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::increase_treasury_balance(arg2, arg3, v1 - v2);
                if (is_collateral(arg2, arg3, arg4)) {
                    0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::remove_user_collaterals(arg2, arg3, arg4);
                };
            };
        };
        update_interest_rate(arg2, arg3);
        emit_state_updated_event(arg2, arg3, arg4);
        (v2 as u64)
    }

    fun increase_borrow_balance(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::increase_borrow_balance(arg0, arg1, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(arg3, v1));
    }

    fun increase_supply_balance(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::increase_supply_balance(arg0, arg1, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(arg3, v0));
    }

    public fun is_collateral(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address) : bool {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, arg2);
        let v2 = v0;
        0x1::vector::contains<u8>(&v2, &arg1)
    }

    public fun is_health(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address) : bool {
        user_health_factor(arg0, arg2, arg1, arg3) >= 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray()
    }

    public fun is_loan(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address) : bool {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, arg2);
        let v2 = v1;
        0x1::vector::contains<u8>(&v2, &arg1)
    }

    public(friend) fun update_interest_rate(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8) {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_borrow_rate(arg0, arg1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::update_interest_rate(arg0, arg1, v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_supply_rate(arg0, arg1, v0));
    }

    fun update_state(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u8) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = ((v0 - 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_last_update_timestamp(arg1, arg2)) as u256) / 1000;
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg1, arg2);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_current_rate(arg1, arg2);
        let (_, _, _, v9, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_borrow_rate_factors(arg1, arg2);
        let (_, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_total_supply(arg1, arg2);
        let v13 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_linear_interest(v1, v4), v2);
        let v14 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_compounded_interest(v1, v5), v3);
        let v15 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v12, v14 - v3), v9), v13);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::update_state(arg1, arg2, v14, v13, v0, v15);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::increase_total_supply_balance(arg1, arg2, v15);
    }

    public(friend) fun update_state_of_all(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        let v0 = 0;
        while (v0 < 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg1)) {
            update_state(arg0, arg1, v0);
            v0 = v0 + 1;
        };
    }

    public fun user_collateral_balance(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address) : u256 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, arg2);
        let (v2, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v0, v2)
    }

    public fun user_collateral_value(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: address) : u256 {
        let v0 = user_collateral_balance(arg2, arg3, arg4);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg0, arg1, v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg2, arg3))
    }

    public fun user_health_collateral_value(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address) : u256 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            v3 = v3 + user_collateral_value(arg0, arg1, arg2, *0x1::vector::borrow<u8>(&v2, v4), arg3);
            v4 = v4 + 1;
        };
        v3
    }

    public fun user_health_factor(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: address) : u256 {
        let v0 = user_health_collateral_value(arg0, arg2, arg1, arg3);
        let v1 = dynamic_liquidation_threshold(arg0, arg1, arg2, arg3);
        let v2 = user_health_loan_value(arg0, arg2, arg1, arg3);
        if (v2 > 0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(v0, v2), v1)
        } else {
            0x2::address::max()
        }
    }

    public fun user_health_factor_batch(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: vector<address>) : vector<u256> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u256>();
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            0x1::vector::push_back<u256>(&mut v1, user_health_factor(arg0, arg2, arg1, *0x1::vector::borrow<address>(&arg3, v0)));
            v0 = v0 + 1;
        };
        v1
    }

    public fun user_health_loan_value(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address) : u256 {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, arg3);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            v3 = v3 + user_loan_value(arg0, arg1, arg2, *0x1::vector::borrow<u8>(&v2, v4), arg3);
            v4 = v4 + 1;
        };
        v3
    }

    public fun user_loan_balance(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address) : u256 {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, arg2);
        let (_, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v1, v3)
    }

    public fun user_loan_value(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: address) : u256 {
        let v0 = user_loan_balance(arg2, arg3, arg4);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg0, arg1, v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg2, arg3))
    }

    // decompiled from Move bytecode v6
}

