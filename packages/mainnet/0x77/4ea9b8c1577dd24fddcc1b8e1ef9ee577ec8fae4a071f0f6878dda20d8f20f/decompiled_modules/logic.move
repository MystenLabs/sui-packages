module 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::logic {
    public fun calculate_actual_liquidation(arg0: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg1: u256, arg2: u256, arg3: u8, arg4: u8, arg5: u256, arg6: u256) : (u256, u256, u256, u256, u256) {
        let (v0, v1, v2) = if (arg5 > arg2) {
            (arg5 - arg2, arg1, arg2)
        } else {
            (0, 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(arg1, 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_div(arg5, arg2)), arg5)
        };
        let v3 = 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::calculator::calculate_amount(arg0, 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::calculator::calculate_value(arg0, v1, arg3) - 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::calculator::calculate_value(arg0, v2, arg4), arg3), arg6);
        (v1, v2, v1 - v3, v3, v0)
    }

    public fun calculate_max_liquidation(arg0: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: address, arg3: u8, arg4: u8) : (u256, u256) {
        let (v0, v1, _) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_liquidation_factors(arg0, arg3);
        let v3 = user_collateral_value(arg1, arg0, arg3, arg2);
        let v4 = user_loan_value(arg1, arg0, arg4, arg2);
        let v5 = 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v3, v0);
        let v6 = v5;
        let v7 = if (v4 > v3) {
            v6 = 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v5, 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray() + v1);
            v3
        } else {
            0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v4, 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray() + v1)
        };
        (0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::calculator::calculate_amount(arg1, v6, arg3), 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::calculator::calculate_amount(arg1, v7, arg4))
    }

    fun decrease_borrow_balance(arg0: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (_, v1) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_index(arg0, arg1);
        0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::decrease_borrow_balance(arg0, arg1, arg2, 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_div(arg3, v1));
    }

    fun decrease_supply_balance(arg0: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (v0, _) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_index(arg0, arg1);
        0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::decrease_supply_balance(arg0, arg1, arg2, 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_div(arg3, v0));
    }

    public fun dynamic_liquidation_threshold(arg0: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: address) : u256 {
        let (v0, _) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_user_assets(arg0, arg2);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v6 = 0x1::vector::borrow<u8>(&v2, v3);
            let (_, _, v9) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_liquidation_factors(arg0, *v6);
            let v10 = user_collateral_value(arg1, arg0, *v6, arg2);
            v5 = v5 + 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v10, v9);
            v4 = v4 + v10;
            v3 = v3 + 1;
        };
        0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_div(v5, v4)
    }

    public(friend) fun execute_borrow(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg3: u8, arg4: address, arg5: u256) {
        update_state(arg0, arg2, arg3);
        increase_borrow_balance(arg2, arg3, arg4, arg5);
        let v0 = is_loan(arg2, arg3, arg4);
        if (!v0) {
            0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::update_user_loans(arg2, arg3, arg4);
        };
        assert!(is_health(arg1, arg2, arg4), 20003);
        update_interest_rate(arg2, arg3);
    }

    public(friend) fun execute_deposit(arg0: &0x2::clock::Clock, arg1: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg2: u8, arg3: address, arg4: u256) {
        update_state(arg0, arg1, arg2);
        increase_supply_balance(arg1, arg2, arg3, arg4);
        let v0 = is_collateral(arg1, arg2, arg3);
        if (!v0) {
            0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::update_user_collaterals(arg1, arg2, arg3);
        };
        update_interest_rate(arg1, arg2);
    }

    public(friend) fun execute_liquidate(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg3: address, arg4: u8, arg5: u8, arg6: u256) : (u256, u256, u256) {
        assert!(is_loan(arg2, arg5, arg3), 20006);
        assert!(is_collateral(arg2, arg4, arg3), 20005);
        update_state(arg0, arg2, arg5);
        update_state(arg0, arg2, arg4);
        let v0 = is_health(arg1, arg2, arg3);
        assert!(!v0, 20004);
        let (v1, v2) = calculate_max_liquidation(arg2, arg1, arg3, arg4, arg5);
        let (v3, v4, v5, v6, v7) = calculate_actual_liquidation(arg1, v1, v2, arg4, arg5, arg6, 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_treasury_factor(arg2, arg4));
        decrease_borrow_balance(arg2, arg5, arg3, v4);
        decrease_supply_balance(arg2, arg4, arg3, v3);
        if (v2 == arg6) {
            0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::remove_user_loans(arg2, arg5, arg3);
        };
        update_interest_rate(arg2, arg4);
        update_interest_rate(arg2, arg5);
        (v5, v7, v6)
    }

    public(friend) fun execute_repay(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg3: u8, arg4: address, arg5: u256) : u256 {
        update_state(arg0, arg2, arg3);
        let v0 = user_loan_balance(arg2, arg3, arg4);
        let v1 = 0;
        let v2 = arg5;
        if (v0 < arg5) {
            v2 = v0;
            v1 = arg5 - v0;
        };
        decrease_borrow_balance(arg2, arg3, arg4, v2);
        if (v2 == v0) {
            0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::remove_user_loans(arg2, arg3, arg4);
        };
        update_interest_rate(arg2, arg3);
        v1
    }

    public(friend) fun execute_withdraw(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg3: u8, arg4: address, arg5: u256) : u64 {
        update_state(arg0, arg2, arg3);
        let v0 = user_collateral_balance(arg2, arg3, arg4);
        let v1 = 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::safe_math::min(arg5, v0);
        decrease_supply_balance(arg2, arg3, arg4, v1);
        assert!(is_health(arg1, arg2, arg4), 20003);
        if (v1 == v0) {
            if (is_collateral(arg2, arg3, arg4)) {
                0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::remove_user_collaterals(arg2, arg3, arg4);
            };
        };
        update_interest_rate(arg2, arg3);
        (v1 as u64)
    }

    fun increase_borrow_balance(arg0: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (_, v1) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_index(arg0, arg1);
        0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::increase_borrow_balance(arg0, arg1, arg2, 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_div(arg3, v1));
    }

    fun increase_supply_balance(arg0: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (v0, _) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_index(arg0, arg1);
        0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::increase_supply_balance(arg0, arg1, arg2, 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_div(arg3, v0));
    }

    public fun is_collateral(arg0: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg1: u8, arg2: address) : bool {
        let (v0, _) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_user_assets(arg0, arg2);
        let v2 = v0;
        0x1::vector::contains<u8>(&v2, &arg1)
    }

    public fun is_health(arg0: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg1: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg2: address) : bool {
        user_health_factor(arg1, arg0, arg2) > 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray()
    }

    public fun is_loan(arg0: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg1: u8, arg2: address) : bool {
        let (_, v1) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_user_assets(arg0, arg2);
        let v2 = v1;
        0x1::vector::contains<u8>(&v2, &arg1)
    }

    fun update_interest_rate(arg0: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg1: u8) {
        let v0 = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::calculator::calculate_borrow_rate(arg0, arg1);
        0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::update_interest_rate(arg0, arg1, v0, 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::calculator::calculate_supply_rate(arg0, arg1, v0));
    }

    fun update_state(arg0: &0x2::clock::Clock, arg1: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg2: u8) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_last_update_timestamp(arg1, arg2);
        let (v2, v3) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_index(arg1, arg2);
        let (v4, v5) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_current_rate(arg1, arg2);
        let v6 = 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::calculator::calculate_compounded_interest(v0, v1, v5), v3);
        let v7 = 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::calculator::calculate_linear_interest(v0, v1, v4), v2);
        let (_, v9) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_total_supply(arg1, arg2);
        0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::update_state(arg1, arg2, v6, v7, v0, 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_div(0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v9, v6 - v3), 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_treasury_factor(arg1, arg2)), v7));
    }

    public fun user_collateral_balance(arg0: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg1: u8, arg2: address) : u256 {
        let (v0, _) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_user_balance(arg0, arg1, arg2);
        let (v2, _) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_index(arg0, arg1);
        0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v0, v2)
    }

    public fun user_collateral_value(arg0: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg1: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg2: u8, arg3: address) : u256 {
        0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::calculator::calculate_value(arg0, user_collateral_balance(arg1, arg2, arg3), arg2)
    }

    public fun user_health_collateral_value(arg0: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg1: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg2: address) : u256 {
        let (v0, _) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_user_assets(arg1, arg2);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            let v5 = 0x1::vector::borrow<u8>(&v2, v4);
            let v6 = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_asset_ltv(arg1, *v5);
            v3 = v3 + 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(user_collateral_value(arg0, arg1, *v5, arg2), v6);
            v4 = v4 + 1;
        };
        v3
    }

    public fun user_health_factor(arg0: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: address) : u256 {
        let v0 = user_health_collateral_value(arg1, arg0, arg2);
        let v1 = dynamic_liquidation_threshold(arg0, arg1, arg2);
        let v2 = user_health_loan_value(arg1, arg0, arg2);
        if (v2 > 0) {
            0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_div(v0, v2), v1)
        } else {
            0x2::address::max()
        }
    }

    public fun user_health_loan_value(arg0: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg1: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg2: address) : u256 {
        let (_, v1) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_user_assets(arg1, arg2);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            v3 = v3 + user_loan_value(arg0, arg1, *0x1::vector::borrow<u8>(&v2, v4), arg2);
            v4 = v4 + 1;
        };
        v3
    }

    public fun user_loan_balance(arg0: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg1: u8, arg2: address) : u256 {
        let (_, v1) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_user_balance(arg0, arg1, arg2);
        let (_, v3) = 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::get_index(arg0, arg1);
        0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v1, v3)
    }

    public fun user_loan_value(arg0: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg1: &mut 0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::storage::Storage, arg2: u8, arg3: address) : u256 {
        0x934de8523181509840f8defc71d9c345bf0bc71ad6e155164c591c34c9530a17::calculator::calculate_value(arg0, user_loan_balance(arg1, arg2, arg3), arg2)
    }

    // decompiled from Move bytecode v6
}

