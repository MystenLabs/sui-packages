module 0xfd648201fde8dbdced6622b43976d87ba65618edde470041da84248a72237d26::oracle_venues {
    struct Witness has drop {
        dummy_field: bool,
    }

    public fun quote_bolt<T0, T1, T2, T3>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T2>, arg3: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg4: bool, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T2>>(arg2);
        let v1 = if (arg4) {
            let v2 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T2, Witness>(arg0, arg1, &v2, v0, arg5, arg6)
        } else {
            let v3 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T3, Witness>(arg0, arg1, &v3, v0, arg5, arg6)
        };
        let v4 = quote_state<T2, T3>(arg2, arg3, arg4, v1, arg7);
        if (arg4) {
            let v5 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T2, T3, Witness>(arg0, arg1, &v5, 6, v0, arg4, v1, v4, v4 > 0);
        } else {
            let v6 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T3, T2, Witness>(arg0, arg1, &v6, 6, v0, arg4, v1, v4, v4 > 0);
        };
    }

    public fun quote_state<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        if (arg3 == 0) {
            0
        } else {
            let v1 = if (arg2) {
                0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap<T0, T1>(arg0, arg1, arg4, arg3)
            } else {
                0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_buy_swap<T0, T1>(arg0, arg1, arg4, arg3)
            };
            let v2 = v1;
            let (v3, v4, _, _, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v2);
            if (arg2) {
                v4
            } else {
                v3
            }
        }
    }

    public fun swap_bolt<T0, T1, T2, T3>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T2>, arg3: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            let v0 = Witness{dummy_field: false};
            let v1 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T2, T3, Witness>(arg0, arg1, &v0, 6, 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T2>>(arg2), true, arg6);
            if (0x1::option::is_none<0x2::coin::Coin<T2>>(&v1)) {
                0x1::option::destroy_none<0x2::coin::Coin<T2>>(v1);
                return
            };
            let (v2, v3) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T2, T3>(arg2, arg3, arg5, 0x2::coin::into_balance<T2>(0x1::option::destroy_some<0x2::coin::Coin<T2>>(v1)), 0x1::option::none<u64>(), arg6);
            0x2::balance::destroy_zero<T2>(v2);
            let v4 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T3, Witness>(arg0, arg1, &v4, 0x2::coin::from_balance<T3>(v3, arg6));
        } else {
            let v5 = Witness{dummy_field: false};
            let v6 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T3, T2, Witness>(arg0, arg1, &v5, 6, 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T2>>(arg2), false, arg6);
            if (0x1::option::is_none<0x2::coin::Coin<T3>>(&v6)) {
                0x1::option::destroy_none<0x2::coin::Coin<T3>>(v6);
                return
            };
            let (v7, v8) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T2, T3>(arg2, arg3, arg5, 0x2::coin::into_balance<T3>(0x1::option::destroy_some<0x2::coin::Coin<T3>>(v6)), 0x1::option::none<u64>(), arg6);
            0x2::balance::destroy_zero<T3>(v8);
            let v9 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T2, Witness>(arg0, arg1, &v9, 0x2::coin::from_balance<T2>(v7, arg6));
        };
    }

    // decompiled from Move bytecode v7
}

