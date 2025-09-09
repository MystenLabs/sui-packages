module 0x240912e832cad9cfd657083a3cfc42f112ef39dff1c6568f1372689685c7597e::lp_farm {
    public fun compound<T0, T1>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::compound_fee_pips(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg5));
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::into_balance<T0>(arg7), 0x2::coin::into_balance<T1>(arg8), 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::compound_fee_source(), v0, arg11, arg12);
        assert!(v1 >= arg9 && v2 >= arg10, 1);
        let v5 = 0x240912e832cad9cfd657083a3cfc42f112ef39dff1c6568f1372689685c7597e::lp_cetus::init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_compounded<0x240912e832cad9cfd657083a3cfc42f112ef39dff1c6568f1372689685c7597e::lp_cetus::CetusWitness>(arg0, &v5, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg6)), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg12), 0x2::coin::from_balance<T1>(v4, arg12))
    }

    public fun rebalance<T0, T1>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg7: u32, arg8: u32, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T1>, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT) {
        let v0 = 0x2::coin::value<T0>(&arg9) > 0 || 0x2::coin::value<T1>(&arg10) > 0;
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(&arg6));
        let (v2, v3) = if (v1 > 0) {
            0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::remove_liquidity<T0, T1>(arg1, arg4, arg2, arg3, arg5, &mut arg6, v1, 0, 0, arg13)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::coin::into_balance<T1>(arg10);
        let v7 = 0x2::coin::into_balance<T0>(arg9);
        0x2::balance::join<T0>(&mut v7, v5);
        0x2::balance::join<T1>(&mut v6, v4);
        let v8 = 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::rebalance_fee_pips(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg5));
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg4, arg5, arg7, arg8, arg14);
        let v10 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::deposit_v2<T0, T1>(arg1, arg2, arg3, arg5, v9, arg13, arg14);
        let v11 = &mut v10;
        let (v12, v13, v14, v15) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, v11, v7, v6, 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::rebalance_fee_source(), v8, arg13, arg14);
        let v16 = v15;
        let v17 = v14;
        assert!(v12 >= arg11 && v13 >= arg12, 1);
        let v18 = 0x240912e832cad9cfd657083a3cfc42f112ef39dff1c6568f1372689685c7597e::lp_cetus::init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_rebalanced<0x240912e832cad9cfd657083a3cfc42f112ef39dff1c6568f1372689685c7597e::lp_cetus::CetusWitness>(arg0, &v18, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(&arg6)), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v9), 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4), v12, v13, v0);
        let (v19, v20) = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::close_position_v2<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, 0, 0, arg13, arg14);
        0x2::balance::join<T0>(&mut v17, v19);
        0x2::balance::join<T1>(&mut v16, v20);
        (0x2::coin::from_balance<T0>(v17, arg14), 0x2::coin::from_balance<T1>(v16, arg14), v10)
    }

    fun swap_to_optimal<T0, T1>(arg0: &0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg3));
        let (v2, v3, v4, _) = 0x240912e832cad9cfd657083a3cfc42f112ef39dff1c6568f1372689685c7597e::swap_math::optimal_swap<T0, T1>(arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v1), 0x2::balance::value<T0>(arg4), 0x2::balance::value<T1>(arg5));
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
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::assert_price(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2));
        let v14 = if (v4) {
            0x2::balance::value<T1>(&v12)
        } else {
            0x2::balance::value<T0>(&v13)
        };
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::assert_output(arg0, v3, v14);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v6, v7, v11);
        0x2::balance::join<T0>(arg4, v13);
        0x2::balance::join<T1>(arg5, v12);
    }

    public fun zap_in<T0, T1>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::zap_fee_pips(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg5));
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::into_balance<T0>(arg7), 0x2::coin::into_balance<T1>(arg8), 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::zap_in_fee_source(), v0, arg11, arg12);
        assert!(v1 >= arg9 && v2 >= arg10, 1);
        let v5 = 0x240912e832cad9cfd657083a3cfc42f112ef39dff1c6568f1372689685c7597e::lp_cetus::init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_zapped_in<0x240912e832cad9cfd657083a3cfc42f112ef39dff1c6568f1372689685c7597e::lp_cetus::CetusWitness>(arg0, &v5, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg6)), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg12), 0x2::coin::from_balance<T1>(v4, arg12))
    }

    fun zap_in_int<T0, T1>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::collect_fees<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5), &mut arg7, arg9, arg10);
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::collect_fees<T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5), &mut arg8, arg9, arg10);
        let v0 = &mut arg7;
        let v1 = &mut arg8;
        swap_to_optimal<T0, T1>(arg0, arg4, arg5, arg6, v0, v1, arg11);
        let v2 = 0x2::balance::value<T0>(&arg7);
        let v3 = 0x2::balance::value<T1>(&arg8);
        assert!(v2 > 0 || v3 > 0, 0);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg6));
        let (v6, v7) = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::add_liquidity<T0, T1>(arg1, arg4, arg2, arg3, arg5, arg6, 0x2::coin::from_balance<T0>(arg7, arg12), 0x2::coin::from_balance<T1>(arg8, arg12), v2, v3, 0x240912e832cad9cfd657083a3cfc42f112ef39dff1c6568f1372689685c7597e::lp_cetus::liquidity_for_amounts(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v5), v2, v3), arg11, arg12);
        let v8 = v7;
        let v9 = v6;
        (v2 - 0x2::balance::value<T0>(&v9), v3 - 0x2::balance::value<T1>(&v8), v9, v8)
    }

    public fun zap_out<T0, T1, T2>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg2);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(v0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 2);
        let v1 = 0x2::coin::into_balance<T2>(arg3);
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::collect_fees<T2>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), &mut v1, 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::zap_out_fee_source(), 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::zap_fee_pips(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg1)));
        assert!(0x2::balance::value<T2>(&v1) >= arg4, 1);
        let v2 = 0x240912e832cad9cfd657083a3cfc42f112ef39dff1c6568f1372689685c7597e::lp_cetus::init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_zapped_out<0x240912e832cad9cfd657083a3cfc42f112ef39dff1c6568f1372689685c7597e::lp_cetus::CetusWitness>(arg0, &v2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0), 0x1::type_name::with_original_ids<T2>(), 0x2::balance::value<T2>(&v1));
        0x2::coin::from_balance<T2>(v1, arg5)
    }

    // decompiled from Move bytecode v6
}

