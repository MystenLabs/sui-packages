module 0xf0a4b45f8cc53ba8641139977df770c71bd2ac8bd3c878af99be88dee9ad2d28::lp_farm {
    public fun new_zap_out_receipt(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg2: &0x2::tx_context::TxContext) : 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::receipt::Receipt {
        0xf0a4b45f8cc53ba8641139977df770c71bd2ac8bd3c878af99be88dee9ad2d28::lp_cetus::new_zap_out_receipt(arg0, 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg1), arg2)
    }

    fun zap_in_int<T0, T1>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>, arg2: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: u64, arg11: address, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::fee_pips(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg6), arg10);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg7));
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::collect_fees<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, T0>(arg1, v1, v2, arg11, arg10, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::utils::split_balance_by_pips<T0>(&mut arg8, v0));
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::collect_fees<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, T1>(arg1, v1, v2, arg11, arg10, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::utils::split_balance_by_pips<T1>(&mut arg9, v0));
        let v3 = &mut arg8;
        let v4 = &mut arg9;
        swap_to_optimal<T0, T1>(arg0, arg3, arg6, arg7, v3, v4, arg12);
        let v5 = 0x2::balance::value<T0>(&arg8);
        let v6 = 0x2::balance::value<T1>(&arg9);
        assert!(v5 > 0 || v6 > 0, 0);
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg7));
        let (v9, v10) = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::add_liquidity<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::from_balance<T0>(arg8, arg13), 0x2::coin::from_balance<T1>(arg9, arg13), v5, v6, 0xf0a4b45f8cc53ba8641139977df770c71bd2ac8bd3c878af99be88dee9ad2d28::lp_cetus::liquidity_for_amounts(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v7), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v8), v5, v6), arg12, arg13);
        let v11 = v10;
        let v12 = v9;
        (v5 - 0x2::balance::value<T0>(&v12), v6 - 0x2::balance::value<T1>(&v11), v12, v11)
    }

    public fun compound<T0, T1>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>, arg2: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: u64, arg12: vector<0x1::string::String>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::tx_context::sender(arg14);
        compound_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v0, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::compound_source(), arg13, arg14)
    }

    public(friend) fun compound_int<T0, T1>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>, arg2: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: u64, arg12: vector<0x1::string::String>, arg13: address, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6);
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::into_balance<T0>(arg8), 0x2::coin::into_balance<T1>(arg9), arg14, arg13, arg15, arg16);
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::assert_price(arg0, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6));
        assert!(v1 >= arg10 && v2 >= arg11, 1);
        let v5 = 0xf0a4b45f8cc53ba8641139977df770c71bd2ac8bd3c878af99be88dee9ad2d28::lp_cetus::mint_proxy_cap(arg0);
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::events::emit_compounded(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg7)), v1, v2, arg12, &v5);
        (0x2::coin::from_balance<T0>(v3, arg16), 0x2::coin::from_balance<T1>(v4, arg16))
    }

    public fun rebalance<T0, T1>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>, arg2: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::receipt::Receipt, arg8: u32, arg9: u32, arg10: 0x2::coin::Coin<T0>, arg11: 0x2::coin::Coin<T1>, arg12: u64, arg13: u64, arg14: u128, arg15: vector<0x1::string::String>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT) {
        assert!(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::receipt::source(&arg7) == 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::rebalance_source(), 3);
        let v0 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::receipt::vault(&arg7);
        let v1 = if (0x2::vec_map::is_empty<0x1::type_name::TypeName, u64>(&v0)) {
            let v2 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::receipt::payload(&arg7);
            0x1::vector::is_empty<u8>(&v2)
        } else {
            false
        };
        assert!(v1, 4);
        let v3 = 0x2::tx_context::sender(arg17);
        rebalance_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v3, arg16, arg17)
    }

    public(friend) fun rebalance_int<T0, T1>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>, arg2: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::receipt::Receipt, arg8: u32, arg9: u32, arg10: 0x2::coin::Coin<T0>, arg11: 0x2::coin::Coin<T1>, arg12: u64, arg13: u64, arg14: u128, arg15: vector<0x1::string::String>, arg16: address, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT) {
        let v0 = 0xf0a4b45f8cc53ba8641139977df770c71bd2ac8bd3c878af99be88dee9ad2d28::lp_cetus::mint_proxy_cap(arg0);
        let (_, v2, v3, v4, v5, v6, _, v8, _, _) = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::receipt::destroy_receipt(arg7, &v0);
        assert!(v2 == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6), 2);
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg3, arg6, arg8, arg9, arg18);
        let (v12, v13, v14, v15) = 0xf0a4b45f8cc53ba8641139977df770c71bd2ac8bd3c878af99be88dee9ad2d28::lp_cetus::zap_in_int<T0, T1, 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(arg0, arg1, arg3, arg6, &mut v11, 0x2::coin::into_balance<T0>(arg10), 0x2::coin::into_balance<T1>(arg11), v8, arg16, arg17);
        assert!(v12 >= arg12 && v13 >= arg13, 1);
        assert!(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::math::get_liquidity_in_y(v12, v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6)) >= arg14, 1);
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::assert_price(arg0, v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6));
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::events::emit_rebalanced(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6), v3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v11), v4, v5, v12, v13, v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6), arg15, &v0);
        (0x2::coin::from_balance<T0>(v14, arg18), 0x2::coin::from_balance<T1>(v15, arg18), 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::deposit_v2<T0, T1>(arg2, arg4, arg5, arg6, v11, arg17, arg18))
    }

    public fun start_rebalance<T0, T1>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::receipt::Receipt, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xf0a4b45f8cc53ba8641139977df770c71bd2ac8bd3c878af99be88dee9ad2d28::lp_cetus::mint_proxy_cap(arg0);
        let v1 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(&arg6);
        let (v2, v3) = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::close_position_v2<T0, T1>(arg1, arg3, arg4, arg2, arg5, arg6, 0, 0, arg7, arg8);
        let v4 = v3;
        let v5 = v2;
        (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::receipt::new_receipt(0x2::tx_context::sender(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v1), 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v1), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::rebalance_source(), 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(), 0x1::vector::empty<u8>(), &v0), 0x2::coin::from_balance<T0>(v5, arg8), 0x2::coin::from_balance<T1>(v4, arg8))
    }

    fun swap_to_optimal<T0, T1>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg3));
        let (v2, v3, v4, _) = 0xf0a4b45f8cc53ba8641139977df770c71bd2ac8bd3c878af99be88dee9ad2d28::swap_math::optimal_swap<T0, T1>(arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v1), 0x2::balance::value<T0>(arg4), 0x2::balance::value<T1>(arg5));
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
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::assert_price(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2));
        let v14 = if (v4) {
            0x2::balance::value<T1>(&v12)
        } else {
            0x2::balance::value<T0>(&v13)
        };
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::assert_output(arg0, v3, v14);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v6, v7, v11);
        0x2::balance::join<T0>(arg4, v13);
        0x2::balance::join<T1>(arg5, v12);
    }

    public fun zap_in<T0, T1>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>, arg2: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6);
        let v1 = 0x2::tx_context::sender(arg13);
        let (v2, v3, v4, v5) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::into_balance<T0>(arg8), 0x2::coin::into_balance<T1>(arg9), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::zap_in_source(), v1, arg12, arg13);
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::assert_price(arg0, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6));
        assert!(v2 >= arg10 && v3 >= arg11, 1);
        let v6 = 0xf0a4b45f8cc53ba8641139977df770c71bd2ac8bd3c878af99be88dee9ad2d28::lp_cetus::mint_proxy_cap(arg0);
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::events::emit_zapped_in(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg7)), v2, v3, &v6);
        (0x2::coin::from_balance<T0>(v4, arg13), 0x2::coin::from_balance<T1>(v5, arg13))
    }

    public fun zap_out<T0, T1, T2>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::receipt::Receipt, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xf0a4b45f8cc53ba8641139977df770c71bd2ac8bd3c878af99be88dee9ad2d28::lp_cetus::zap_out_int<T0, T1, T2, 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

