module 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::logic {
    public fun decrease_borrow_balance(arg0: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (v0, _) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_index(arg0, arg1);
        0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::decrease_supply_balance(arg0, arg1, arg2, 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_div(arg3, v0));
    }

    public fun decrease_supply_balance(arg0: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (v0, _) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_index(arg0, arg1);
        0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::decrease_supply_balance(arg0, arg1, arg2, 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_div(arg3, v0));
    }

    public(friend) fun execute_borrow(arg0: &0x2::clock::Clock, arg1: &0xa4951e331eab16415301bc6e4c297cd7e369c3a19871373fb9f8dc92275f77e7::oracle::PriceOracle, arg2: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg3: u8, arg4: address, arg5: u256) {
        update_state(arg0, arg2, arg3);
        let v0 = is_loan(arg2, arg3, arg4);
        if (!v0) {
            0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::update_user_loans(arg2, arg3, arg4);
        };
        increase_borrow_balance(arg2, arg3, arg4, arg5);
        assert!(is_health(arg2, arg1, arg4), 20003);
        update_interest_rate(arg2, arg3, arg5);
    }

    public(friend) fun execute_deposit(arg0: &0x2::clock::Clock, arg1: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg2: u8, arg3: address, arg4: u256) {
        update_state(arg0, arg1, arg2);
        increase_supply_balance(arg1, arg2, arg3, arg4);
        let v0 = is_collateral(arg1, arg2, arg3);
        if (!v0) {
            0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::update_user_collaterals(arg1, arg2, arg3);
        };
        update_interest_rate(arg1, arg2, 0);
    }

    public(friend) fun execute_repay(arg0: &0x2::clock::Clock, arg1: &0xa4951e331eab16415301bc6e4c297cd7e369c3a19871373fb9f8dc92275f77e7::oracle::PriceOracle, arg2: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg3: u8, arg4: address, arg5: u256) {
        update_state(arg0, arg2, arg3);
        let v0 = user_loan_balance(arg2, arg3, arg4);
        let v1 = 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::safe_math::min(v0, arg5);
        decrease_borrow_balance(arg2, arg3, arg4, v1);
        if (v1 == v0) {
            0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::remove_user_loans(arg2, arg3, arg4);
        };
        update_interest_rate(arg2, arg3, 0);
    }

    public(friend) fun execute_withdraw(arg0: &0x2::clock::Clock, arg1: &0xa4951e331eab16415301bc6e4c297cd7e369c3a19871373fb9f8dc92275f77e7::oracle::PriceOracle, arg2: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg3: u8, arg4: address, arg5: u256) : u64 {
        update_state(arg0, arg2, arg3);
        let v0 = user_collateral_balance(arg2, arg3, arg4);
        let v1 = 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::safe_math::min(arg5, v0);
        decrease_supply_balance(arg2, arg3, arg4, v0);
        assert!(is_health(arg2, arg1, arg4), 20003);
        if (v1 == v0) {
            if (is_collateral(arg2, arg3, arg4)) {
                0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::remove_user_collaterals(arg2, arg3, arg4);
            };
        };
        update_interest_rate(arg2, arg3, v1);
        (v1 as u64)
    }

    public fun increase_borrow_balance(arg0: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (_, v1) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_index(arg0, arg1);
        0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::increase_borrow_balance(arg0, arg1, arg2, 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_div(arg3, v1));
    }

    public fun increase_supply_balance(arg0: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (v0, _) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_index(arg0, arg1);
        0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::increase_supply_balance(arg0, arg1, arg2, 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_div(arg3, v0));
    }

    public fun is_collateral(arg0: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg1: u8, arg2: address) : bool {
        let (v0, _) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_user_assets(arg0, arg2);
        let v2 = v0;
        0x1::vector::contains<u8>(&v2, &arg1)
    }

    public fun is_health(arg0: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg1: &0xa4951e331eab16415301bc6e4c297cd7e369c3a19871373fb9f8dc92275f77e7::oracle::PriceOracle, arg2: address) : bool {
        user_health_factor(arg0, arg1, arg2) > 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray()
    }

    public fun is_loan(arg0: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg1: u8, arg2: address) : bool {
        let (_, v1) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_user_assets(arg0, arg2);
        let v2 = v1;
        0x1::vector::contains<u8>(&v2, &arg1)
    }

    public fun update_interest_rate(arg0: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg1: u8, arg2: u256) {
        let v0 = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::calculator::calculate_borrow_rate(arg0, arg1, arg2);
        0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::update_interest_rate(arg0, arg1, v0, 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::calculator::calculate_supply_rate(arg0, arg1, v0, arg2));
    }

    public fun update_state(arg0: &0x2::clock::Clock, arg1: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg2: u8) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_last_update_timestamp(arg1, arg2);
        let (_, v3) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_total_supply(arg1, arg2);
        let (v4, v5) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_index(arg1, arg2);
        let (_, _, _, v9, _) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_borrow_rate_factors(arg1, arg2);
        let (v11, v12) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_current_rate(arg1, arg2);
        let v13 = 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::calculator::calculate_compounded_interest(v0, v1, v12), v5);
        let v14 = 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::calculator::calculate_linear_interest(v0, v1, v11), v4);
        0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::update_state(arg1, arg2, v13, v14, v0, 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_div(0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(v3, v13 - v5), v9), v14));
    }

    public fun user_collateral_balance(arg0: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg1: u8, arg2: address) : u256 {
        let (v0, _) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_user_balance(arg0, arg1, arg2);
        let (v2, _) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_index(arg0, arg1);
        0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(v0, v2)
    }

    public fun user_collateral_value(arg0: &0xa4951e331eab16415301bc6e4c297cd7e369c3a19871373fb9f8dc92275f77e7::oracle::PriceOracle, arg1: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg2: u8, arg3: address) : u256 {
        0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::calculator::calculate_value(arg0, user_collateral_balance(arg1, arg2, arg3), arg2)
    }

    public fun user_health_collateral_value(arg0: &0xa4951e331eab16415301bc6e4c297cd7e369c3a19871373fb9f8dc92275f77e7::oracle::PriceOracle, arg1: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg2: address) : u256 {
        let (v0, _) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_user_assets(arg1, arg2);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            let v5 = 0x1::vector::borrow<u8>(&v2, v4);
            let v6 = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_asset_ltv(arg1, *v5);
            let (_, _, v9) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_liquidation_factors(arg1, *v5);
            v3 = v3 + 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(user_collateral_value(arg0, arg1, *v5, arg2), v6), v9);
            v4 = v4 + 1;
        };
        v3
    }

    public fun user_health_factor(arg0: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg1: &0xa4951e331eab16415301bc6e4c297cd7e369c3a19871373fb9f8dc92275f77e7::oracle::PriceOracle, arg2: address) : u256 {
        let v0 = user_health_collateral_value(arg1, arg0, arg2);
        let v1 = user_health_loan_value(arg1, arg0, arg2);
        if (v1 > 0) {
            0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_div(v0, v1)
        } else {
            0x2::address::max()
        }
    }

    public fun user_health_loan_value(arg0: &0xa4951e331eab16415301bc6e4c297cd7e369c3a19871373fb9f8dc92275f77e7::oracle::PriceOracle, arg1: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg2: address) : u256 {
        let (_, v1) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_user_assets(arg1, arg2);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            v3 = v3 + user_loan_value(arg0, arg1, *0x1::vector::borrow<u8>(&v2, v4), arg2);
            v4 = v4 + 1;
        };
        v3
    }

    public fun user_loan_balance(arg0: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg1: u8, arg2: address) : u256 {
        let (_, v1) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_user_balance(arg0, arg1, arg2);
        let (_, v3) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_index(arg0, arg1);
        0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(v1, v3)
    }

    public fun user_loan_value(arg0: &0xa4951e331eab16415301bc6e4c297cd7e369c3a19871373fb9f8dc92275f77e7::oracle::PriceOracle, arg1: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg2: u8, arg3: address) : u256 {
        0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::calculator::calculate_value(arg0, user_loan_balance(arg1, arg2, arg3), arg2)
    }

    // decompiled from Move bytecode v6
}

