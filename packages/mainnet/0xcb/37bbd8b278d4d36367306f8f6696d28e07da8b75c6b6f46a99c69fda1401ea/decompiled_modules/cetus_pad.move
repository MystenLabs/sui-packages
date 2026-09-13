module 0xcb37bbd8b278d4d36367306f8f6696d28e07da8b75c6b6f46a99c69fda1401ea::cetus_pad {
    struct CetusVenue has drop {
        dummy_field: bool,
    }

    public fun fill_a<T0>(arg0: 0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::VenueOrder<T0>, arg1: &0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::VenueRegistry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg4: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg5: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg6: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::ReferralRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusVenue{dummy_field: false};
        let (v1, v2, v3) = 0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::begin_fill<T0, CetusVenue>(arg0, arg1, v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>>(arg3), price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x2::sui::SUI, T0>(arg3), 0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::decimals<T0>(&arg0), true), arg4, arg5, arg6, arg7, arg8);
        let v4 = v2;
        let v5 = v1;
        if (0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::is_buy<T0>(&arg0)) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg2, arg3, true, true, 0x2::balance::value<0x2::sui::SUI>(&v5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1, arg7);
            let v9 = v8;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg2, arg3, 0x2::balance::split<0x2::sui::SUI>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v9)), 0x2::balance::zero<T0>(), v9);
            0x2::balance::join<0x2::sui::SUI>(&mut v5, v6);
            0x2::balance::join<T0>(&mut v4, v7);
            assert!(0x2::balance::value<T0>(&v4) > 0, 2);
            0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::settle_fill<T0>(v3, v5, v4, arg4, arg5, arg8);
        } else {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg2, arg3, false, true, 0x2::balance::value<T0>(&v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1, arg7);
            let v13 = v12;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg2, arg3, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::balance::split<T0>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v13)), v13);
            0x2::balance::join<0x2::sui::SUI>(&mut v5, v10);
            0x2::balance::join<T0>(&mut v4, v11);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v5) > 0, 2);
            0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::settle_fill<T0>(v3, v5, v4, arg4, arg5, arg8);
        };
    }

    public fun fill_b<T0>(arg0: 0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::VenueOrder<T0>, arg1: &0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::VenueRegistry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg5: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg6: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::ReferralRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusVenue{dummy_field: false};
        let (v1, v2, v3) = 0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::begin_fill<T0, CetusVenue>(arg0, arg1, v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg3), price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg3), 0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::decimals<T0>(&arg0), false), arg4, arg5, arg6, arg7, arg8);
        let v4 = v2;
        let v5 = v1;
        if (0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::is_buy<T0>(&arg0)) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg2, arg3, false, true, 0x2::balance::value<0x2::sui::SUI>(&v5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1, arg7);
            let v9 = v8;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v9)), v9);
            0x2::balance::join<0x2::sui::SUI>(&mut v5, v7);
            0x2::balance::join<T0>(&mut v4, v6);
            assert!(0x2::balance::value<T0>(&v4) > 0, 2);
            0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::settle_fill<T0>(v3, v5, v4, arg4, arg5, arg8);
        } else {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg2, arg3, true, true, 0x2::balance::value<T0>(&v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1, arg7);
            let v13 = v12;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg2, arg3, 0x2::balance::split<T0>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v13)), 0x2::balance::zero<0x2::sui::SUI>(), v13);
            0x2::balance::join<0x2::sui::SUI>(&mut v5, v11);
            0x2::balance::join<T0>(&mut v4, v10);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v5) > 0, 2);
            0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::settle_fill<T0>(v3, v5, v4, arg4, arg5, arg8);
        };
    }

    public fun place_buy_a<T0>(arg0: &0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::VenueRegistry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg2: 0x2::object::ID, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u128, arg6: u64, arg7: 0x1::option::Option<address>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusVenue{dummy_field: false};
        0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::place_buy<T0, CetusVenue>(v0, arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>>(arg1), arg2, arg3, arg4, arg5, arg5 > price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x2::sui::SUI, T0>(arg1), 0x2::coin::get_decimals<T0>(arg3), true), arg6, arg7, arg8, arg9, arg10);
    }

    public fun place_buy_b<T0>(arg0: &0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::VenueRegistry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u128, arg6: u64, arg7: 0x1::option::Option<address>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusVenue{dummy_field: false};
        0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::place_buy<T0, CetusVenue>(v0, arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1), arg2, arg3, arg4, arg5, arg5 > price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg1), 0x2::coin::get_decimals<T0>(arg3), false), arg6, arg7, arg8, arg9, arg10);
    }

    public fun place_sell_a<T0>(arg0: &0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::VenueRegistry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg2: 0x2::object::ID, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<T0>, arg5: u128, arg6: u64, arg7: 0x1::option::Option<address>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusVenue{dummy_field: false};
        0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::place_sell<T0, CetusVenue>(v0, arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>>(arg1), arg2, arg3, arg4, arg5, arg5 > price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x2::sui::SUI, T0>(arg1), 0x2::coin::get_decimals<T0>(arg3), true), arg6, arg7, arg8, arg9, arg10);
    }

    public fun place_sell_b<T0>(arg0: &0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::VenueRegistry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<T0>, arg5: u128, arg6: u64, arg7: 0x1::option::Option<address>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusVenue{dummy_field: false};
        0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::place_sell<T0, CetusVenue>(v0, arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1), arg2, arg3, arg4, arg5, arg5 > price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg1), 0x2::coin::get_decimals<T0>(arg3), false), arg6, arg7, arg8, arg9, arg10);
    }

    fun pow10(arg0: u8) : u256 {
        let v0 = 0;
        let v1 = 1;
        while (v0 < arg0) {
            v1 = v1 * 10;
            v0 = v0 + 1;
        };
        v1
    }

    public fun price_a<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg1: u8) : u128 {
        price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x2::sui::SUI, T0>(arg0), arg1, true)
    }

    public fun price_b<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: u8) : u128 {
        price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg0), arg1, false)
    }

    public fun price_from_sqrt(arg0: u128, arg1: u8, arg2: bool) : u128 {
        assert!(arg0 > 0, 0);
        let v0 = (arg0 as u256) * (arg0 as u256);
        let v1 = pow10(arg1) * 1000000000000;
        let v2 = 340282366920938463463374607431768211456;
        let v3 = if (arg2) {
            v2 / v0 * v1 + v2 % v0 * v1 / v0
        } else {
            (v0 >> 128) * v1 + ((v0 & v2 - 1) * v1 >> 128)
        };
        assert!(v3 <= 340282366920938463444927863358058659840, 1);
        (v3 as u128)
    }

    // decompiled from Move bytecode v7
}

