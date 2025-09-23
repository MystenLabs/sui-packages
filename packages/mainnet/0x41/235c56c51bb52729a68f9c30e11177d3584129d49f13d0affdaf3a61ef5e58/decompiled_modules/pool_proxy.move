module 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::pool_proxy {
    public fun cancel_all_orders<T0, T1>(arg0: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::MarginRegistry, arg1: &mut 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::MarginManager<T0, T1>, arg2: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::load_inner(arg0);
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::deepbook_pool<T0, T1>(arg1) == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::trade_proof<T0, T1>(arg1, arg4);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::cancel_all_orders<T0, T1>(arg2, 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg4), &v0, arg3, arg4);
    }

    public fun cancel_order<T0, T1>(arg0: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::MarginRegistry, arg1: &mut 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::MarginManager<T0, T1>, arg2: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::load_inner(arg0);
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::deepbook_pool<T0, T1>(arg1) == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::trade_proof<T0, T1>(arg1, arg5);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::cancel_order<T0, T1>(arg2, 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg5), &v0, arg3, arg4, arg5);
    }

    public fun cancel_orders<T0, T1>(arg0: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::MarginRegistry, arg1: &mut 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::MarginManager<T0, T1>, arg2: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg3: vector<u128>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::load_inner(arg0);
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::deepbook_pool<T0, T1>(arg1) == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::trade_proof<T0, T1>(arg1, arg5);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::cancel_orders<T0, T1>(arg2, 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg5), &v0, arg3, arg4, arg5);
    }

    public fun claim_rebates<T0, T1>(arg0: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::MarginRegistry, arg1: &mut 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::MarginManager<T0, T1>, arg2: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::load_inner(arg0);
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::deepbook_pool<T0, T1>(arg1) == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::trade_proof<T0, T1>(arg1, arg3);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::claim_rebates<T0, T1>(arg2, 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg3), &v0, arg3);
    }

    public fun modify_order<T0, T1>(arg0: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::MarginRegistry, arg1: &mut 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::MarginManager<T0, T1>, arg2: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::load_inner(arg0);
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::deepbook_pool<T0, T1>(arg1) == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::trade_proof<T0, T1>(arg1, arg6);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::modify_order<T0, T1>(arg2, 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg6), &v0, arg3, arg4, arg5, arg6);
    }

    public fun place_limit_order<T0, T1>(arg0: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::MarginRegistry, arg1: &mut 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::MarginManager<T0, T1>, arg2: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::order_info::OrderInfo {
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::deepbook_pool<T0, T1>(arg1) == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::trade_proof<T0, T1>(arg1, arg12);
        let v1 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg12);
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::pool_enabled<T0, T1>(arg0, arg2), 2);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::place_limit_order<T0, T1>(arg2, v1, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun place_market_order<T0, T1>(arg0: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::MarginRegistry, arg1: &mut 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::MarginManager<T0, T1>, arg2: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg3: u64, arg4: u8, arg5: u64, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::order_info::OrderInfo {
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::deepbook_pool<T0, T1>(arg1) == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::trade_proof<T0, T1>(arg1, arg9);
        let v1 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg9);
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::pool_enabled<T0, T1>(arg0, arg2), 2);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::place_market_order<T0, T1>(arg2, v1, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun place_reduce_only_limit_order<T0, T1, T2>(arg0: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::MarginRegistry, arg1: &mut 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::MarginManager<T0, T1>, arg2: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg3: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_pool::MarginPool<T2>, arg4: u64, arg5: u8, arg6: u8, arg7: u64, arg8: u64, arg9: bool, arg10: bool, arg11: u64, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::order_info::OrderInfo {
        0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::load_inner(arg0);
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::deepbook_pool<T0, T1>(arg1) == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg2), 4);
        0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::assert_place_reduce_only<T0, T1, T2>(arg1, arg3, arg9);
        let v0 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::trade_proof<T0, T1>(arg1, arg13);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::place_limit_order<T0, T1>(arg2, 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg13), &v0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun place_reduce_only_market_order<T0, T1, T2>(arg0: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::MarginRegistry, arg1: &mut 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::MarginManager<T0, T1>, arg2: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg3: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_pool::MarginPool<T2>, arg4: u64, arg5: u8, arg6: u64, arg7: bool, arg8: bool, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::order_info::OrderInfo {
        0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::load_inner(arg0);
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::deepbook_pool<T0, T1>(arg1) == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg2), 4);
        0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::assert_place_reduce_only<T0, T1, T2>(arg1, arg3, arg7);
        let v0 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::trade_proof<T0, T1>(arg1, arg10);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::place_market_order<T0, T1>(arg2, 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg10), &v0, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun stake<T0, T1>(arg0: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::MarginRegistry, arg1: &mut 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::MarginManager<T0, T1>, arg2: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::load_inner(arg0);
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::deepbook_pool<T0, T1>(arg1) == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x1::type_name::with_defining_ids<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>();
        assert!(0x1::type_name::with_defining_ids<T0>() != v0 && 0x1::type_name::with_defining_ids<T1>() != v0, 1);
        let v1 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::trade_proof<T0, T1>(arg1, arg4);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::stake<T0, T1>(arg2, 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg4), &v1, arg3, arg4);
    }

    public fun submit_proposal<T0, T1>(arg0: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::MarginRegistry, arg1: &mut 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::MarginManager<T0, T1>, arg2: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::load_inner(arg0);
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::deepbook_pool<T0, T1>(arg1) == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::trade_proof<T0, T1>(arg1, arg6);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::submit_proposal<T0, T1>(arg2, 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg6), &v0, arg3, arg4, arg5, arg6);
    }

    public fun unstake<T0, T1>(arg0: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::MarginRegistry, arg1: &mut 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::MarginManager<T0, T1>, arg2: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::load_inner(arg0);
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::deepbook_pool<T0, T1>(arg1) == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::trade_proof<T0, T1>(arg1, arg3);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::unstake<T0, T1>(arg2, 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg3), &v0, arg3);
    }

    public fun vote<T0, T1>(arg0: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::MarginRegistry, arg1: &mut 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::MarginManager<T0, T1>, arg2: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) {
        0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::load_inner(arg0);
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::deepbook_pool<T0, T1>(arg1) == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::trade_proof<T0, T1>(arg1, arg4);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::vote<T0, T1>(arg2, 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg4), &v0, arg3, arg4);
    }

    public fun withdraw_settled_amounts<T0, T1>(arg0: &0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::MarginRegistry, arg1: &mut 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::MarginManager<T0, T1>, arg2: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_registry::load_inner(arg0);
        assert!(0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::deepbook_pool<T0, T1>(arg1) == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg2), 4);
        let v0 = 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::trade_proof<T0, T1>(arg1, arg3);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::withdraw_settled_amounts<T0, T1>(arg2, 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_manager::balance_manager_trading_mut<T0, T1>(arg1, arg3), &v0);
    }

    // decompiled from Move bytecode v6
}

