module 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::equity {
    public fun mark_aux<T0, T1>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::oracle::PriceOracle<T0, T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg3: &0x2::clock::Clock) {
        let v0 = 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::aux_balance<T1, T0>(arg0);
        if (v0 == 0 && !0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::has_aux_mark<T1, T0>(arg0)) {
            return
        };
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let (v2, v3) = 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::apply_aux_mark<T1>(arg0, 0x1::type_name::with_defining_ids<T0>(), 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::oracle::quote_value(v0, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::oracle::fresh_price<T0, T1>(arg1, arg2, arg3)), v1);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::events::emit_equity_mark(0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::id<T1>(arg0), 1, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::oracle::id<T0, T1>(arg1), v2, v3, v1);
    }

    // decompiled from Move bytecode v7
}

