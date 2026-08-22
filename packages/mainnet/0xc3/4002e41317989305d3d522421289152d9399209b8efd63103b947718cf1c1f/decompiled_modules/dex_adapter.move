module 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter {
    public fun assert_dex_allowed<T0>(arg0: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T0>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg2: u8) {
        assert!(0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::is_dex_allowed(arg1, arg2), 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::dex_not_allowed());
        assert!(0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::is_dex_allowed<T0>(arg0, arg2), 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::dex_not_allowed());
    }

    public fun assert_pool_allowed<T0>(arg0: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T0>, arg1: 0x2::object::ID) {
        assert!(0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::is_pool_allowed<T0>(arg0, arg1), 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::pool_not_allowed());
    }

    public fun assert_swap_allowed<T0>(arg0: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T0>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg2: u64, arg3: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::VaultTradeCap<T0>, arg4: u8, arg5: 0x2::object::ID) {
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::assert_active(arg1, arg2);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::assert_active_vault<T0>(arg0, arg1, arg2);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::assert_trade_cap<T0>(arg0, arg3);
        assert_dex_allowed<T0>(arg0, arg1, arg4);
        assert_pool_allowed<T0>(arg0, arg5);
    }

    public(friend) fun finish_buy<T0, T1>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: u64) {
        let v0 = 0x2::balance::value<T0>(&arg5);
        assert!(v0 >= arg4, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::swap_min_output());
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::strategy_put_aux<T1, T0>(arg0, arg5, arg3, arg6);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::strategy_settle_principal<T1>(arg0, arg3, arg3);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::events::emit_amm_swap(0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::id<T1>(arg0), arg1, arg2, true, arg3, v0, arg3);
    }

    public(friend) fun finish_sell<T0>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T0>, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg6);
        assert!(v0 >= arg4, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::swap_min_output());
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::strategy_put_quote<T0>(arg0, arg6);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::strategy_settle_principal<T0>(arg0, arg5, v0);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::events::emit_amm_swap(0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::id<T0>(arg0), arg1, arg2, false, arg3, v0, arg5);
    }

    // decompiled from Move bytecode v7
}

