module 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::equity {
    public fun mark_aux<T0, T1>(arg0: &mut 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::Vault<T1>, arg1: &0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::oracle::PriceOracle<T0, T1>, arg2: &0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::config::LotusConfig, arg3: &0x2::clock::Clock) {
        let v0 = 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::aux_balance<T1, T0>(arg0);
        if (v0 == 0 && !0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::has_aux_mark<T1, T0>(arg0)) {
            return
        };
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let (v2, v3) = 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::apply_aux_mark<T1>(arg0, 0x1::type_name::with_defining_ids<T0>(), 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::oracle::quote_value(v0, 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::oracle::fresh_price<T0, T1>(arg1, arg2, arg3)), v1);
        0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::events::emit_equity_mark(0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::vault::id<T1>(arg0), 1, 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::oracle::id<T0, T1>(arg1), v2, v3, v1);
    }

    // decompiled from Move bytecode v7
}

