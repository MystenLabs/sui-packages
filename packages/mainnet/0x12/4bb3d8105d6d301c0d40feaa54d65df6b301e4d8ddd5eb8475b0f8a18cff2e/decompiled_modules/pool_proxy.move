module 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy {
    public fun cancel_all_orders<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::load_inner(arg0);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::trade_proof<T0, T1>(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg4), &v0, arg3, arg4);
    }

    public fun cancel_order<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::load_inner(arg0);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::trade_proof<T0, T1>(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg2, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg5), &v0, arg3, arg4, arg5);
    }

    public fun cancel_orders<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: vector<u128>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::load_inner(arg0);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::trade_proof<T0, T1>(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_orders<T0, T1>(arg2, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg5), &v0, arg3, arg4, arg5);
    }

    public fun claim_rebates<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::load_inner(arg0);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::trade_proof<T0, T1>(arg1, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::claim_rebates<T0, T1>(arg2, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg3), &v0, arg3);
    }

    public fun modify_order<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::load_inner(arg0);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::trade_proof<T0, T1>(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::modify_order<T0, T1>(arg2, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg6), &v0, arg3, arg4, arg5, arg6);
    }

    public fun place_limit_order<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        abort 8
    }

    public fun place_market_order<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u8, arg5: u64, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        abort 8
    }

    public fun stake<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::load_inner(arg0);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x1::type_name::with_defining_ids<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>();
        assert!(0x1::type_name::with_defining_ids<T0>() != v0 && 0x1::type_name::with_defining_ids<T1>() != v0, 1);
        let v1 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::trade_proof<T0, T1>(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::stake<T0, T1>(arg2, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg4), &v1, arg3, arg4);
    }

    public fun submit_proposal<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::load_inner(arg0);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::trade_proof<T0, T1>(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::submit_proposal<T0, T1>(arg2, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg6), &v0, arg3, arg4, arg5, arg6);
    }

    public fun unstake<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::load_inner(arg0);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::trade_proof<T0, T1>(arg1, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::unstake<T0, T1>(arg2, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg3), &v0, arg3);
    }

    public fun vote<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::load_inner(arg0);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::trade_proof<T0, T1>(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::vote<T0, T1>(arg2, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg4), &v0, arg3, arg4);
    }

    public fun withdraw_settled_amounts<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::load_inner(arg0);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::trade_proof<T0, T1>(arg1, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg3), &v0);
    }

    public fun update_current_price<T0, T1>(arg0: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::update_current_price(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg1), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::oracle::calculate_price<T0, T1>(arg0, arg2, arg3, arg4), arg4);
    }

    fun assert_post_trade_solvent<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x2::clock::Clock) {
        if (0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::borrowed_base_shares<T0, T1>(arg0) == 0 && 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::borrowed_quote_shares<T0, T1>(arg0) == 0) {
            return
        };
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::risk_ratio<T0, T1>(arg0, arg1, arg5, arg6, arg2, arg3, arg4, arg7) >= 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::min_borrow_risk_ratio(arg1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2)), 6);
    }

    fun assert_reduce_only_monotonic<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x2::clock::Clock, arg8: u64) {
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::risk_ratio<T0, T1>(arg0, arg1, arg5, arg6, arg2, arg3, arg4, arg7) >= arg8, 7);
    }

    fun calculate_effective_price<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: bool, arg4: &0x2::clock::Clock) : (u64, u64) {
        if (arg2) {
            let (v2, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_in<T0, T1>(arg0, arg1, arg3, arg4);
            assert!(v2 > 0, 5);
            (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(v3, v2), v3)
        } else {
            let (v5, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, arg1, arg4);
            let v8 = arg1 - v5;
            assert!(v8 > 0, 5);
            (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(v6, v8), v6)
        }
    }

    public fun place_limit_order_v2<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: u8, arg9: u8, arg10: u64, arg11: u64, arg12: bool, arg13: bool, arg14: u64, arg15: &0x2::clock::Clock, arg16: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), 4);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::pool_enabled<T0, T1>(arg0, arg2), 2);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::assert_price(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), arg10, arg12, arg15);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::trade_proof<T0, T1>(arg1, arg16);
        assert_post_trade_solvent<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg5, arg6, arg15);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg2, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg16), &v0, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::clamp_expire_timestamp(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), arg14, arg15), arg15, arg16)
    }

    public fun place_market_order_v2<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: u8, arg9: u64, arg10: bool, arg11: bool, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), 4);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::pool_enabled<T0, T1>(arg0, arg2), 2);
        let (v0, _) = calculate_effective_price<T0, T1>(arg2, arg9, arg10, arg11, arg12);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::assert_price(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), v0, arg10, arg12);
        let v2 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::trade_proof<T0, T1>(arg1, arg13);
        assert_post_trade_solvent<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg5, arg6, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg2, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg13), &v2, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun place_reduce_only_limit_order<T0, T1, T2>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T2>, arg4: u64, arg5: u8, arg6: u8, arg7: u64, arg8: u64, arg9: bool, arg10: bool, arg11: u64, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        abort 8
    }

    public fun place_reduce_only_limit_order_v2<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: u8, arg9: u8, arg10: u64, arg11: u64, arg12: bool, arg13: bool, arg14: u64, arg15: &0x2::clock::Clock, arg16: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::load_inner(arg0);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), 4);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::assert_price(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), arg10, arg12, arg15);
        let (v0, v1) = if (0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::has_base_debt<T0, T1>(arg1)) {
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::calculate_debts<T0, T1, T0>(arg1, arg3, arg15)
        } else {
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::calculate_debts<T0, T1, T1>(arg1, arg4, arg15)
        };
        let (v2, v3) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::calculate_assets<T0, T1>(arg1, arg2);
        let v4 = if (arg12) {
            if (v0 > v2) {
                arg11 <= v0 - v2
            } else {
                false
            }
        } else {
            false
        };
        let v5 = if (v4) {
            true
        } else if (!arg12) {
            if (v1 > v3) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(arg11, arg10) <= v1 - v3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 3);
        let v6 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::trade_proof<T0, T1>(arg1, arg16);
        assert_reduce_only_monotonic<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg5, arg6, arg15, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::risk_ratio<T0, T1>(arg1, arg0, arg5, arg6, arg2, arg3, arg4, arg15));
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg2, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg16), &v6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::clamp_expire_timestamp(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), arg14, arg15), arg15, arg16)
    }

    public fun place_reduce_only_market_order<T0, T1, T2>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T2>, arg4: u64, arg5: u8, arg6: u64, arg7: bool, arg8: bool, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        abort 8
    }

    public fun place_reduce_only_market_order_v2<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: u8, arg9: u64, arg10: bool, arg11: bool, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::load_inner(arg0);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deepbook_pool<T0, T1>(arg1) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), 4);
        let (v0, v1) = if (0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::has_base_debt<T0, T1>(arg1)) {
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::calculate_debts<T0, T1, T0>(arg1, arg3, arg12)
        } else {
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::calculate_debts<T0, T1, T1>(arg1, arg4, arg12)
        };
        let (v2, v3) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::calculate_assets<T0, T1>(arg1, arg2);
        let (v4, v5) = calculate_effective_price<T0, T1>(arg2, arg9, arg10, arg11, arg12);
        let v6 = if (arg10) {
            if (v0 > v2) {
                arg9 <= v0 - v2
            } else {
                false
            }
        } else {
            false
        };
        let v7 = if (v6) {
            true
        } else if (!arg10) {
            if (v1 > v3) {
                v5 <= v1 - v3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 3);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::assert_price(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), v4, arg10, arg12);
        let v8 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::trade_proof<T0, T1>(arg1, arg13);
        assert_reduce_only_monotonic<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg5, arg6, arg12, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::risk_ratio<T0, T1>(arg1, arg0, arg5, arg6, arg2, arg3, arg4, arg12));
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg2, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg13), &v8, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun withdraw_settled_amounts_permissionless<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::load_inner(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::withdraw_settled_amounts_permissionless_int<T0, T1>(arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

