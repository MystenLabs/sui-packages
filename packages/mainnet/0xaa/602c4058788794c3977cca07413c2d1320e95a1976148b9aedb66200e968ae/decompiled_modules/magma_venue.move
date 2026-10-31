module 0xaa602c4058788794c3977cca07413c2d1320e95a1976148b9aedb66200e968ae::magma_venue {
    struct Witness has drop {
        dummy_field: bool,
    }

    public fun quote_magma<T0, T1, T2, T3>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T2, T3>, arg4: bool, arg5: u64, arg6: bool) {
        let v0 = 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T2, T3>>(arg3);
        let v1 = if (arg4) {
            let v2 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T2, Witness>(arg0, arg1, &v2, v0, arg5, arg6)
        } else {
            let v3 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T3, Witness>(arg0, arg1, &v3, v0, arg5, arg6)
        };
        let (v4, v5) = quote_state<T2, T3>(arg2, arg3, arg4, v1);
        if (arg4) {
            let v6 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T2, T3, Witness>(arg0, arg1, &v6, 12, v0, true, v1, v4, v5);
        } else {
            let v7 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T3, T2, Witness>(arg0, arg1, &v7, 12, v0, false, v1, v4, v5);
        };
    }

    public fun quote_state<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: bool, arg3: u64) : (u64, bool) {
        if (arg3 == 0) {
            return (0, false)
        };
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, true, arg3);
        let (v1, _, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_fees_amount(&v0);
        let v5 = !0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_is_exceed(&v0) && (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_in(&v0) as u128) + (v1 as u128) == (arg3 as u128);
        (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v0), v5)
    }

    public fun swap_magma<T0, T1, T2, T3>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T2, T3>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            let v0 = Witness{dummy_field: false};
            let v1 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T2, T3, Witness>(arg0, arg1, &v0, 12, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T2, T3>>(arg3), true, arg6);
            if (0x1::option::is_none<0x2::coin::Coin<T2>>(&v1)) {
                0x1::option::destroy_none<0x2::coin::Coin<T2>>(v1);
                return
            };
            let v2 = 0x1::option::destroy_some<0x2::coin::Coin<T2>>(v1);
            let (v3, v4, v5) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T2, T3>(arg2, arg3, true, true, 0x2::coin::value<T2>(&v2), 4295048016, arg5);
            let v6 = v5;
            0x2::balance::destroy_zero<T2>(v3);
            assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T2, T3>(&v6) == 0x2::coin::value<T2>(&v2), 0);
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T2, T3>(arg2, arg3, 0x2::coin::into_balance<T2>(v2), 0x2::balance::zero<T3>(), v6);
            let v7 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T3, Witness>(arg0, arg1, &v7, 0x2::coin::from_balance<T3>(v4, arg6));
        } else {
            let v8 = Witness{dummy_field: false};
            let v9 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T3, T2, Witness>(arg0, arg1, &v8, 12, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T2, T3>>(arg3), false, arg6);
            if (0x1::option::is_none<0x2::coin::Coin<T3>>(&v9)) {
                0x1::option::destroy_none<0x2::coin::Coin<T3>>(v9);
                return
            };
            let v10 = 0x1::option::destroy_some<0x2::coin::Coin<T3>>(v9);
            let (v11, v12, v13) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T2, T3>(arg2, arg3, false, true, 0x2::coin::value<T3>(&v10), 79226673515401279992447579055, arg5);
            let v14 = v13;
            0x2::balance::destroy_zero<T3>(v12);
            assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T2, T3>(&v14) == 0x2::coin::value<T3>(&v10), 0);
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T2, T3>(arg2, arg3, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T3>(v10), v14);
            let v15 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T2, Witness>(arg0, arg1, &v15, 0x2::coin::from_balance<T2>(v11, arg6));
        };
    }

    // decompiled from Move bytecode v7
}

