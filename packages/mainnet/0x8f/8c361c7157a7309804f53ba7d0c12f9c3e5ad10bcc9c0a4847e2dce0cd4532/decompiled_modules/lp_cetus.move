module 0x8f8c361c7157a7309804f53ba7d0c12f9c3e5ad10bcc9c0a4847e2dce0cd4532::lp_cetus {
    struct CetusWitness has drop {
        dummy_field: bool,
    }

    public fun compound<T0, T1>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::compound_fee_pips(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg2));
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::compound_fee_source(), v0, arg8);
        assert!(v1 >= arg6 && v2 >= arg7, 1);
        let v5 = init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_compounded<CetusWitness>(arg0, &v5, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg9), 0x2::coin::from_balance<T1>(v4, arg9))
    }

    fun init_witness() : CetusWitness {
        CetusWitness{dummy_field: false}
    }

    fun liquidity_for_amounts(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u128 {
        if (arg0 <= arg1) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(arg1, arg2, arg3, false)
        } else if (arg0 >= arg2) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_b(arg1, arg2, arg4, false)
        } else {
            0x1::u128::min(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(arg0, arg2, arg3, false), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_b(arg1, arg0, arg4, false))
        }
    }

    public fun rebalance<T0, T1>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: u32, arg5: u32, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) {
        let v0 = 0x2::coin::value<T0>(&arg6) > 0 || 0x2::coin::value<T1>(&arg7) > 0;
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg3);
        let (v2, v3) = if (v1 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, v1, arg10)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::coin::into_balance<T1>(arg7);
        let v7 = 0x2::coin::into_balance<T0>(arg6);
        0x2::balance::join<T0>(&mut v7, v5);
        0x2::balance::join<T1>(&mut v6, v4);
        let v8 = 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::rebalance_fee_pips(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg2));
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg4, arg5, arg11);
        let v10 = &mut v9;
        let (v11, v12, v13, v14) = zap_in_int<T0, T1>(arg0, arg1, arg2, v10, v7, v6, 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::rebalance_fee_source(), v8, arg10);
        assert!(v11 >= arg8 && v12 >= arg9, 1);
        let v15 = init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_rebalanced<CetusWitness>(arg0, &v15, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v9), 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4), v11, v12, v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, arg3);
        (0x2::coin::from_balance<T0>(v13, arg11), 0x2::coin::from_balance<T1>(v14, arg11), v9)
    }

    fun swap_to_optimal<T0, T1>(arg0: &0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg3);
        let (v2, v3, v4, _) = 0x8f8c361c7157a7309804f53ba7d0c12f9c3e5ad10bcc9c0a4847e2dce0cd4532::swap_math::optimal_swap<T0, T1>(arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v1), 0x2::balance::value<T0>(arg4), 0x2::balance::value<T1>(arg5));
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

    public fun zap_in<T0, T1>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::zap_fee_pips(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg2));
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::zap_in_fee_source(), v0, arg8);
        assert!(v1 >= arg6 && v2 >= arg7, 1);
        let v5 = init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_zapped_in<CetusWitness>(arg0, &v5, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg9), 0x2::coin::from_balance<T1>(v4, arg9))
    }

    fun zap_in_int<T0, T1>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::collect_fees<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), &mut arg4, arg6, arg7);
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::collect_fees<T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), &mut arg5, arg6, arg7);
        let v0 = &mut arg4;
        let v1 = &mut arg5;
        swap_to_optimal<T0, T1>(arg0, arg1, arg2, arg3, v0, v1, arg8);
        let v2 = 0x2::balance::value<T0>(&arg4);
        let v3 = 0x2::balance::value<T1>(&arg5);
        assert!(v2 > 0 || v3 > 0, 0);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg3);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg1, arg2, arg3, liquidity_for_amounts(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v5), v2, v3), arg8);
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg4, v7), 0x2::balance::split<T1>(&mut arg5, v8), v6);
        (v7, v8, arg4, arg5)
    }

    public fun zap_out<T0, T1, T2>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::coin::Coin<T2>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::into_balance<T2>(arg3);
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::collect_fees<T2>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), &mut v0, 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::zap_out_fee_source(), 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::zap_fee_pips(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg1)));
        let v1 = init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_zapped_out<CetusWitness>(arg0, &v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg2), 0x1::type_name::get<T2>(), 0x2::balance::value<T2>(&v0));
        0x2::coin::from_balance<T2>(v0, arg4)
    }

    // decompiled from Move bytecode v6
}

