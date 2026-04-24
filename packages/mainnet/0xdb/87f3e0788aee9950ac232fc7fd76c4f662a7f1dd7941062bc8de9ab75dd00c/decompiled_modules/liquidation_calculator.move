module 0x53d4342527ee40efb9b96ec0c38d618d3622d9847a56489ae2c27ba322423baa::liquidation_calculator {
    struct LiquidationCalculated has copy, drop {
        user: address,
        collateral_asset: u8,
        debt_asset: u8,
        liquidable_amount_in_collateral: u256,
        liquidable_amount_in_debt: u256,
        executor_bonus_amount: u256,
        treasury_amount: u256,
        executor_excess_amount: u256,
        is_max_loan_value: bool,
    }

    struct LiquidationDebug has copy, drop {
        user: address,
        collateral_asset: u8,
        debt_asset: u8,
        user_collateral_balance: u256,
        user_loan_balance: u256,
        collateral_value: u256,
        loan_value: u256,
        repay_value: u256,
        liquidation_ratio: u256,
        liquidation_bonus: u256,
        treasury_factor: u256,
        health_factor: u256,
        is_healthy: bool,
    }

    public fun calculate_liquidation(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: address, arg4: u8, arg5: u8, arg6: u256) : (u256, u256, u256, u256, u256, bool) {
        let (v0, v1, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg1, arg4);
        let v3 = v1;
        if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_in_emode(arg1, arg3)) {
            let (_, _, v6) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_emode_asset_info(arg1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_emode_id(arg1, arg3), arg4);
            v3 = v6;
        };
        let v7 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_value(arg0, arg2, arg1, arg5, arg3);
        let v8 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg1, arg4);
        let v9 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg1, arg5);
        let v10 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg0, arg2, arg6, v9);
        let v11 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg0, arg2, arg1, arg4, arg3), v0);
        let v12 = v11;
        let v13 = false;
        let v14 = if (v10 >= v11) {
            v10 - v11
        } else {
            v12 = v10;
            0
        };
        if (v12 >= v7) {
            v13 = true;
            v12 = v7;
            v14 = v10 - v7;
        };
        let v15 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v12, v3);
        let v16 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v15, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_treasury_factor(arg1, arg4));
        let v17 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg2, v12, v8);
        let v18 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg2, v12, v9);
        let v19 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg2, v15 - v16, v8);
        let v20 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg2, v16, v8);
        let v21 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg2, v14, v9);
        let v22 = LiquidationCalculated{
            user                            : arg3,
            collateral_asset                : arg4,
            debt_asset                      : arg5,
            liquidable_amount_in_collateral : v17,
            liquidable_amount_in_debt       : v18,
            executor_bonus_amount           : v19,
            treasury_amount                 : v20,
            executor_excess_amount          : v21,
            is_max_loan_value               : v13,
        };
        0x2::event::emit<LiquidationCalculated>(v22);
        (v17, v18, v19, v20, v21, v13)
    }

    entry fun inspect_liquidation(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: address, arg4: u8, arg5: u8, arg6: u256) {
        let (v0, v1, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg1, arg4);
        let v3 = v1;
        if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_in_emode(arg1, arg3)) {
            let (_, _, v6) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_emode_asset_info(arg1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_emode_id(arg1, arg3), arg4);
            v3 = v6;
        };
        let v7 = LiquidationDebug{
            user                    : arg3,
            collateral_asset        : arg4,
            debt_asset              : arg5,
            user_collateral_balance : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg1, arg4, arg3),
            user_loan_balance       : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg1, arg5, arg3),
            collateral_value        : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg0, arg2, arg1, arg4, arg3),
            loan_value              : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_value(arg0, arg2, arg1, arg5, arg3),
            repay_value             : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg0, arg2, arg6, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg1, arg5)),
            liquidation_ratio       : v0,
            liquidation_bonus       : v3,
            treasury_factor         : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_treasury_factor(arg1, arg4),
            health_factor           : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor(arg0, arg1, arg2, arg3),
            is_healthy              : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg0, arg2, arg1, arg3),
        };
        0x2::event::emit<LiquidationDebug>(v7);
        let (_, _, _, _, _, _) = calculate_liquidation(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v7
}

