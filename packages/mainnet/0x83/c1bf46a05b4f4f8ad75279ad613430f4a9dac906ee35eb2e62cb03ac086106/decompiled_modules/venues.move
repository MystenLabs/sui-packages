module 0x1f60d8eb2f2309216d13005e99817a9678942421d012e906e76b63916f2bbcc7::venues {
    public fun cetus_add_mq<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, u64, u64) {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(arg2) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 1);
        let v0 = 0x2::balance::value<T0>(&arg3);
        let v1 = 0x2::balance::value<T1>(&arg4);
        let v2 = mul_price(v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1));
        if (!near_bps(v2, v1, arg5)) {
            return (arg3, arg4, 0, 0)
        };
        let v3 = if (v2 + v2 / 100 <= v1) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, v0, true, arg6)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, v1, false, arg6)
        };
        let v4 = v3;
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg3, v5), 0x2::balance::split<T1>(&mut arg4, v6), v4);
        (arg3, arg4, v6, v5)
    }

    public fun cetus_add_qm<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, u64, u64) {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(arg2) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1), 1);
        let v0 = 0x2::balance::value<T0>(&arg3);
        let v1 = 0x2::balance::value<T1>(&arg4);
        let v2 = mul_price(v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1));
        if (!near_bps(v2, v0, arg5)) {
            return (arg3, arg4, 0, 0)
        };
        let v3 = if (v2 + v2 / 100 <= v0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T1, T0>(arg0, arg1, arg2, v1, true, arg6)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T1, T0>(arg0, arg1, arg2, v0, false, arg6)
        };
        let v4 = v3;
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T1, T0>(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T1, T0>(arg0, arg1, 0x2::balance::split<T1>(&mut arg4, v5), 0x2::balance::split<T0>(&mut arg3, v6), v4);
        (arg3, arg4, v5, v6)
    }

    public fun cetus_create_mq<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: u32, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(arg2);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T0, T1>(arg0, arg1, arg2, sqrt_price_x64(0x2::balance::value<T0>(&arg3), 0x2::balance::value<T1>(&arg4)), arg5, v0, v1, 0x2::coin::from_balance<T0>(arg3, arg7), 0x2::coin::from_balance<T1>(arg4, arg7), true, arg6, arg7);
        (v2, 0x2::coin::into_balance<T0>(v3), 0x2::coin::into_balance<T1>(v4))
    }

    public fun cetus_create_qm<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: u32, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(arg2);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T1, T0>(arg0, arg1, arg2, sqrt_price_x64(0x2::balance::value<T1>(&arg4), 0x2::balance::value<T0>(&arg3)), arg5, v0, v1, 0x2::coin::from_balance<T1>(arg4, arg7), 0x2::coin::from_balance<T0>(arg3, arg7), false, arg6, arg7);
        (v2, 0x2::coin::into_balance<T0>(v4), 0x2::coin::into_balance<T1>(v3))
    }

    public fun cetus_join_mq<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u32, arg3: u64, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, u64, u64) {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg1) == arg2, 1);
        let v0 = 0x2::balance::value<T0>(&arg4);
        let v1 = 0x2::balance::value<T1>(&arg5);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        assert!(sqrt_near(v2, sqrt_price_x64(v0, v1), arg3), 1);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(arg2);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, v3, v4, arg7);
        let v6 = if (mul_price(v0, v2) <= v1) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, &mut v5, v0, true, arg6)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, &mut v5, v1, false, arg6)
        };
        let v7 = v6;
        let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg4, v8), 0x2::balance::split<T1>(&mut arg5, v9), v7);
        (v5, arg4, arg5, v8, v9)
    }

    public fun cetus_join_qm<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u32, arg3: u64, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, u64, u64) {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T1, T0>(arg1) == arg2, 1);
        let v0 = 0x2::balance::value<T0>(&arg4);
        let v1 = 0x2::balance::value<T1>(&arg5);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1);
        assert!(sqrt_near(v2, sqrt_price_x64(v1, v0), arg3), 1);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(arg2);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T1, T0>(arg0, arg1, v3, v4, arg7);
        let v6 = if (mul_price(v1, v2) <= v0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T1, T0>(arg0, arg1, &mut v5, v1, true, arg6)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T1, T0>(arg0, arg1, &mut v5, v0, false, arg6)
        };
        let v7 = v6;
        let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T1, T0>(&v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T1, T0>(arg0, arg1, 0x2::balance::split<T1>(&mut arg5, v8), 0x2::balance::split<T0>(&mut arg4, v9), v7);
        (v5, arg4, arg5, v9, v8)
    }

    public fun cetus_sell_qr<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg1, false, true, 0x2::balance::value<T0>(&arg2), 79226673515401279992447579055 - 1, arg3);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v3)), v3);
        0x2::balance::join<T0>(&mut arg2, v1);
        (arg2, v0)
    }

    public fun cetus_sell_rq<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 4295048016 + 1, arg3);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        0x2::balance::join<T0>(&mut arg2, v0);
        (arg2, v1)
    }

    public fun clmm_add<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, T1>, arg2: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        let v1 = 0x2::balance::value<T1>(&arg4);
        let v2 = if (!near_bps(mul_price(v0, 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::sqrt_price<T0, T1>(arg1)), arg5, arg6)) {
            true
        } else if (v0 == 0) {
            true
        } else {
            v1 == 0
        };
        if (v2) {
            return (arg3, arg4)
        };
        let (v3, v4) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::add_liquidity_by_amounts<T0, T1>(arg0, arg1, arg2, 0x2::coin::from_balance<T0>(arg3, arg7), 0x2::coin::from_balance<T1>(arg4, arg7), v0, v1, 0, 0, arg7);
        (0x2::coin::into_balance<T0>(v3), 0x2::coin::into_balance<T1>(v4))
    }

    public fun clmm_seed<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::pool_id<T0, T1>(arg0, arg2);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0) && *0x1::option::borrow<0x2::object::ID>(&v0) == 0x2::object::id<0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, T1>>(arg1), 1);
        let v1 = 0x2::balance::value<T0>(&arg4);
        let v2 = 0x2::balance::value<T1>(&arg5);
        assert!(sqrt_near(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::sqrt_price<T0, T1>(arg1), sqrt_price_x64(v1, v2), arg3), 1);
        let (v3, v4) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::full_range(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::tick_spacing<T0, T1>(arg1));
        let v5 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::open_position<T0, T1>(arg0, arg1, v3, v4, arg6);
        let (v6, v7) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::add_liquidity_by_amounts<T0, T1>(arg0, arg1, &mut v5, 0x2::coin::from_balance<T0>(arg4, arg6), 0x2::coin::from_balance<T1>(arg5, arg6), v1, v2, v1 - v1 / 50, v2 - v2 / 50, arg6);
        (v5, 0x2::coin::into_balance<T0>(v6), 0x2::coin::into_balance<T1>(v7))
    }

    public fun dlmm_add_active<T0, T1>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, T1>, arg2: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::Position, arg3: u32, arg4: u32, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::active_id<T0, T1>(arg1);
        if (v0 < arg3 || v0 >= arg3 + arg4) {
            return (arg5, arg6)
        };
        let v1 = ((v0 - arg3) as u64);
        let v2 = 0x2::balance::value<T0>(&arg5);
        let v3 = 0x2::balance::value<T1>(&arg6);
        let v4 = vector[];
        let v5 = vector[];
        let v6 = 0;
        while (v6 < (arg4 as u64)) {
            let v7 = if (v6 == v1) {
                v2
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v4, v7);
            let v8 = if (v6 == v1) {
                v3
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v5, v8);
            v6 = v6 + 1;
        };
        let (v9, v10) = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, 0x2::coin::from_balance<T0>(arg5, arg7), 0x2::coin::from_balance<T1>(arg6, arg7), v4, v5, v0, v0, v2 / 50 + 1, v3 / 50 + 1, arg7);
        (0x2::coin::into_balance<T0>(v9), 0x2::coin::into_balance<T1>(v10))
    }

    public fun dlmm_id_for(arg0: u64, arg1: u64, arg2: u64) : u32 {
        assert!(arg0 > 0 && arg1 > 0, 1);
        let v0 = ((arg1 as u256) << 64) / (arg0 as u256);
        let v1 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::max_id();
        let v2 = 1;
        while (v2 < v1) {
            v1 = v2 + (v1 - v2) / 2;
            if (dlmm_price_or_max(v1, arg2) < v0) {
                v2 = v1 + 1;
                continue
            };
        };
        if (v2 > 1 && v0 - dlmm_price_or_max(v2 - 1, arg2) < dlmm_price_or_max(v2, arg2) - v0) {
            v2 - 1
        } else {
            v2
        }
    }

    fun dlmm_price_or_max(arg0: u32, arg1: u64) : u256 {
        let v0 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::id_offset();
        let v1 = if (arg0 >= v0) {
            arg0 - v0
        } else {
            v0 - arg0
        };
        if (v1 > 400000 / (arg1 as u32)) {
            if (arg0 >= v0) {
                340282366920938463463374607431768211456
            } else {
                0
            }
        } else {
            (0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::price(arg0, arg1) as u256)
        }
    }

    public fun dlmm_seed<T0, T1>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, T1>, arg2: u64, arg3: u32, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, u32, u32) {
        let v0 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::pool_id<T0, T1>(arg0, arg2);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0) && *0x1::option::borrow<0x2::object::ID>(&v0) == 0x2::object::id<0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, T1>>(arg1), 1);
        let v1 = 0x2::balance::value<T0>(&arg4);
        let v2 = 0x2::balance::value<T1>(&arg5);
        let v3 = dlmm_id_for(v1, v2, arg2);
        let v4 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::active_id<T0, T1>(arg1);
        assert!(v4 + 1 >= v3 && v4 <= v3 + 1, 1);
        let v5 = v4 - arg3;
        let v6 = 2 * arg3 + 1;
        let v7 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::open_position<T0, T1>(arg0, arg1, v5, v6, arg6);
        let v8 = (arg3 as u64) * 2 + 1;
        let v9 = v2 * 2 / v8;
        let v10 = v1 * 2 / v8;
        let v11 = vector[];
        let v12 = vector[];
        let v13 = 0;
        while (v13 < v6) {
            if (v13 < arg3) {
                0x1::vector::push_back<u64>(&mut v11, 0);
                0x1::vector::push_back<u64>(&mut v12, v9);
            } else if (v13 == arg3) {
                0x1::vector::push_back<u64>(&mut v11, v10 / 2);
                0x1::vector::push_back<u64>(&mut v12, v9 / 2);
            } else {
                0x1::vector::push_back<u64>(&mut v11, v10);
                0x1::vector::push_back<u64>(&mut v12, 0);
            };
            v13 = v13 + 1;
        };
        let (v14, v15) = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::add_liquidity<T0, T1>(arg0, arg1, &mut v7, 0x2::coin::from_balance<T0>(arg4, arg6), 0x2::coin::from_balance<T1>(arg5, arg6), v11, v12, v4, v4, v10 / 50 + 1, v9 / 50 + 1, arg6);
        (v7, 0x2::coin::into_balance<T0>(v14), 0x2::coin::into_balance<T1>(v15), v5, v6)
    }

    public fun mul_price(arg0: u64, arg1: u128) : u64 {
        let v0 = (arg1 as u256);
        let v1 = (arg0 as u256) * v0 / 18446744073709551616 * v0 / 18446744073709551616;
        if (v1 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v1 as u64)
        }
    }

    public fun near_bps(arg0: u64, arg1: u64, arg2: u64) : bool {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        v0 * (10000 as u128) >= v1 * ((10000 - arg2) as u128) && v0 * (10000 as u128) <= v1 * ((10000 + arg2) as u128)
    }

    public fun sqrt_near(arg0: u128, arg1: u128, arg2: u64) : bool {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = (10000 as u256);
        let v3 = (arg2 as u256);
        v0 * v2 >= v1 * (v2 - v3) && v0 * v2 <= v1 * (v2 + v3)
    }

    public fun sqrt_price_x64(arg0: u64, arg1: u64) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 1);
        let v0 = ((arg1 as u256) << 128) / (arg0 as u256);
        let v1 = (v0 + 1) / 2;
        while (v1 < v0) {
            let v2 = v1 + v0 / v1;
            v1 = v2 / 2;
        };
        assert!(v0 <= 340282366920938463463374607431768211455, 1);
        (v0 as u128)
    }

    // decompiled from Move bytecode v7
}

