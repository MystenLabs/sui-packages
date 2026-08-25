module 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::dex_adapter {
    public fun assert_dex_allowed<T0>(arg0: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::Vault<T0>, arg1: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::LotusConfig, arg2: u8) {
        assert!(0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::is_dex_allowed(arg1, arg2), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::dex_not_allowed());
        assert!(0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::is_dex_allowed<T0>(arg0, arg2), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::dex_not_allowed());
    }

    public fun assert_pool_allowed<T0>(arg0: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::Vault<T0>, arg1: 0x2::object::ID) {
        assert!(0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::is_pool_allowed<T0>(arg0, arg1), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::pool_not_allowed());
    }

    public fun assert_swap_allowed<T0>(arg0: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::Vault<T0>, arg1: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::LotusConfig, arg2: u64, arg3: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::VaultTradeCap<T0>, arg4: u8, arg5: 0x2::object::ID) {
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::assert_active(arg1, arg2);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::assert_active_vault<T0>(arg0, arg1, arg2);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::assert_trade_cap<T0>(arg0, arg3);
        assert_dex_allowed<T0>(arg0, arg1, arg4);
        assert_pool_allowed<T0>(arg0, arg5);
    }

    public(friend) fun finish_buy<T0, T1>(arg0: &mut 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::Vault<T1>, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: u64) {
        let v0 = 0x2::balance::value<T0>(&arg5);
        assert!(v0 >= arg4, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::swap_min_output());
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::strategy_put_aux<T1, T0>(arg0, arg5, arg3, arg6);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::strategy_settle_principal<T1>(arg0, arg3, arg3);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::events::emit_amm_swap(0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::id<T1>(arg0), arg1, arg2, true, arg3, v0, arg3);
    }

    public(friend) fun finish_sell<T0>(arg0: &mut 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::Vault<T0>, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg6);
        assert!(v0 >= arg4, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::swap_min_output());
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::strategy_put_quote<T0>(arg0, arg6);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::strategy_settle_principal<T0>(arg0, arg5, v0);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::events::emit_amm_swap(0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::id<T0>(arg0), arg1, arg2, false, arg3, v0, arg5);
    }

    // decompiled from Move bytecode v7
}

