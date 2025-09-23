module 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::pool_proxy {
    public fun cancel_all_orders<T0, T1>(arg0: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg0);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg2), 4);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::trade_proof<T0, T1>(arg1, arg4);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::cancel_all_orders<T0, T1>(arg2, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg4), &v0, arg3, arg4);
    }

    public fun cancel_order<T0, T1>(arg0: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg0);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg2), 4);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::trade_proof<T0, T1>(arg1, arg5);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::cancel_order<T0, T1>(arg2, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg5), &v0, arg3, arg4, arg5);
    }

    public fun cancel_orders<T0, T1>(arg0: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg3: vector<u128>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg0);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg2), 4);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::trade_proof<T0, T1>(arg1, arg5);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::cancel_orders<T0, T1>(arg2, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg5), &v0, arg3, arg4, arg5);
    }

    public fun claim_rebates<T0, T1>(arg0: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg0);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg2), 4);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::trade_proof<T0, T1>(arg1, arg3);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::claim_rebates<T0, T1>(arg2, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg3), &v0, arg3);
    }

    public fun modify_order<T0, T1>(arg0: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg0);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg2), 4);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::trade_proof<T0, T1>(arg1, arg6);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::modify_order<T0, T1>(arg2, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg6), &v0, arg3, arg4, arg5, arg6);
    }

    public fun place_limit_order<T0, T1>(arg0: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) : 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::order_info::OrderInfo {
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg2), 4);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::trade_proof<T0, T1>(arg1, arg12);
        let v1 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg12);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::pool_enabled<T0, T1>(arg0, arg2), 2);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::place_limit_order<T0, T1>(arg2, v1, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun place_market_order<T0, T1>(arg0: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg3: u64, arg4: u8, arg5: u64, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::order_info::OrderInfo {
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg2), 4);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::trade_proof<T0, T1>(arg1, arg9);
        let v1 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg9);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::pool_enabled<T0, T1>(arg0, arg2), 2);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::place_market_order<T0, T1>(arg2, v1, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun stake<T0, T1>(arg0: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg0);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x1::type_name::with_defining_ids<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>();
        assert!(0x1::type_name::with_defining_ids<T0>() != v0 && 0x1::type_name::with_defining_ids<T1>() != v0, 1);
        let v1 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::trade_proof<T0, T1>(arg1, arg4);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::stake<T0, T1>(arg2, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg4), &v1, arg3, arg4);
    }

    public fun submit_proposal<T0, T1>(arg0: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg0);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg2), 4);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::trade_proof<T0, T1>(arg1, arg6);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::submit_proposal<T0, T1>(arg2, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg6), &v0, arg3, arg4, arg5, arg6);
    }

    public fun unstake<T0, T1>(arg0: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg0);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg2), 4);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::trade_proof<T0, T1>(arg1, arg3);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::unstake<T0, T1>(arg2, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg3), &v0, arg3);
    }

    public fun vote<T0, T1>(arg0: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg0);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg2), 4);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::trade_proof<T0, T1>(arg1, arg4);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::vote<T0, T1>(arg2, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg4), &v0, arg3, arg4);
    }

    public fun withdraw_settled_amounts<T0, T1>(arg0: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg0);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg2), 4);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::trade_proof<T0, T1>(arg1, arg3);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::withdraw_settled_amounts<T0, T1>(arg2, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg3), &v0);
    }

    public fun place_reduce_only_limit_order<T0, T1, T2>(arg0: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg3: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::MarginPool<T2>, arg4: u64, arg5: u8, arg6: u8, arg7: u64, arg8: u64, arg9: bool, arg10: bool, arg11: u64, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) : 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::order_info::OrderInfo {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg0);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg2), 4);
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::assert_place_reduce_only<T0, T1, T2>(arg1, arg3, arg9);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::trade_proof<T0, T1>(arg1, arg13);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::place_limit_order<T0, T1>(arg2, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg13), &v0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun place_reduce_only_market_order<T0, T1, T2>(arg0: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg3: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::MarginPool<T2>, arg4: u64, arg5: u8, arg6: u64, arg7: bool, arg8: bool, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::order_info::OrderInfo {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg0);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg2), 4);
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::assert_place_reduce_only<T0, T1, T2>(arg1, arg3, arg7);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::trade_proof<T0, T1>(arg1, arg10);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::place_market_order<T0, T1>(arg2, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg10), &v0, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    // decompiled from Move bytecode v6
}

