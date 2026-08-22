module 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::bluefin_adapter {
    public fun buy_base_bq<T0, T1>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::VaultTradeCap<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg3: u64, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock) {
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::assert_swap_allowed<T1>(arg0, arg2, arg3, arg1, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_bluefin(), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5));
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg9, arg4, arg5, 0x2::balance::zero<T0>(), 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::strategy_take_quote<T1>(arg0, arg6), false, true, arg6, arg7, arg8);
        let v2 = v1;
        assert!(0x2::balance::value<T1>(&v2) == 0, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::swap_debt_mismatch());
        0x2::balance::destroy_zero<T1>(v2);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::finish_buy<T0, T1>(arg0, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_bluefin(), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5), arg6, arg7, v0, 0x2::clock::timestamp_ms(arg9));
    }

    public fun buy_base_qb<T0, T1>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::VaultTradeCap<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg3: u64, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock) {
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::assert_swap_allowed<T1>(arg0, arg2, arg3, arg1, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_bluefin(), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg5));
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T0>(arg9, arg4, arg5, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::strategy_take_quote<T1>(arg0, arg6), 0x2::balance::zero<T0>(), true, true, arg6, arg7, arg8);
        let v2 = v0;
        assert!(0x2::balance::value<T1>(&v2) == 0, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::swap_debt_mismatch());
        0x2::balance::destroy_zero<T1>(v2);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::finish_buy<T0, T1>(arg0, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_bluefin(), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg5), arg6, arg7, v1, 0x2::clock::timestamp_ms(arg9));
    }

    public fun sell_base_bq<T0, T1>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::VaultTradeCap<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg3: u64, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock) {
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::assert_swap_allowed<T1>(arg0, arg2, arg3, arg1, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_bluefin(), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5));
        sell_bq<T0, T1>(arg0, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun sell_base_qb<T0, T1>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::VaultTradeCap<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg3: u64, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock) {
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::assert_swap_allowed<T1>(arg0, arg2, arg3, arg1, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_bluefin(), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg5));
        sell_qb<T0, T1>(arg0, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun sell_bq<T0, T1>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) {
        let (v0, v1) = 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::strategy_take_aux<T1, T0>(arg0, arg3);
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg6, arg1, arg2, v0, 0x2::balance::zero<T1>(), true, true, arg3, arg4, arg5);
        let v4 = v2;
        assert!(0x2::balance::value<T0>(&v4) == 0, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::swap_debt_mismatch());
        0x2::balance::destroy_zero<T0>(v4);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::finish_sell<T1>(arg0, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_bluefin(), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), arg3, arg4, v1, v3);
    }

    fun sell_qb<T0, T1>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) {
        let (v0, v1) = 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::strategy_take_aux<T1, T0>(arg0, arg3);
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T0>(arg6, arg1, arg2, 0x2::balance::zero<T1>(), v0, false, true, arg3, arg4, arg5);
        let v4 = v3;
        assert!(0x2::balance::value<T0>(&v4) == 0, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::swap_debt_mismatch());
        0x2::balance::destroy_zero<T0>(v4);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::finish_sell<T1>(arg0, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_bluefin(), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg2), arg3, arg4, v1, v2);
    }

    // decompiled from Move bytecode v7
}

