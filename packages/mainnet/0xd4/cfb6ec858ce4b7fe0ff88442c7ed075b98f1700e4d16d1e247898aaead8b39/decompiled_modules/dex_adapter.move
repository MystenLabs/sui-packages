module 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::dex_adapter {
    public fun assert_dex_allowed<T0>(arg0: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T0>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg2: u8) {
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::is_dex_allowed(arg1, arg2), 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::errors::dex_not_allowed());
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::is_dex_allowed<T0>(arg0, arg2), 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::errors::dex_not_allowed());
    }

    public fun assert_pool_allowed<T0>(arg0: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T0>, arg1: 0x2::object::ID) {
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::is_pool_allowed<T0>(arg0, arg1), 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::errors::pool_not_allowed());
    }

    public fun assert_swap_allowed<T0>(arg0: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T0>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg2: u64, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::VaultTradeCap<T0>, arg4: u8, arg5: 0x2::object::ID) {
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::assert_active(arg1, arg2);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_active_vault<T0>(arg0, arg1, arg2);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_trade_cap<T0>(arg0, arg3);
        assert_dex_allowed<T0>(arg0, arg1, arg4);
        assert_pool_allowed<T0>(arg0, arg5);
    }

    public(friend) fun finish_buy<T0, T1>(arg0: &mut 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: u64) {
        let v0 = 0x2::balance::value<T0>(&arg5);
        assert!(v0 >= arg4, 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::errors::swap_min_output());
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::strategy_put_aux<T1, T0>(arg0, arg5, arg3, arg6);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::strategy_settle_principal<T1>(arg0, arg3, arg3);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::events::emit_amm_swap(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg0), arg1, arg2, true, arg3, v0, arg3);
    }

    public(friend) fun finish_sell<T0>(arg0: &mut 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T0>, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg6);
        assert!(v0 >= arg4, 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::errors::swap_min_output());
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::strategy_put_quote<T0>(arg0, arg6);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::strategy_settle_principal<T0>(arg0, arg5, v0);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::events::emit_amm_swap(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T0>(arg0), arg1, arg2, false, arg3, v0, arg5);
    }

    // decompiled from Move bytecode v7
}

