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
        if (arg3 == 0 || 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::is_pause<T0, T1>(arg1)) {
            return (0, false)
        };
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg1);
        let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg1);
        let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(v2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg1), arg2);
        let v4 = arg3;
        let v5 = 0;
        let v6 = 0;
        let v7 = if (arg2) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        loop {
            let v8 = if (v4 > 0) {
                if (!0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_none(&v3)) {
                    if (v6 < 1024) {
                        v0 != v7
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v8) {
                let (v9, v10) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(v2, 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v3), arg2);
                v3 = v10;
                let v11 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::sqrt_price(v9);
                let v12 = if (arg2) {
                    0x1::u128::max(v11, v7)
                } else {
                    0x1::u128::min(v11, v7)
                };
                let (v13, v14, v15, v16) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::compute_swap_step(v0, v12, v1, v4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg1), arg2, true);
                let v17 = v4 - v13;
                v4 = v17 - v16;
                v5 = v5 + v14;
                v0 = v15;
                if (v15 == v11) {
                    let v18 = if (arg2) {
                        0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::neg(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v9))
                    } else {
                        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v9)
                    };
                    let v19 = if (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::is_neg(v18)) {
                        v1 - 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v18)
                    } else {
                        v1 + 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v18)
                    };
                    v1 = v19;
                };
                v6 = v6 + 1;
            } else {
                break
            };
        };
        let (v20, v21) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::balances<T0, T1>(arg1);
        let v22 = if (v4 == 0) {
            let v23 = if (arg2) {
                v21
            } else {
                v20
            };
            v5 <= v23
        } else {
            false
        };
        (v5, v22)
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

