module 0xfd648201fde8dbdced6622b43976d87ba65618edde470041da84248a72237d26::constant_product {
    struct Witness has drop {
        dummy_field: bool,
    }

    fun curve_input(arg0: u64, arg1: u64) : u64 {
        arg0 - (((arg0 as u128) * (arg1 as u128) / 1000000) as u64)
    }

    public fun kriya_quote<T0, T1>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        let v0 = 0x2::bcs::new(0x1::bcs::to_bytes<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0));
        0x2::bcs::peel_address(&mut v0);
        let v1 = 0x2::bcs::peel_u64(&mut v0);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_bool(&mut v0);
        0x2::bcs::peel_bool(&mut v0);
        let v3 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v3), 0);
        let v4 = if (!0x2::bcs::peel_bool(&mut v0)) {
            true
        } else if (arg2 == 0) {
            true
        } else if (v2 == 0) {
            true
        } else {
            v1 == 0
        };
        if (v4) {
            return 0
        };
        let (v5, v6, v7, v8) = if (arg1) {
            (v2, v1, 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
        } else {
            (v1, v2, 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
        };
        if (0x2::bcs::peel_bool(&mut v0)) {
            0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::utils::get_input_price_stable(curve_input(arg2, 0x2::bcs::peel_u64(&mut v0)), v5, v6, 0x2::bcs::peel_u64(&mut v0), v7, v8)
        } else {
            0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::utils::get_input_price_uncorrelated(curve_input(arg2, 0x2::bcs::peel_u64(&mut v0)), v5, v6, 0x2::bcs::peel_u64(&mut v0))
        }
    }

    public fun quote_kriya<T0, T1, T2, T3>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>, arg3: bool, arg4: u64, arg5: bool) {
        let v0 = 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>>(arg2);
        let v1 = if (arg3) {
            let v2 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T2, Witness>(arg0, arg1, &v2, v0, arg4, arg5)
        } else {
            let v3 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T3, Witness>(arg0, arg1, &v3, v0, arg4, arg5)
        };
        let v4 = kriya_quote<T2, T3>(arg2, arg3, v1);
        if (arg3) {
            let v5 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T2, T3, Witness>(arg0, arg1, &v5, 5, v0, arg3, v1, v4, v4 > 0);
        } else {
            let v6 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T3, T2, Witness>(arg0, arg1, &v6, 5, v0, arg3, v1, v4, v4 > 0);
        };
    }

    public fun swap_kriya<T0, T1, T2, T3>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            let v0 = Witness{dummy_field: false};
            let v1 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T2, T3, Witness>(arg0, arg1, &v0, 5, 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>>(arg2), true, arg4);
            if (0x1::option::is_none<0x2::coin::Coin<T2>>(&v1)) {
                0x1::option::destroy_none<0x2::coin::Coin<T2>>(v1);
                return
            };
            let v2 = 0x1::option::destroy_some<0x2::coin::Coin<T2>>(v1);
            let v3 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T3, Witness>(arg0, arg1, &v3, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T2, T3>(arg2, v2, 0x2::coin::value<T2>(&v2), 0, arg4));
        } else {
            let v4 = Witness{dummy_field: false};
            let v5 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T3, T2, Witness>(arg0, arg1, &v4, 5, 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>>(arg2), false, arg4);
            if (0x1::option::is_none<0x2::coin::Coin<T3>>(&v5)) {
                0x1::option::destroy_none<0x2::coin::Coin<T3>>(v5);
                return
            };
            let v6 = 0x1::option::destroy_some<0x2::coin::Coin<T3>>(v5);
            let v7 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T2, Witness>(arg0, arg1, &v7, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T2, T3>(arg2, v6, 0x2::coin::value<T3>(&v6), 0, arg4));
        };
    }

    // decompiled from Move bytecode v7
}

