module 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::equity {
    public fun donate_aux<T0, T1>(arg0: &mut 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg2: u64, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::oracle::PriceOracle<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::assert_active(arg1, arg2);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::is_reward_allowed<T1, T0>(arg0), 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::errors::reward_not_allowed());
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::errors::zero_value());
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::donate_aux_credit<T1, T0>(arg0, 0x2::coin::into_balance<T0>(arg4), 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::oracle::quote_value(v0, 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::oracle::fresh_price<T0, T1>(arg3, arg1, arg5)), 0x2::clock::timestamp_ms(arg5), 0x2::tx_context::sender(arg6));
    }

    public fun mark_aux<T0, T1>(arg0: &mut 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::oracle::PriceOracle<T0, T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg3: &0x2::clock::Clock) {
        let v0 = 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::aux_balance<T1, T0>(arg0);
        if (v0 == 0 && !0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::has_aux_mark<T1, T0>(arg0)) {
            return
        };
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let (v2, v3) = 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::apply_aux_mark<T1>(arg0, 0x1::type_name::with_defining_ids<T0>(), 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::oracle::quote_value(v0, 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::oracle::fresh_price<T0, T1>(arg1, arg2, arg3)), v1);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::events::emit_equity_mark(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg0), 1, 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::oracle::id<T0, T1>(arg1), v2, v3, v1);
    }

    // decompiled from Move bytecode v7
}

