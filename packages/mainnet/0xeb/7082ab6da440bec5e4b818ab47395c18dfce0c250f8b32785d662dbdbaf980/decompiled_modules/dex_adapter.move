module 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::dex_adapter {
    public fun assert_dex_allowed<T0>(arg0: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::Vault<T0>, arg1: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::config::LotusConfig, arg2: u8) {
        assert!(0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::config::is_dex_allowed(arg1, arg2), 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::errors::dex_not_allowed());
        assert!(0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::is_dex_allowed<T0>(arg0, arg2), 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::errors::dex_not_allowed());
    }

    public fun assert_pool_allowed<T0>(arg0: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::Vault<T0>, arg1: 0x2::object::ID) {
        assert!(0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::is_pool_allowed<T0>(arg0, arg1), 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::errors::pool_not_allowed());
    }

    public fun assert_swap_allowed<T0>(arg0: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::Vault<T0>, arg1: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::config::LotusConfig, arg2: u64, arg3: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::VaultTradeCap<T0>, arg4: u8, arg5: 0x2::object::ID) {
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::config::assert_active(arg1, arg2);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::assert_active_vault<T0>(arg0, arg1, arg2);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::assert_trade_cap<T0>(arg0, arg3);
        assert_dex_allowed<T0>(arg0, arg1, arg4);
        assert_pool_allowed<T0>(arg0, arg5);
    }

    public(friend) fun finish_buy<T0, T1>(arg0: &mut 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::Vault<T1>, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: u64) {
        let v0 = 0x2::balance::value<T0>(&arg5);
        assert!(v0 >= arg4, 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::errors::swap_min_output());
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::strategy_put_aux<T1, T0>(arg0, arg5, arg3, arg6);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::strategy_settle_principal<T1>(arg0, arg3, arg3);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::events::emit_amm_swap(0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::id<T1>(arg0), arg1, arg2, true, arg3, v0, arg3);
    }

    public(friend) fun finish_sell<T0>(arg0: &mut 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::Vault<T0>, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg6);
        assert!(v0 >= arg4, 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::errors::swap_min_output());
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::strategy_put_quote<T0>(arg0, arg6);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::strategy_settle_principal<T0>(arg0, arg5, v0);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::events::emit_amm_swap(0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::id<T0>(arg0), arg1, arg2, false, arg3, v0, arg5);
    }

    // decompiled from Move bytecode v7
}

