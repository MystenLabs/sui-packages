module 0xfd648201fde8dbdced6622b43976d87ba65618edde470041da84248a72237d26::registry_venues {
    struct Witness has drop {
        dummy_field: bool,
    }

    public fun flowx_quote<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: bool, arg2: u64) : u64 {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T0, T1>(arg0);
        let (v1, v2) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(v0);
        let v3 = if (arg2 == 0) {
            true
        } else if (v1 == 0) {
            true
        } else {
            v2 == 0
        };
        if (v3) {
            return 0
        };
        let v4 = if (arg1) {
            v1
        } else {
            v2
        };
        let v5 = if (arg1) {
            v2
        } else {
            v1
        };
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::get_amount_out(arg2, v4, v5, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(v0))
    }

    fun flowxv3_quote<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : (u64, bool) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg0);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_index_current<T0, T1>(arg0);
        let v2 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::liquidity<T0, T1>(arg0);
        let v3 = if (arg1) {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_sqrt_price() + 1
        } else {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_sqrt_price() - 1
        };
        let v4 = arg2;
        let v5 = 0;
        let v6 = 0;
        loop {
            let v7 = if (v4 > 0) {
                if (v0 != v3) {
                    v6 < 1024
                } else {
                    false
                }
            } else {
                false
            };
            if (v7) {
                let (v8, v9) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_bitmap::next_initialized_tick_within_one_word(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_tick_bitmap<T0, T1>(arg0), v1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_spacing<T0, T1>(arg0), arg1);
                let v10 = v8;
                if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::lt(v8, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick())) {
                    v10 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick();
                };
                if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::gt(v10, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick())) {
                    v10 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick();
                };
                let v11 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::get_sqrt_price_at_tick(v10);
                let v12 = if (arg1) {
                    0x1::u128::max(v11, v3)
                } else {
                    0x1::u128::min(v11, v3)
                };
                let v13 = v0;
                let (v14, v15, v16, v17) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_math::compute_swap_step(v0, v12, v2, v4, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_fee_rate<T0, T1>(arg0), true);
                v0 = v14;
                let v18 = v4 - v15;
                v4 = v18 - v17;
                v5 = v5 + v16;
                if (v14 == v11) {
                    if (v9) {
                        let v19 = if (arg1) {
                            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::neg(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_ticks<T0, T1>(arg0), v10))
                        } else {
                            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_ticks<T0, T1>(arg0), v10)
                        };
                        v2 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::liquidity_math::add_delta(v2, v19);
                    };
                    let v20 = if (arg1) {
                        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::sub(v10, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from(1))
                    } else {
                        v10
                    };
                    v1 = v20;
                } else if (v14 != v13) {
                    v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::get_tick_at_sqrt_price(v14);
                };
                v6 = v6 + 1;
            } else {
                break
            };
        };
        let (v21, v22) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::reserves<T0, T1>(arg0);
        let v23 = if (arg2 > 0) {
            if (v4 == 0) {
                let v24 = if (arg1) {
                    v22
                } else {
                    v21
                };
                v5 <= v24
            } else {
                false
            }
        } else {
            false
        };
        (v5, v23)
    }

    public fun quote_flowx<T0, T1, T2, T3>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: bool, arg4: u64, arg5: bool) {
        let v0 = 0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T2, T3>>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T2, T3>(arg2));
        let v1 = if (arg3) {
            let v2 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T2, Witness>(arg0, arg1, &v2, v0, arg4, arg5)
        } else {
            let v3 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T3, Witness>(arg0, arg1, &v3, v0, arg4, arg5)
        };
        if (arg3) {
            let v4 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T2, T3, Witness>(arg0, arg1, &v4, 10, v0, true, v1, flowx_quote<T2, T3>(arg2, arg3, v1), v1 > 0);
        } else {
            let v5 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T3, T2, Witness>(arg0, arg1, &v5, 10, v0, false, v1, flowx_quote<T2, T3>(arg2, arg3, v1), v1 > 0);
        };
    }

    public fun quote_flowxv3<T0, T1, T2, T3>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: bool, arg5: u64, arg6: bool) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T2, T3>(arg2, arg3);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T3>(v0);
        let v2 = if (arg4) {
            let v3 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T2, Witness>(arg0, arg1, &v3, v1, arg5, arg6)
        } else {
            let v4 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T3, Witness>(arg0, arg1, &v4, v1, arg5, arg6)
        };
        let (v5, v6) = flowxv3_quote<T2, T3>(v0, arg4, v2);
        if (arg4) {
            let v7 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T2, T3, Witness>(arg0, arg1, &v7, 11, v1, true, v2, v5, v6);
        } else {
            let v8 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T3, T2, Witness>(arg0, arg1, &v8, 11, v1, false, v2, v5, v6);
        };
    }

    public fun quote_state_flowxv3<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: bool, arg3: u64) : (u64, bool) {
        flowxv3_quote<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T0, T1>(arg0, arg1), arg2, arg3)
    }

    public fun swap_flowx<T0, T1, T2, T3>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair<T2, T3>(arg2);
        if (arg3) {
            let v1 = Witness{dummy_field: false};
            let v2 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T2, T3, Witness>(arg0, arg1, &v1, 10, 0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T2, T3>>(v0), true, arg5);
            if (0x1::option::is_none<0x2::coin::Coin<T2>>(&v2)) {
                0x1::option::destroy_none<0x2::coin::Coin<T2>>(v2);
                return
            };
            let v3 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T3, Witness>(arg0, arg1, &v3, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_x_to_y_direct<T2, T3>(v0, 0x1::option::destroy_some<0x2::coin::Coin<T2>>(v2), arg5));
        } else {
            let v4 = Witness{dummy_field: false};
            let v5 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T3, T2, Witness>(arg0, arg1, &v4, 10, 0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T2, T3>>(v0), false, arg5);
            if (0x1::option::is_none<0x2::coin::Coin<T3>>(&v5)) {
                0x1::option::destroy_none<0x2::coin::Coin<T3>>(v5);
                return
            };
            let v6 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T2, Witness>(arg0, arg1, &v6, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_y_to_x_direct<T2, T3>(v0, 0x1::option::destroy_some<0x2::coin::Coin<T3>>(v5), arg5));
        };
    }

    public fun swap_flowxv3<T0, T1, T2, T3>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T2, T3>(arg2, arg3);
        if (arg5) {
            let v1 = Witness{dummy_field: false};
            let v2 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T2, T3, Witness>(arg0, arg1, &v1, 11, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T3>(v0), true, arg7);
            if (0x1::option::is_none<0x2::coin::Coin<T2>>(&v2)) {
                0x1::option::destroy_none<0x2::coin::Coin<T2>>(v2);
                return
            };
            let v3 = 0x1::option::destroy_some<0x2::coin::Coin<T2>>(v2);
            let v4 = 0x2::coin::value<T2>(&v3);
            let (v5, v6, v7) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T2, T3>(v0, true, true, v4, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_sqrt_price() + 1, arg4, arg6, arg7);
            let v8 = v7;
            0x2::balance::destroy_zero<T2>(v5);
            let (v9, v10) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v8);
            assert!(v9 == v4 && v10 == 0, 0);
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T2, T3>(v0, v8, 0x2::coin::into_balance<T2>(v3), 0x2::balance::zero<T3>(), arg4, arg7);
            let v11 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T3, Witness>(arg0, arg1, &v11, 0x2::coin::from_balance<T3>(v6, arg7));
        } else {
            let v12 = Witness{dummy_field: false};
            let v13 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T3, T2, Witness>(arg0, arg1, &v12, 11, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T3>(v0), false, arg7);
            if (0x1::option::is_none<0x2::coin::Coin<T3>>(&v13)) {
                0x1::option::destroy_none<0x2::coin::Coin<T3>>(v13);
                return
            };
            let v14 = 0x1::option::destroy_some<0x2::coin::Coin<T3>>(v13);
            let v15 = 0x2::coin::value<T3>(&v14);
            let (v16, v17, v18) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T2, T3>(v0, false, true, v15, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_sqrt_price() - 1, arg4, arg6, arg7);
            let v19 = v18;
            0x2::balance::destroy_zero<T3>(v17);
            let (v20, v21) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v19);
            assert!(v20 == 0 && v21 == v15, 0);
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T2, T3>(v0, v19, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T3>(v14), arg4, arg7);
            let v22 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T2, Witness>(arg0, arg1, &v22, 0x2::coin::from_balance<T2>(v16, arg7));
        };
    }

    // decompiled from Move bytecode v7
}

