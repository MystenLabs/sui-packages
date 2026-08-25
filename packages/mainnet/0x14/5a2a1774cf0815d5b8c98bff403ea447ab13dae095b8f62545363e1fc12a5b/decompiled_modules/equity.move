module 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::equity {
    public fun mark_aux<T0, T1>(arg0: &mut 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::Vault<T1>, arg1: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::PriceOracle<T0, T1>, arg2: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::LotusConfig, arg3: &0x2::clock::Clock) {
        let v0 = 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::aux_balance<T1, T0>(arg0);
        if (v0 == 0 && !0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::has_aux_mark<T1, T0>(arg0)) {
            return
        };
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let (v2, v3) = 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::apply_aux_mark<T1>(arg0, 0x1::type_name::with_defining_ids<T0>(), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::quote_value(v0, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::fresh_price<T0, T1>(arg1, arg2, arg3)), v1);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::events::emit_equity_mark(0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::id<T1>(arg0), 1, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::id<T0, T1>(arg1), v2, v3, v1);
    }

    // decompiled from Move bytecode v7
}

