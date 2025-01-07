module 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::dynamic_calculator {
    public fun calculate_current_index(arg0: &0x2::clock::Clock, arg1: &mut 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::Storage, arg2: u8) : (u256, u256) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::get_last_update_timestamp(arg1, arg2);
        let (v2, v3) = 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::get_index(arg1, arg2);
        let (v4, v5) = 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::get_current_rate(arg1, arg2);
        (0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::calculator::calculate_compounded_interest(v0, v1, v5), v3), 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::calculator::calculate_linear_interest(v0, v1, v4), v2))
    }

    public fun dynamic_caculate_utilization(arg0: &0x2::clock::Clock, arg1: &mut 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::Storage, arg2: u8) : u256 {
        let (v0, v1) = 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::get_total_supply(arg1, arg2);
        let (v2, v3) = calculate_current_index(arg0, arg1, arg2);
        let v4 = 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v1, v3);
        if (v4 == 0) {
            0
        } else {
            0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_div(v4, 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v0, v2))
        }
    }

    public fun dynamic_calculate_apy(arg0: &0x2::clock::Clock, arg1: &mut 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::Storage, arg2: u8) : (u256, u256) {
        let v0 = dynamic_calculate_borrow_rate(arg0, arg1, arg2);
        (v0, dynamic_calculate_supply_rate(arg0, arg1, arg2, v0))
    }

    public fun dynamic_calculate_borrow_rate(arg0: &0x2::clock::Clock, arg1: &mut 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::Storage, arg2: u8) : u256 {
        let (v0, v1, v2, _, v4) = 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::get_borrow_rate_factors(arg1, arg2);
        let v5 = dynamic_caculate_utilization(arg0, arg1, arg2);
        if (v5 < v4) {
            v0 + 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v5, v1)
        } else {
            v0 + 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v5, v1) + 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v5 - v4, v2)
        }
    }

    public fun dynamic_calculate_supply_rate(arg0: &0x2::clock::Clock, arg1: &mut 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::Storage, arg2: u8, arg3: u256) : u256 {
        let (_, _, _, v3, _) = 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::get_borrow_rate_factors(arg1, arg2);
        0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(arg3, dynamic_caculate_utilization(arg0, arg1, arg2)), 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray() - v3)
    }

    public fun dynamic_health_factor(arg0: &0x2::clock::Clock, arg1: &mut 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::Storage, arg2: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg3: address, arg4: u8, arg5: u64, arg6: u64) : u256 {
        let v0 = dynamic_user_health_collateral_value(arg0, arg2, arg1, arg3);
        let v1 = dynamic_user_health_loan_value(arg0, arg2, arg1, arg3);
        if (v1 > 0) {
            0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_div(v0, v1), dynamic_liquidation_threshold(arg0, arg1, arg2, arg3))
        } else {
            0x2::address::max()
        }
    }

    public fun dynamic_liquidation_threshold(arg0: &0x2::clock::Clock, arg1: &mut 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::Storage, arg2: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg3: address) : u256 {
        let (v0, _) = 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::get_user_assets(arg1, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v6 = 0x1::vector::borrow<u8>(&v2, v3);
            let (_, _, v9) = 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::get_liquidation_factors(arg1, *v6);
            let v10 = dynamic_user_collateral_value(arg0, arg2, arg1, *v6, arg3);
            v5 = v5 + 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v10, v9);
            v4 = v4 + v10;
            v3 = v3 + 1;
        };
        0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_div(v5, v4)
    }

    public fun dynamic_user_collateral_balance(arg0: &0x2::clock::Clock, arg1: &mut 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::Storage, arg2: u8, arg3: address) : u256 {
        let (v0, _) = 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::get_user_balance(arg1, arg2, arg3);
        let (v2, _) = calculate_current_index(arg0, arg1, arg2);
        0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v0, v2)
    }

    public fun dynamic_user_collateral_value(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::Storage, arg3: u8, arg4: address) : u256 {
        0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::calculator::calculate_value(arg1, dynamic_user_collateral_balance(arg0, arg2, arg3, arg4), arg3)
    }

    public fun dynamic_user_health_collateral_value(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::Storage, arg3: address) : u256 {
        let (v0, _) = 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::get_user_assets(arg2, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            let v5 = 0x1::vector::borrow<u8>(&v2, v4);
            let v6 = 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::get_asset_ltv(arg2, *v5);
            v3 = v3 + 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(dynamic_user_collateral_value(arg0, arg1, arg2, *v5, arg3), v6);
            v4 = v4 + 1;
        };
        v3
    }

    public fun dynamic_user_health_loan_value(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::Storage, arg3: address) : u256 {
        let (_, v1) = 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::get_user_assets(arg2, arg3);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            v3 = v3 + dynamic_user_loan_value(arg0, arg1, arg2, *0x1::vector::borrow<u8>(&v2, v4), arg3);
            v4 = v4 + 1;
        };
        v3
    }

    public fun dynamic_user_loan_balance(arg0: &0x2::clock::Clock, arg1: &mut 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::Storage, arg2: u8, arg3: address) : u256 {
        let (_, v1) = 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::get_user_balance(arg1, arg2, arg3);
        let (_, v3) = calculate_current_index(arg0, arg1, arg2);
        0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v1, v3)
    }

    public fun dynamic_user_loan_value(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::storage::Storage, arg3: u8, arg4: address) : u256 {
        0x8b6a4dcb961d65ffe99fdfe65dcfa734f3cadf2df848c30c04569a8461f41252::calculator::calculate_value(arg1, dynamic_user_loan_balance(arg0, arg2, arg3, arg4), arg3)
    }

    // decompiled from Move bytecode v6
}

