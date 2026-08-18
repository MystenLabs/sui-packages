module 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::equity {
    public fun mark_aux<T0, T1>(arg0: &mut 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg1: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::oracle::PriceOracle<T0, T1>, arg2: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::LotusConfig, arg3: &0x2::clock::Clock) {
        let v0 = 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::aux_balance<T1, T0>(arg0);
        if (v0 == 0 && !0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::has_aux_mark<T1, T0>(arg0)) {
            return
        };
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let (v2, v3) = 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::apply_aux_mark<T1>(arg0, 0x1::type_name::with_defining_ids<T0>(), 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::oracle::quote_value(v0, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::oracle::fresh_price<T0, T1>(arg1, arg2, arg3)), v1);
        0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::events::emit_equity_mark(0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::id<T1>(arg0), 1, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::oracle::id<T0, T1>(arg1), v2, v3, v1);
    }

    // decompiled from Move bytecode v7
}

