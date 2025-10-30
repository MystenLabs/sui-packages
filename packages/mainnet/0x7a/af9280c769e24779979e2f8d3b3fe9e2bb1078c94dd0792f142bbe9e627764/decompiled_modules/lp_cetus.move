module 0x7aaf9280c769e24779979e2f8d3b3fe9e2bb1078c94dd0792f142bbe9e627764::lp_cetus {
    struct CetusWitness has drop {
        dummy_field: bool,
    }

    public(friend) fun mint_proxy_cap(arg0: &0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::Registry) : 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::ProxyCap {
        let v0 = CetusWitness{dummy_field: false};
        0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::mint_proxy_cap<CetusWitness>(arg0, v0)
    }

    public fun compound<T0, T1>(arg0: &0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::Registry, arg1: &mut 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::lp_registry::Collector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: vector<0x1::string::String>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::tx_context::sender(arg11);
        compound_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v0, 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::constants::compound_source(), arg10, arg11)
    }

    public(friend) fun compound_int<T0, T1>(arg0: &0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::Registry, arg1: &mut 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::lp_registry::Collector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: vector<0x1::string::String>, arg10: address, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3);
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), 0x2::coin::into_balance<T1>(arg6), arg11, arg10, arg12);
        0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::assert_price(arg0, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3));
        assert!(v1 >= arg7 && v2 >= arg8, 1);
        let v5 = mint_proxy_cap(arg0);
        0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::events::emit_compounded(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg4), v1, v2, arg9, &v5);
        (0x2::coin::from_balance<T0>(v3, arg13), 0x2::coin::from_balance<T1>(v4, arg13))
    }

    public(friend) fun init_witness() : CetusWitness {
        CetusWitness{dummy_field: false}
    }

    public(friend) fun liquidity_for_amounts(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u128 {
        if (arg0 <= arg1) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(arg1, arg2, arg3, false)
        } else if (arg0 >= arg2) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_b(arg1, arg2, arg4, false)
        } else {
            0x1::u128::min(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(arg0, arg2, arg3, false), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_b(arg1, arg0, arg4, false))
        }
    }

    public fun rebalance<T0, T1>(arg0: &0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::Registry, arg1: &mut 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::lp_registry::Collector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg5: 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::state::RebalanceReceipt, arg6: u32, arg7: u32, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: u64, arg12: vector<0x1::string::String>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) {
        let v0 = 0x2::tx_context::sender(arg14);
        rebalance_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v0, 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::constants::rebalance_source(), arg13, arg14)
    }

    public(friend) fun rebalance_int<T0, T1>(arg0: &0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::Registry, arg1: &mut 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::lp_registry::Collector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg5: 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::state::RebalanceReceipt, arg6: u32, arg7: u32, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: u64, arg12: vector<0x1::string::String>, arg13: address, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::is_empty(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::borrow_position_info(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::position_manager<T0, T1>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg4))), 3);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, arg6, arg7, arg16);
        let v1 = &mut v0;
        let (v2, v3, v4, v5) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, v1, 0x2::coin::into_balance<T0>(arg8), 0x2::coin::into_balance<T1>(arg9), arg14, arg13, arg15);
        assert!(v2 >= arg10 && v3 >= arg11, 1);
        let v6 = mint_proxy_cap(arg0);
        let (v7, v8, v9, v10, v11) = 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::state::destroy_rebalance_receipt(arg5, &v6);
        assert!(0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::math::get_liquidity_in_y(v2, v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3)) >= v11, 1);
        assert!(v7 == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg4), 4);
        0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::assert_price(arg0, v10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3));
        0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::events::emit_rebalanced(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), v7, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0), v8, v9, v2, v3, v10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3), arg12, &v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg3, arg4);
        (0x2::coin::from_balance<T0>(v4, arg16), 0x2::coin::from_balance<T1>(v5, arg16), v0)
    }

    public fun start_rebalance<T0, T1>(arg0: &0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::state::RebalanceReceipt, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = mint_proxy_cap(arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg3);
        let (v2, v3) = if (v1 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, arg3, v1, arg5)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v4 = v3;
        let v5 = v2;
        (0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::state::new_rebalance_receipt(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3), 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), arg4, &v0), 0x2::coin::from_balance<T0>(v5, arg6), 0x2::coin::from_balance<T1>(v4, arg6))
    }

    fun swap_to_optimal<T0, T1>(arg0: &0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg3);
        let (v2, v3, v4, _) = 0x7aaf9280c769e24779979e2f8d3b3fe9e2bb1078c94dd0792f142bbe9e627764::swap_math::optimal_swap<T0, T1>(arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v1), 0x2::balance::value<T0>(arg4), 0x2::balance::value<T1>(arg5));
        if (v2 == 0 && v3 == 0) {
            return
        };
        let (v6, v7, v8) = if (v4) {
            (0x2::balance::split<T0>(arg4, v2), 0x2::balance::zero<T1>(), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg5, v2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1)
        };
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, v4, true, v2, v8, arg6);
        let v12 = v10;
        let v13 = v9;
        0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::assert_price(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2));
        let v14 = if (v4) {
            0x2::balance::value<T1>(&v12)
        } else {
            0x2::balance::value<T0>(&v13)
        };
        0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::assert_output(arg0, v3, v14);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v6, v7, v11);
        0x2::balance::join<T0>(arg4, v13);
        0x2::balance::join<T1>(arg5, v12);
    }

    public fun zap_in<T0, T1>(arg0: &0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::Registry, arg1: &mut 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::lp_registry::Collector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3);
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), 0x2::coin::into_balance<T1>(arg6), 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::constants::zap_in_source(), 0x2::tx_context::sender(arg10), arg9);
        0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::assert_price(arg0, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3));
        assert!(v1 >= arg7 && v2 >= arg8, 1);
        let v5 = mint_proxy_cap(arg0);
        0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::events::emit_zapped_in(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg4), v1, v2, &v5);
        (0x2::coin::from_balance<T0>(v3, arg10), 0x2::coin::from_balance<T1>(v4, arg10))
    }

    fun zap_in_int<T0, T1>(arg0: &0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::Registry, arg1: &mut 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::lp_registry::Collector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: address, arg9: &0x2::clock::Clock) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::fee_pips(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg3), arg7);
        0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::lp_registry::collect_fees<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, T0>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg4), arg8, arg7, 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::utils::split_balance_by_pips<T0>(&mut arg5, v0));
        0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::lp_registry::collect_fees<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg4), arg8, arg7, 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::utils::split_balance_by_pips<T1>(&mut arg6, v0));
        let v1 = &mut arg5;
        let v2 = &mut arg6;
        swap_to_optimal<T0, T1>(arg0, arg2, arg3, arg4, v1, v2, arg9);
        let v3 = 0x2::balance::value<T0>(&arg5);
        let v4 = 0x2::balance::value<T1>(&arg6);
        assert!(v3 > 0 || v4 > 0, 0);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg4);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg2, arg3, arg4, liquidity_for_amounts(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v6), v3, v4), arg9);
        let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg3, 0x2::balance::split<T0>(&mut arg5, v8), 0x2::balance::split<T1>(&mut arg6, v9), v7);
        (v8, v9, arg5, arg6)
    }

    public fun zap_out<T0, T1, T2>(arg0: &0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::Registry, arg1: &mut 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::lp_registry::Collector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(arg3) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 2);
        let v0 = 0x2::coin::into_balance<T2>(arg4);
        0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::lp_registry::collect_fees<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, T2>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3), 0x2::tx_context::sender(arg6), 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::constants::zap_out_source(), 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::utils::split_balance_by_pips<T2>(&mut v0, 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::registry::fee_pips(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg2), 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::constants::zap_out_source())));
        assert!(0x2::balance::value<T2>(&v0) >= arg5, 1);
        let v1 = mint_proxy_cap(arg0);
        0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::events::emit_zapped_out(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3), 0x1::type_name::with_original_ids<T2>(), 0x2::balance::value<T2>(&v0), &v1);
        0x2::coin::from_balance<T2>(v0, arg6)
    }

    // decompiled from Move bytecode v6
}

