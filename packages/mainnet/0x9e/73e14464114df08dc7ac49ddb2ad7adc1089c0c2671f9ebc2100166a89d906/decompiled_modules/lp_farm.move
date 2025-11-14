module 0x9e73e14464114df08dc7ac49ddb2ad7adc1089c0c2671f9ebc2100166a89d906::lp_farm {
    public fun compound<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>, arg2: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: u64, arg12: vector<0x1::string::String>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::tx_context::sender(arg14);
        compound_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v0, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::compound_source(), arg13, arg14)
    }

    public(friend) fun compound_int<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>, arg2: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: u64, arg12: vector<0x1::string::String>, arg13: address, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6);
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::into_balance<T0>(arg8), 0x2::coin::into_balance<T1>(arg9), arg14, arg13, arg15, arg16);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::assert_price(arg0, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6));
        assert!(v1 >= arg10 && v2 >= arg11, 1);
        let v5 = 0x9e73e14464114df08dc7ac49ddb2ad7adc1089c0c2671f9ebc2100166a89d906::lp_cetus::mint_proxy_cap(arg0);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::events::emit_compounded(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg7)), v1, v2, arg12, &v5);
        (0x2::coin::from_balance<T0>(v3, arg16), 0x2::coin::from_balance<T1>(v4, arg16))
    }

    public fun rebalance<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>, arg2: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg8: 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::RebalanceReceipt, arg9: u32, arg10: u32, arg11: 0x2::coin::Coin<T0>, arg12: 0x2::coin::Coin<T1>, arg13: u64, arg14: u64, arg15: vector<0x1::string::String>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT) {
        let v0 = 0x2::tx_context::sender(arg17);
        rebalance_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v0, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::rebalance_source(), arg16, arg17)
    }

    public(friend) fun rebalance_int<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>, arg2: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg8: 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::RebalanceReceipt, arg9: u32, arg10: u32, arg11: 0x2::coin::Coin<T0>, arg12: 0x2::coin::Coin<T1>, arg13: u64, arg14: u64, arg15: vector<0x1::string::String>, arg16: address, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(&arg7));
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::is_empty(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::borrow_position_info(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::position_manager<T0, T1>(arg6), v0)), 3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg3, arg6, arg9, arg10, arg19);
        let v2 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::deposit_v2<T0, T1>(arg2, arg4, arg5, arg6, v1, arg18, arg19);
        let v3 = &mut v2;
        let (v4, v5, v6, v7) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v3, 0x2::coin::into_balance<T0>(arg11), 0x2::coin::into_balance<T1>(arg12), arg17, arg16, arg18, arg19);
        let v8 = v7;
        let v9 = v6;
        assert!(v4 >= arg13 && v5 >= arg14, 1);
        let v10 = 0x9e73e14464114df08dc7ac49ddb2ad7adc1089c0c2671f9ebc2100166a89d906::lp_cetus::mint_proxy_cap(arg0);
        let (v11, v12, v13, v14, v15) = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::destroy_rebalance_receipt(arg8, &v10);
        assert!(0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::math::get_liquidity_in_y(v4, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6)) >= v15, 1);
        assert!(v11 == v0, 4);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::assert_price(arg0, v14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6));
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::events::emit_rebalanced(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6), v11, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1), v12, v13, v4, v5, v14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6), arg15, &v10);
        let (v16, v17) = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::close_position_v2<T0, T1>(arg2, arg4, arg5, arg3, arg6, arg7, 0, 0, arg18, arg19);
        0x2::balance::join<T0>(&mut v9, v16);
        0x2::balance::join<T1>(&mut v8, v17);
        (0x2::coin::from_balance<T0>(v9, arg19), 0x2::coin::from_balance<T1>(v8, arg19), v2)
    }

    public fun start_rebalance<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::RebalanceReceipt, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x9e73e14464114df08dc7ac49ddb2ad7adc1089c0c2671f9ebc2100166a89d906::lp_cetus::mint_proxy_cap(arg0);
        let v1 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg6);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v1);
        let (v3, v4) = if (v2 > 0) {
            0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::remove_liquidity<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, v2, 0, 0, arg8)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v5 = v4;
        let v6 = v3;
        (0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::new_rebalance_receipt(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v1), 0x2::balance::value<T0>(&v6), 0x2::balance::value<T1>(&v5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), arg7, &v0), 0x2::coin::from_balance<T0>(v6, arg9), 0x2::coin::from_balance<T1>(v5, arg9))
    }

    fun swap_to_optimal<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg3));
        let (v2, v3, v4, _) = 0x9e73e14464114df08dc7ac49ddb2ad7adc1089c0c2671f9ebc2100166a89d906::swap_math::optimal_swap<T0, T1>(arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v1), 0x2::balance::value<T0>(arg4), 0x2::balance::value<T1>(arg5));
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
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::assert_price(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2));
        let v14 = if (v4) {
            0x2::balance::value<T1>(&v12)
        } else {
            0x2::balance::value<T0>(&v13)
        };
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::assert_output(arg0, v3, v14);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v6, v7, v11);
        0x2::balance::join<T0>(arg4, v13);
        0x2::balance::join<T1>(arg5, v12);
    }

    public fun zap_in<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>, arg2: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6);
        let v1 = 0x2::tx_context::sender(arg13);
        let (v2, v3, v4, v5) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::into_balance<T0>(arg8), 0x2::coin::into_balance<T1>(arg9), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::zap_in_source(), v1, arg12, arg13);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::assert_price(arg0, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6));
        assert!(v2 >= arg10 && v3 >= arg11, 1);
        let v6 = 0x9e73e14464114df08dc7ac49ddb2ad7adc1089c0c2671f9ebc2100166a89d906::lp_cetus::mint_proxy_cap(arg0);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::events::emit_zapped_in(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg7)), v2, v3, &v6);
        (0x2::coin::from_balance<T0>(v4, arg13), 0x2::coin::from_balance<T1>(v5, arg13))
    }

    fun zap_in_int<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>, arg2: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: u64, arg11: address, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::fee_pips(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg6), arg10);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg7));
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::collect_fees<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, T0>(arg1, v1, v2, arg11, arg10, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::split_balance_by_pips<T0>(&mut arg8, v0));
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::collect_fees<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, T1>(arg1, v1, v2, arg11, arg10, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::split_balance_by_pips<T1>(&mut arg9, v0));
        let v3 = &mut arg8;
        let v4 = &mut arg9;
        swap_to_optimal<T0, T1>(arg0, arg3, arg6, arg7, v3, v4, arg12);
        let v5 = 0x2::balance::value<T0>(&arg8);
        let v6 = 0x2::balance::value<T1>(&arg9);
        assert!(v5 > 0 || v6 > 0, 0);
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg7));
        let (v9, v10) = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::add_liquidity<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::from_balance<T0>(arg8, arg13), 0x2::coin::from_balance<T1>(arg9, arg13), v5, v6, 0x9e73e14464114df08dc7ac49ddb2ad7adc1089c0c2671f9ebc2100166a89d906::lp_cetus::liquidity_for_amounts(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v7), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v8), v5, v6), arg12, arg13);
        let v11 = v10;
        let v12 = v9;
        (v5 - 0x2::balance::value<T0>(&v12), v6 - 0x2::balance::value<T1>(&v11), v12, v11)
    }

    public fun zap_out<T0, T1, T2>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg3);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(v0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 2);
        let v1 = 0x2::coin::into_balance<T2>(arg4);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::collect_fees<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, T2>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0), 0x2::tx_context::sender(arg6), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::zap_out_source(), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::split_balance_by_pips<T2>(&mut v1, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::fee_pips(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg2), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::zap_out_source())));
        assert!(0x2::balance::value<T2>(&v1) >= arg5, 1);
        let v2 = 0x9e73e14464114df08dc7ac49ddb2ad7adc1089c0c2671f9ebc2100166a89d906::lp_cetus::mint_proxy_cap(arg0);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::events::emit_zapped_out(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0), 0x1::type_name::with_original_ids<T2>(), 0x2::balance::value<T2>(&v1), &v2);
        0x2::coin::from_balance<T2>(v1, arg6)
    }

    // decompiled from Move bytecode v6
}

