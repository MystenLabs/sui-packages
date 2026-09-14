module 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::buyback {
    fun assert_protocol_launch<T0, T1>(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::ProtocolRevenue, arg1: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::WhirlpoolLaunch<T0, T1>, arg2: 0x2::object::ID) {
        assert!(0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::protocol_launch(arg0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::WhirlpoolLaunch<T0, T1>>(arg1)), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::wrong_launch());
        assert!(arg2 == 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::pool_id<T0, T1>(arg1), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::wrong_pool());
    }

    fun burn_all<T0>(arg0: &mut 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::ProtocolRevenue, arg1: &mut 0x2::coin_registry::Currency<T0>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::object::ID, arg4: u64) {
        let v0 = 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::balance_of<T0>(arg0);
        if (v0 > 0) {
            0x2::balance::join<T0>(&mut arg2, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::withdraw<T0>(arg0, v0));
        };
        let v1 = 0x2::balance::value<T0>(&arg2);
        if (v1 > 0) {
            0x2::coin_registry::burn_balance<T0>(arg1, arg2);
        } else {
            0x2::balance::destroy_zero<T0>(arg2);
        };
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::add_burned(arg0, v1);
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_protocol_buyback(0x2::object::id<0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::ProtocolRevenue>(arg0), arg3, arg4, 0x2::balance::value<T0>(&arg2), v1, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::total_burned(arg0));
    }

    public fun buyback_and_burn_token_a<T0, T1>(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::BuybackCap, arg1: &mut 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::ProtocolRevenue, arg2: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::WhirlpoolLaunch<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x2::coin_registry::Currency<T0>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        assert_protocol_launch<T0, T1>(arg1, arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4));
        let (v0, v1, v2) = if (arg6 > 0) {
            let (v3, v4) = swap_b_to_a<T0, T1>(arg3, arg4, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::withdraw<T1>(arg1, arg6), arg7, arg8);
            (v3, v4, arg6)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), 0)
        };
        let v5 = v1;
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::deposit<T1>(arg1, v5);
        burn_all<T0>(arg1, arg5, v0, 0x2::object::id<0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::WhirlpoolLaunch<T0, T1>>(arg2), v2 - 0x2::balance::value<T1>(&v5));
    }

    public fun buyback_and_burn_token_b<T0, T1>(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::BuybackCap, arg1: &mut 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::ProtocolRevenue, arg2: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::WhirlpoolLaunch<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: &mut 0x2::coin_registry::Currency<T0>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        assert_protocol_launch<T0, T1>(arg1, arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4));
        let (v0, v1, v2) = if (arg6 > 0) {
            let (v3, v4) = swap_a_to_b<T1, T0>(arg3, arg4, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::withdraw<T1>(arg1, arg6), arg7, arg8);
            (v3, v4, arg6)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), 0)
        };
        let v5 = v1;
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::deposit<T1>(arg1, v5);
        burn_all<T0>(arg1, arg5, v0, 0x2::object::id<0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::WhirlpoolLaunch<T0, T1>>(arg2), v2 - 0x2::balance::value<T1>(&v5));
    }

    fun emit_swap<T0, T1>(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::ProtocolRevenue, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_revenue_swapped(0x2::object::id<0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::ProtocolRevenue>(arg0), arg1, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()), arg2, arg3);
    }

    public fun sell_token_revenue_token_a<T0, T1>(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::BuybackCap, arg1: &mut 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::ProtocolRevenue, arg2: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::WhirlpoolLaunch<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4) == 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::pool_id<T0, T1>(arg2), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::wrong_pool());
        let (v0, v1) = swap_a_to_b<T0, T1>(arg3, arg4, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::withdraw<T0>(arg1, arg5), arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        emit_swap<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4), arg5 - 0x2::balance::value<T0>(&v2), 0x2::balance::value<T1>(&v3));
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::deposit<T1>(arg1, v3);
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::deposit<T0>(arg1, v2);
    }

    public fun sell_token_revenue_token_b<T0, T1>(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::BuybackCap, arg1: &mut 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::ProtocolRevenue, arg2: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::WhirlpoolLaunch<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4) == 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::pool_id<T0, T1>(arg2), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::wrong_pool());
        let (v0, v1) = swap_b_to_a<T1, T0>(arg3, arg4, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::withdraw<T0>(arg1, arg5), arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        emit_swap<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4), arg5 - 0x2::balance::value<T0>(&v2), 0x2::balance::value<T1>(&v3));
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::deposit<T1>(arg1, v3);
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::deposit<T0>(arg1, v2);
    }

    fun swap_a_to_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 > 0 && arg3 > 0, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::zero_amount());
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1, arg4);
        let v4 = v3;
        let v5 = v2;
        assert!(0x2::balance::value<T1>(&v5) >= arg3, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::slippage_exceeded());
        0x2::balance::destroy_zero<T0>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        (v5, arg2)
    }

    fun swap_b_to_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        assert!(v0 > 0 && arg3 > 0, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::zero_amount());
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1, arg4);
        let v4 = v3;
        let v5 = v1;
        assert!(0x2::balance::value<T0>(&v5) >= arg3, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::slippage_exceeded());
        0x2::balance::destroy_zero<T1>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4)), v4);
        (v5, arg2)
    }

    public fun swap_revenue_a_to_b<T0, T1>(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::BuybackCap, arg1: &mut 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::ProtocolRevenue, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::assert_pool_allowed(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3));
        let (v0, v1) = swap_a_to_b<T0, T1>(arg2, arg3, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::withdraw<T0>(arg1, arg4), arg5, arg6);
        let v2 = v1;
        let v3 = v0;
        emit_swap<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), arg4 - 0x2::balance::value<T0>(&v2), 0x2::balance::value<T1>(&v3));
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::deposit<T1>(arg1, v3);
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::deposit<T0>(arg1, v2);
    }

    public fun swap_revenue_b_to_a<T0, T1>(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::BuybackCap, arg1: &mut 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::ProtocolRevenue, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::assert_pool_allowed(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3));
        let (v0, v1) = swap_b_to_a<T0, T1>(arg2, arg3, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::withdraw<T1>(arg1, arg4), arg5, arg6);
        let v2 = v1;
        let v3 = v0;
        emit_swap<T1, T0>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), arg4 - 0x2::balance::value<T1>(&v2), 0x2::balance::value<T0>(&v3));
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::deposit<T0>(arg1, v3);
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::deposit<T1>(arg1, v2);
    }

    // decompiled from Move bytecode v7
}

