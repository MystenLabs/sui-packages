module 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault_pro {
    struct ProLiquidated has copy, drop {
        vault_id: 0x2::object::ID,
        manager_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        repay_in: u64,
        base_out: u64,
        quote_out: u64,
        repay_remaining: u64,
        base_debt: bool,
    }

    struct ProAtomicFlashResult has copy, drop {
        vault_id: 0x2::object::ID,
        manager_id: 0x2::object::ID,
        debt_side: u8,
        flash_raw: u64,
        flash_due_raw: u64,
        profit_raw: u64,
    }

    struct ProAtomicDeepBookFlashResult has copy, drop {
        vault_id: 0x2::object::ID,
        manager_id: 0x2::object::ID,
        debt_side: u8,
        flash_raw: u64,
        profit_raw: u64,
    }

    public fun liquidate_base_pro<T0, T1>(arg0: &mut 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::TraderCap, arg9: 0x1::option::Option<u64>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : bool {
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_assert_trader(arg0, arg8);
        liquidate_base_pro_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg11)
    }

    public fun liquidate_base_pro_authorized<T0, T1>(arg0: &mut 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: 0x1::option::Option<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : bool {
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_assert_authorized(arg0, arg10);
        liquidate_base_pro_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    fun liquidate_base_pro_core<T0, T1>(arg0: &mut 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: 0x1::option::Option<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : bool {
        if (!0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::has_base_debt<T0, T1>(arg1)) {
            return false
        };
        if (!0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::can_liquidate(arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg4), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager_upgraded::risk_ratio<T0, T1>(arg1, arg5, arg6, arg7, arg4, arg2, arg3, arg9))) {
            return false
        };
        let v0 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::bounded_repay(arg8, 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T0>(arg0));
        if (v0 < 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_constants::min_liquidation_repay()) {
            return false
        };
        let (v1, v2, v3) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager_upgraded::liquidate<T0, T1, T0>(arg1, arg5, arg6, arg7, arg2, arg4, 0x2::coin::from_balance<T0>(0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_withdraw_balance<T0>(arg0, v0), arg10), arg9, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        0x2::coin::join<T0>(&mut v6, v4);
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v6));
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_deposit_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v5));
        let v7 = ProLiquidated{
            vault_id        : 0x2::object::id<0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault>(arg0),
            manager_id      : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::id<T0, T1>(arg1),
            margin_pool_id  : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::id<T0>(arg2),
            repay_in        : v0,
            base_out        : 0x2::coin::value<T0>(&v6),
            quote_out       : 0x2::coin::value<T1>(&v5),
            repay_remaining : 0x2::coin::value<T0>(&v4),
            base_debt       : true,
        };
        0x2::event::emit<ProLiquidated>(v7);
        true
    }

    public fun liquidate_base_pro_deepbook_flash_authorized<T0, T1>(arg0: &mut 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_assert_authorized(arg0, arg12);
        let v0 = 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg1);
        let v1 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T0>(arg0);
        let v2 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T1>(arg0);
        let v3 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager_upgraded::risk_ratio<T0, T1>(arg1, arg5, arg6, arg7, arg4, arg2, arg3, arg11);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::can_liquidate(arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg4), v3), 4);
        let (v4, v5) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::calculate_debts<T0, T1, T0>(arg1, arg2, arg11);
        assert!(v4 > 0 && v5 == 0, 4);
        let v6 = 0x1::u64::min(0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::quote_flash_repay(v4, v3, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::target_liquidation_risk_ratio(arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg4)), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::user_liquidation_reward(arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg4)), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::pool_liquidation_reward(arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg4))), arg8);
        assert!(v6 >= 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_constants::min_liquidation_repay(), 4);
        let (v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg4, v6, arg12);
        let v9 = v7;
        let v10 = 0x2::coin::value<T0>(&v9);
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v9));
        assert!(liquidate_base_pro_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::option::some<u64>(v6), arg11, arg12), 4);
        let v11 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T1>(arg0);
        assert!(v11 > v2, 4);
        assert!(0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_rebalance_quote_to_base_core<T0, T1>(arg0, arg4, v11 - v2, arg9, arg11, arg12), 5);
        assert!(v10 <= 18446744073709551615 - arg10, 5);
        assert!(v1 <= 18446744073709551615 - v10 - arg10, 5);
        let v12 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T0>(arg0);
        assert!(v12 >= v1 + v10 + arg10, 5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg4, 0x2::coin::from_balance<T0>(0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_withdraw_balance<T0>(arg0, v10), arg12), v8);
        let v13 = ProAtomicDeepBookFlashResult{
            vault_id   : 0x2::object::id<0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault>(arg0),
            manager_id : v0,
            debt_side  : 0,
            flash_raw  : v10,
            profit_raw : v12 - v1 - v10,
        };
        0x2::event::emit<ProAtomicDeepBookFlashResult>(v13);
    }

    public fun liquidate_base_pro_scallop_flash_authorized<T0, T1>(arg0: &mut 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_assert_authorized(arg0, arg14);
        let v0 = 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg3);
        let v1 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T0>(arg0);
        let v2 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T1>(arg0);
        let v3 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager_upgraded::risk_ratio<T0, T1>(arg3, arg7, arg8, arg9, arg6, arg4, arg5, arg13);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::can_liquidate(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6), v3), 4);
        let (v4, v5) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::calculate_debts<T0, T1, T0>(arg3, arg4, arg13);
        assert!(v4 > 0 && v5 == 0, 4);
        let v6 = 0x1::u64::min(0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::quote_flash_repay(v4, v3, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::target_liquidation_risk_ratio(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6)), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::user_liquidation_reward(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6)), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::pool_liquidation_reward(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6))), arg10);
        assert!(v6 >= 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_constants::min_liquidation_repay(), 4);
        let (v7, v8) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T0>(arg1, arg2, v6, arg14);
        let v9 = v8;
        let v10 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&v9);
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v7));
        assert!(liquidate_base_pro_core<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x1::option::some<u64>(v10), arg13, arg14), 4);
        let v11 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T1>(arg0);
        assert!(v11 > v2, 4);
        assert!(0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_rebalance_quote_to_base_core<T0, T1>(arg0, arg6, v11 - v2, arg11, arg13, arg14), 5);
        let v12 = v10 + 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&v9);
        assert!(v12 <= 18446744073709551615 - arg12, 5);
        assert!(v1 <= 18446744073709551615 - v12 - arg12, 5);
        let v13 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T0>(arg0);
        assert!(v13 >= v1 + v12 + arg12, 5);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_withdraw_balance<T0>(arg0, v12), arg14), v9, arg14);
        let v14 = ProAtomicFlashResult{
            vault_id      : 0x2::object::id<0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault>(arg0),
            manager_id    : v0,
            debt_side     : 0,
            flash_raw     : v10,
            flash_due_raw : v12,
            profit_raw    : v13 - v1 - v12,
        };
        0x2::event::emit<ProAtomicFlashResult>(v14);
    }

    public fun liquidate_quote_pro<T0, T1>(arg0: &mut 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::TraderCap, arg9: 0x1::option::Option<u64>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : bool {
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_assert_trader(arg0, arg8);
        liquidate_quote_pro_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg11)
    }

    public fun liquidate_quote_pro_authorized<T0, T1>(arg0: &mut 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: 0x1::option::Option<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : bool {
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_assert_authorized(arg0, arg10);
        liquidate_quote_pro_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    fun liquidate_quote_pro_core<T0, T1>(arg0: &mut 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: 0x1::option::Option<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : bool {
        if (0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::has_base_debt<T0, T1>(arg1)) {
            return false
        };
        if (!0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::can_liquidate(arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg4), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager_upgraded::risk_ratio<T0, T1>(arg1, arg5, arg6, arg7, arg4, arg2, arg3, arg9))) {
            return false
        };
        let v0 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::bounded_repay(arg8, 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T1>(arg0));
        if (v0 < 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_constants::min_liquidation_repay()) {
            return false
        };
        let (v1, v2, v3) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager_upgraded::liquidate<T0, T1, T1>(arg1, arg5, arg6, arg7, arg3, arg4, 0x2::coin::from_balance<T1>(0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_withdraw_balance<T1>(arg0, v0), arg10), arg9, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        0x2::coin::join<T1>(&mut v5, v4);
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v6));
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_deposit_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v5));
        let v7 = ProLiquidated{
            vault_id        : 0x2::object::id<0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault>(arg0),
            manager_id      : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::id<T0, T1>(arg1),
            margin_pool_id  : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::id<T1>(arg3),
            repay_in        : v0,
            base_out        : 0x2::coin::value<T0>(&v6),
            quote_out       : 0x2::coin::value<T1>(&v5),
            repay_remaining : 0x2::coin::value<T1>(&v4),
            base_debt       : false,
        };
        0x2::event::emit<ProLiquidated>(v7);
        true
    }

    public fun liquidate_quote_pro_deepbook_flash_authorized<T0, T1>(arg0: &mut 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_assert_authorized(arg0, arg12);
        let v0 = 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg1);
        let v1 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T1>(arg0);
        let v2 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T0>(arg0);
        let v3 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager_upgraded::risk_ratio<T0, T1>(arg1, arg5, arg6, arg7, arg4, arg2, arg3, arg11);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::can_liquidate(arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg4), v3), 4);
        let (v4, v5) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::calculate_debts<T0, T1, T1>(arg1, arg3, arg11);
        assert!(v4 == 0 && v5 > 0, 4);
        let v6 = 0x1::u64::min(0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::quote_flash_repay(v5, v3, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::target_liquidation_risk_ratio(arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg4)), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::user_liquidation_reward(arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg4)), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::pool_liquidation_reward(arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg4))), arg8);
        assert!(v6 >= 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_constants::min_liquidation_repay(), 4);
        let (v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg4, v6, arg12);
        let v9 = v7;
        let v10 = 0x2::coin::value<T1>(&v9);
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_deposit_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v9));
        assert!(liquidate_quote_pro_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::option::some<u64>(v6), arg11, arg12), 4);
        let v11 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T0>(arg0);
        assert!(v11 > v2, 4);
        assert!(0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_rebalance_base_to_quote_core<T0, T1>(arg0, arg4, v11 - v2, arg9, arg11, arg12), 5);
        assert!(v10 <= 18446744073709551615 - arg10, 5);
        assert!(v1 <= 18446744073709551615 - v10 - arg10, 5);
        let v12 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T1>(arg0);
        assert!(v12 >= v1 + v10 + arg10, 5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg4, 0x2::coin::from_balance<T1>(0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_withdraw_balance<T1>(arg0, v10), arg12), v8);
        let v13 = ProAtomicDeepBookFlashResult{
            vault_id   : 0x2::object::id<0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault>(arg0),
            manager_id : v0,
            debt_side  : 1,
            flash_raw  : v10,
            profit_raw : v12 - v1 - v10,
        };
        0x2::event::emit<ProAtomicDeepBookFlashResult>(v13);
    }

    public fun liquidate_quote_pro_scallop_flash_authorized<T0, T1>(arg0: &mut 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg5: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_assert_authorized(arg0, arg14);
        let v0 = 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg3);
        let v1 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T1>(arg0);
        let v2 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T0>(arg0);
        let v3 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager_upgraded::risk_ratio<T0, T1>(arg3, arg7, arg8, arg9, arg6, arg4, arg5, arg13);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::can_liquidate(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6), v3), 4);
        let (v4, v5) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::calculate_debts<T0, T1, T1>(arg3, arg5, arg13);
        assert!(v4 == 0 && v5 > 0, 4);
        let v6 = 0x1::u64::min(0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::quote_flash_repay(v5, v3, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::target_liquidation_risk_ratio(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6)), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::user_liquidation_reward(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6)), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::pool_liquidation_reward(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6))), arg10);
        assert!(v6 >= 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_constants::min_liquidation_repay(), 4);
        let (v7, v8) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T1>(arg1, arg2, v6, arg14);
        let v9 = v8;
        let v10 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T1>(&v9);
        0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_deposit_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v7));
        assert!(liquidate_quote_pro_core<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x1::option::some<u64>(v10), arg13, arg14), 4);
        let v11 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T0>(arg0);
        assert!(v11 > v2, 4);
        assert!(0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_rebalance_base_to_quote_core<T0, T1>(arg0, arg6, v11 - v2, arg11, arg13, arg14), 5);
        let v12 = v10 + 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T1>(&v9);
        assert!(v12 <= 18446744073709551615 - arg12, 5);
        assert!(v1 <= 18446744073709551615 - v12 - arg12, 5);
        let v13 = 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::balance<T1>(arg0);
        assert!(v13 >= v1 + v12 + arg12, 5);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T1>(arg1, arg2, 0x2::coin::from_balance<T1>(0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::pro_withdraw_balance<T1>(arg0, v12), arg14), v9, arg14);
        let v14 = ProAtomicFlashResult{
            vault_id      : 0x2::object::id<0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault::LiquidationVault>(arg0),
            manager_id    : v0,
            debt_side     : 1,
            flash_raw     : v10,
            flash_due_raw : v12,
            profit_raw    : v13 - v1 - v12,
        };
        0x2::event::emit<ProAtomicFlashResult>(v14);
    }

    // decompiled from Move bytecode v7
}

