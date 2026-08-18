module 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::equity {
    public fun mark_aux<T0, T1>(arg0: &mut 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg1: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::oracle::PriceOracle<T0, T1>, arg2: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::LotusConfig, arg3: &0x2::clock::Clock) {
        let v0 = 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::aux_balance<T1, T0>(arg0);
        if (v0 == 0 && !0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::has_aux_mark<T1, T0>(arg0)) {
            return
        };
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let (v2, v3) = 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::apply_aux_mark<T1>(arg0, 0x1::type_name::with_defining_ids<T0>(), 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::oracle::quote_value(v0, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::oracle::fresh_price<T0, T1>(arg1, arg2, arg3)), v1);
        0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::events::emit_equity_mark(0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::id<T1>(arg0), 1, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::oracle::id<T0, T1>(arg1), v2, v3, v1);
    }

    // decompiled from Move bytecode v7
}

