module 0x6747499c1aa28b025252e2db891598080cc2548fe8152370d789bb9ebf3c620f::lp_bluefin {
    struct BluefinWitness has drop {
        dummy_field: bool,
    }

    public(friend) fun mint_proxy_cap(arg0: &0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::Registry) : 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::ProxyCap {
        0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::mint_proxy_cap<BluefinWitness>(arg0, init_witness())
    }

    public fun compound<T0, T1>(arg0: &0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::Registry, arg1: &mut 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::lp_registry::Collector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3);
        let (v1, v2) = if (0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::contains_keeper(arg0, 0x2::tx_context::sender(arg10))) {
            let v1 = 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::auto_compound_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg3));
            (v1, 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::constants::auto_compound_source())
        } else {
            let v1 = 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::compound_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg3));
            (v1, 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::constants::compound_source())
        };
        let (v3, v4, v5, v6) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), 0x2::coin::into_balance<T1>(arg6), v2, v1, arg9);
        0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::assert_price(arg0, v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3));
        assert!(v3 >= arg7 && v4 >= arg8, 1);
        let v7 = mint_proxy_cap(arg0);
        0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::events::emit_compounded(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg4), v3, v4, &v7);
        (0x2::coin::from_balance<T0>(v5, arg10), 0x2::coin::from_balance<T1>(v6, arg10))
    }

    fun init_witness() : BluefinWitness {
        BluefinWitness{dummy_field: false}
    }

    fun liquidity_for_amounts(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u128 {
        if (arg0 <= arg1) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_from_a(arg1, arg2, arg3, false)
        } else if (arg0 >= arg2) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_from_b(arg1, arg2, arg4, false)
        } else {
            0x1::u128::min(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_from_a(arg0, arg2, arg3, false), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_from_b(arg1, arg0, arg4, false))
        }
    }

    public fun rebalance<T0, T1>(arg0: &0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::Registry, arg1: &mut 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::lp_registry::Collector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg5: 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::state::RebalanceReceipt, arg6: u32, arg7: u32, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) {
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::is_empty(&arg4), 2);
        let (v0, v1) = if (0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::contains_keeper(arg0, 0x2::tx_context::sender(arg13))) {
            let v0 = 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::auto_rebalance_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg3));
            (v0, 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::constants::auto_rebalance_source())
        } else {
            let v0 = 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::rebalance_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg3));
            (v0, 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::constants::rebalance_source())
        };
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg3, arg6, arg7, arg13);
        let v3 = &mut v2;
        let (v4, v5, v6, v7) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, v3, 0x2::coin::into_balance<T0>(arg8), 0x2::coin::into_balance<T1>(arg9), v1, v0, arg12);
        assert!(v4 >= arg10 && v5 >= arg11, 1);
        let v8 = mint_proxy_cap(arg0);
        let (v9, v10, v11, v12, v13) = 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::state::destroy_rebalance_receipt(arg5, &v8);
        assert!(0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::math::get_liquidity_in_y(v4, v5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3)) >= v13, 1);
        0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::assert_price(arg0, v12, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3));
        0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::events::emit_rebalanced(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), v9, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v2), v10, v11, v4, v5, v12, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3), &v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg12, arg2, arg3, arg4);
        (0x2::coin::from_balance<T0>(v6, arg13), 0x2::coin::from_balance<T1>(v7, arg13), v2)
    }

    public fun start_rebalance<T0, T1>(arg0: &0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::state::RebalanceReceipt, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = mint_proxy_cap(arg0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg3);
        let (v2, v3, v4, v5) = if (v1 > 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg2, arg3, v1, arg5)
        } else {
            (0, 0, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        (0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::state::new_rebalance_receipt(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg3), v2, v3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), arg4, &v0), 0x2::coin::from_balance<T0>(v4, arg6), 0x2::coin::from_balance<T1>(v5, arg6))
    }

    fun swap_to_optimal<T0, T1>(arg0: &0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock) {
        let (v0, v1, v2, _) = 0x6747499c1aa28b025252e2db891598080cc2548fe8152370d789bb9ebf3c620f::swap_math::optimal_swap<T0, T1>(arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg3)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg3)), 0x2::balance::value<T0>(arg4), 0x2::balance::value<T1>(arg5));
        if (v0 == 0 && v1 == 0) {
            return
        };
        let (v4, v5, v6) = if (v2) {
            (0x2::balance::split<T0>(arg4, v0), 0x2::balance::zero<T1>(), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_sqrt_price() + 1)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg5, v0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_sqrt_price() - 1)
        };
        let (v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg6, arg1, arg2, v4, v5, v2, true, v0, 0, v6);
        let v9 = v8;
        let v10 = v7;
        let v11 = if (v2) {
            0x2::balance::value<T1>(&v9)
        } else {
            0x2::balance::value<T0>(&v10)
        };
        0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::assert_output(arg0, v1, v11);
        0x2::balance::join<T0>(arg4, v10);
        0x2::balance::join<T1>(arg5, v9);
    }

    public fun zap_in<T0, T1>(arg0: &0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::Registry, arg1: &mut 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::lp_registry::Collector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3);
        let v1 = 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::zap_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg3));
        let (v2, v3, v4, v5) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), 0x2::coin::into_balance<T1>(arg6), 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::constants::zap_in_source(), v1, arg9);
        0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::assert_price(arg0, v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3));
        assert!(v2 >= arg7 && v3 >= arg8, 1);
        let v6 = mint_proxy_cap(arg0);
        0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::events::emit_zapped_in(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg4), v2, v3, &v6);
        (0x2::coin::from_balance<T0>(v4, arg10), 0x2::coin::from_balance<T1>(v5, arg10))
    }

    fun zap_in_int<T0, T1>(arg0: &0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::Registry, arg1: &mut 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::lp_registry::Collector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::lp_registry::collect_fees<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, T0>(arg1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), &mut arg5, arg7, arg8);
        0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::lp_registry::collect_fees<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, T1>(arg1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), &mut arg6, arg7, arg8);
        let v0 = &mut arg5;
        let v1 = &mut arg6;
        swap_to_optimal<T0, T1>(arg0, arg2, arg3, arg4, v0, v1, arg9);
        let v2 = 0x2::balance::value<T0>(&arg5);
        let v3 = 0x2::balance::value<T1>(&arg6);
        assert!(v2 > 0 || v3 > 0, 0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T0, T1>(arg9, arg2, arg3, arg4, arg5, arg6, liquidity_for_amounts(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg4)), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg4)), v2, v3))
    }

    public fun zap_out<T0, T1, T2>(arg0: &0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::Registry, arg1: &mut 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::lp_registry::Collector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::into_balance<T2>(arg4);
        0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::lp_registry::collect_fees<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, T2>(arg1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), &mut v0, 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::constants::zap_out_source(), 0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::registry::zap_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg2)));
        assert!(0x2::balance::value<T2>(&v0) >= arg5, 1);
        let v1 = mint_proxy_cap(arg0);
        0x37d80d9da5824a48d8dfc9e8eb1798414cfb34843c7f09b21a919b2da1256ee6::events::emit_zapped_out(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg3), 0x1::type_name::with_original_ids<T2>(), 0x2::balance::value<T2>(&v0), &v1);
        0x2::coin::from_balance<T2>(v0, arg6)
    }

    // decompiled from Move bytecode v6
}

