module 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::equity {
    public fun mark_aux<T0, T1>(arg0: &mut 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::vault::Vault<T1>, arg1: &0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::oracle::PriceOracle<T0, T1>, arg2: &0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::config::LotusConfig, arg3: &0x2::clock::Clock) {
        let v0 = 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::vault::aux_balance<T1, T0>(arg0);
        if (v0 == 0 && !0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::vault::has_aux_mark<T1, T0>(arg0)) {
            return
        };
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let (v2, v3) = 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::vault::apply_aux_mark<T1>(arg0, 0x1::type_name::with_defining_ids<T0>(), 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::oracle::quote_value(v0, 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::oracle::fresh_price<T0, T1>(arg1, arg2, arg3)), v1);
        0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::events::emit_equity_mark(0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::vault::id<T1>(arg0), 1, 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::oracle::id<T0, T1>(arg1), v2, v3, v1);
    }

    // decompiled from Move bytecode v7
}

