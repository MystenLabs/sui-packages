module 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::cetus_adapter {
    public fun buy_base_bq<T0, T1>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::VaultTradeCap<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock) {
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::assert_swap_allowed<T1>(arg0, arg2, arg3, arg1, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_cetus(), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5));
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, false, true, arg6, arg8, arg9);
        let v3 = v2;
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3) == arg6, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::swap_debt_mismatch());
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::balance::zero<T0>(), 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::strategy_take_quote<T1>(arg0, arg6), v3);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::finish_buy<T0, T1>(arg0, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_cetus(), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5), arg6, arg7, v0, 0x2::clock::timestamp_ms(arg9));
    }

    public fun buy_base_qb<T0, T1>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::VaultTradeCap<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock) {
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::assert_swap_allowed<T1>(arg0, arg2, arg3, arg1, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_cetus(), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg5));
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg5, true, true, arg6, arg8, arg9);
        let v3 = v2;
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v3) == arg6, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::swap_debt_mismatch());
        0x2::balance::destroy_zero<T1>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::strategy_take_quote<T1>(arg0, arg6), 0x2::balance::zero<T0>(), v3);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::finish_buy<T0, T1>(arg0, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_cetus(), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg5), arg6, arg7, v1, 0x2::clock::timestamp_ms(arg9));
    }

    public fun sell_base_bq<T0, T1>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::VaultTradeCap<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock) {
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::assert_swap_allowed<T1>(arg0, arg2, arg3, arg1, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_cetus(), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5));
        sell_bq<T0, T1>(arg0, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun sell_base_qb<T0, T1>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::VaultTradeCap<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock) {
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::assert_swap_allowed<T1>(arg0, arg2, arg3, arg1, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_cetus(), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg5));
        sell_qb<T0, T1>(arg0, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun sell_bq<T0, T1>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, arg3, arg5, arg6);
        let v3 = v2;
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3) == arg3, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::swap_debt_mismatch());
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::strategy_take_aux<T1, T0>(arg0, arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v4, 0x2::balance::zero<T1>(), v3);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::finish_sell<T1>(arg0, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_cetus(), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), arg3, arg4, v5, v1);
    }

    fun sell_qb<T0, T1>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg1, arg2, false, true, arg3, arg5, arg6);
        let v3 = v2;
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v3) == arg3, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::swap_debt_mismatch());
        0x2::balance::destroy_zero<T0>(v1);
        let (v4, v5) = 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::strategy_take_aux<T1, T0>(arg0, arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg2, 0x2::balance::zero<T1>(), v4, v3);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::finish_sell<T1>(arg0, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_cetus(), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2), arg3, arg4, v5, v0);
    }

    // decompiled from Move bytecode v7
}

