module 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::equity {
    public fun mark_aux<T0, T1>(arg0: &mut 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::Vault<T1>, arg1: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::oracle::PriceOracle<T0, T1>, arg2: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::config::LotusConfig, arg3: &0x2::clock::Clock) {
        let v0 = 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::aux_balance<T1, T0>(arg0);
        if (v0 == 0 && !0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::has_aux_mark<T1, T0>(arg0)) {
            return
        };
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let (v2, v3) = 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::apply_aux_mark<T1>(arg0, 0x1::type_name::with_defining_ids<T0>(), 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::oracle::quote_value(v0, 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::oracle::fresh_price<T0, T1>(arg1, arg2, arg3)), v1);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::events::emit_equity_mark(0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::id<T1>(arg0), 1, 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::oracle::id<T0, T1>(arg1), v2, v3, v1);
    }

    // decompiled from Move bytecode v7
}

