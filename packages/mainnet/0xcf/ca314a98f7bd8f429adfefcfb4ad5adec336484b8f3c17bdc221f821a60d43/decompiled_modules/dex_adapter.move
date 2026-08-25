module 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::dex_adapter {
    public fun assert_dex_allowed<T0>(arg0: &0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::Vault<T0>, arg1: &0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::config::LotusConfig, arg2: u8) {
        assert!(0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::config::is_dex_allowed(arg1, arg2), 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::errors::dex_not_allowed());
        assert!(0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::is_dex_allowed<T0>(arg0, arg2), 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::errors::dex_not_allowed());
    }

    public fun assert_pool_allowed<T0>(arg0: &0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::Vault<T0>, arg1: 0x2::object::ID) {
        assert!(0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::is_pool_allowed<T0>(arg0, arg1), 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::errors::pool_not_allowed());
    }

    public fun assert_swap_allowed<T0>(arg0: &0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::Vault<T0>, arg1: &0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::config::LotusConfig, arg2: u64, arg3: &0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::VaultTradeCap<T0>, arg4: u8, arg5: 0x2::object::ID) {
        0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::config::assert_active(arg1, arg2);
        0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::assert_active_vault<T0>(arg0, arg1, arg2);
        0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::assert_trade_cap<T0>(arg0, arg3);
        assert_dex_allowed<T0>(arg0, arg1, arg4);
        assert_pool_allowed<T0>(arg0, arg5);
    }

    public(friend) fun finish_buy<T0, T1>(arg0: &mut 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::Vault<T1>, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: u64) {
        let v0 = 0x2::balance::value<T0>(&arg5);
        assert!(v0 >= arg4, 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::errors::swap_min_output());
        0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::strategy_put_aux<T1, T0>(arg0, arg5, arg3, arg6);
        0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::strategy_settle_principal<T1>(arg0, arg3, arg3);
        0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::events::emit_amm_swap(0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::id<T1>(arg0), arg1, arg2, true, arg3, v0, arg3);
    }

    public(friend) fun finish_sell<T0>(arg0: &mut 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::Vault<T0>, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg6);
        assert!(v0 >= arg4, 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::errors::swap_min_output());
        0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::strategy_put_quote<T0>(arg0, arg6);
        0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::strategy_settle_principal<T0>(arg0, arg5, v0);
        0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::events::emit_amm_swap(0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::id<T0>(arg0), arg1, arg2, false, arg3, v0, arg5);
    }

    // decompiled from Move bytecode v7
}

