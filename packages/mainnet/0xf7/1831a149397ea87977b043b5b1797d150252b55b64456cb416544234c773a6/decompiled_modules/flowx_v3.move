module 0xf71831a149397ea87977b043b5b1797d150252b55b64456cb416544234c773a6::flowx_v3 {
    fun check_gate(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned) {
        gate(0x2::bcs::to_bytes<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned>(arg0));
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::check_version(arg0);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::check_pause(arg0);
    }

    public fun flash_a2b<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt) {
        check_gate(arg3);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2);
        let v1 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T0>(arg0);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, true, true, v1, limit<T0, T1>(v0, true), arg3, arg4, arg5);
        let v5 = v4;
        let v6 = v3;
        0x2::balance::destroy_zero<T0>(v2);
        let (v7, v8) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v5);
        assert!(v7 == v1 && v8 == 0, 1);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T0, T1>(v0), true, 0x2::balance::value<T1>(&v6));
        (v6, v5)
    }

    public fun flash_a2b_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt) {
        check_gate(arg3);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2);
        let v1 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T0>(arg0);
        assert!(arg6, 1);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, true, true, v1, arg5, arg3, arg4, arg7);
        let v5 = v4;
        let v6 = v3;
        0x2::balance::destroy_zero<T0>(v2);
        let (v7, v8) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v5);
        assert!(v7 == v1 && v8 == 0, 1);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T0, T1>(v0), true, 0x2::balance::value<T1>(&v6));
        (v6, v5)
    }

    public fun flash_b2a<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt) {
        check_gate(arg3);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2);
        let v1 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T1>(arg0);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, false, true, v1, limit<T0, T1>(v0, false), arg3, arg4, arg5);
        let v5 = v4;
        let v6 = v2;
        0x2::balance::destroy_zero<T1>(v3);
        let (v7, v8) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v5);
        assert!(v8 == v1 && v7 == 0, 1);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T1>(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T0, T1>(v0), false, 0x2::balance::value<T0>(&v6));
        (v6, v5)
    }

    public fun flash_b2a_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt) {
        check_gate(arg3);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2);
        let v1 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T1>(arg0);
        assert!(arg6, 1);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, false, true, v1, arg5, arg3, arg4, arg7);
        let v5 = v4;
        let v6 = v2;
        0x2::balance::destroy_zero<T1>(v3);
        let (v7, v8) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v5);
        assert!(v8 == v1 && v7 == 0, 1);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T1>(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T0, T1>(v0), false, 0x2::balance::value<T0>(&v6));
        (v6, v5)
    }

    fun gate(arg0: vector<u8>) {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 4);
        assert!(0x2::bcs::peel_u64(&mut v0) == 6, 3);
    }

    fun limit<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: bool) : u128 {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg0);
        if (arg1) {
            0x1::u128::max(v0 - v0 / 9, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_sqrt_price() + 1)
        } else {
            0x1::u128::min(v0 + v0 / 8, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_sqrt_price() - 1)
        }
    }

    public fun quote<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: bool) {
        check_gate(arg3);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T1, T2>(arg1, arg2);
        let v1 = vector[];
        let v2 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::quote_inputs<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            0x1::vector::push_back<u64>(&mut v1, simulate<T1, T2>(v0, 0x1::vector::pop_back<u64>(&mut v2), arg4));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u64>(v2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_quote<T0>(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T1, T2>(v0), arg4, v1, vector[], vector[]);
    }

    public fun repay_a2b<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: 0x2::balance::Balance<T0>, arg5: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        check_gate(arg3);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2), arg5, 0x2::balance::split<T0>(&mut arg4, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T0>(arg0, &mut arg4)), 0x2::balance::zero<T1>(), arg3, arg6);
        arg4
    }

    public fun repay_b2a<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: 0x2::balance::Balance<T1>, arg5: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        check_gate(arg3);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2), arg5, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg4, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T1>(arg0, &mut arg4)), arg3, arg6);
        arg4
    }

    fun simulate<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        if (arg1 == 0 || 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::is_locked<T0, T1>(arg0)) {
            return 0
        };
        let v0 = limit<T0, T1>(arg0, arg2);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg0);
        if (arg2 && v0 >= v1 || !arg2 && v0 <= v1) {
            return 0
        };
        let (v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::reserves<T0, T1>(arg0);
        let v4 = if (arg2) {
            v2
        } else {
            v3
        };
        let v5 = if (arg2) {
            v3
        } else {
            v2
        };
        if ((v4 as u128) + (arg1 as u128) > 18446744073709551615) {
            return 0
        };
        let v6 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_index_current<T0, T1>(arg0);
        let v7 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::liquidity<T0, T1>(arg0);
        let v8 = arg1;
        let v9 = 0;
        while (v8 > 0 && v1 != v0) {
            let (v10, v11) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_bitmap::next_initialized_tick_within_one_word(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_tick_bitmap<T0, T1>(arg0), v6, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_spacing<T0, T1>(arg0), arg2);
            let v12 = v10;
            if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::lt(v10, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick())) {
                v12 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick();
            };
            if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::gt(v12, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick())) {
                v12 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick();
            };
            let v13 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::get_sqrt_price_at_tick(v12);
            let v14 = if (arg2) {
                0x1::u128::max(v13, v0)
            } else {
                0x1::u128::min(v13, v0)
            };
            let (v15, v16, v17, v18) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_math::compute_swap_step(v1, v14, v7, v8, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_fee_rate<T0, T1>(arg0), true);
            let v19 = v8 - v16;
            v8 = v19 - v18;
            v9 = v9 + v17;
            if (v15 == v13) {
                if (v11) {
                    let v20 = if (arg2) {
                        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::neg(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_ticks<T0, T1>(arg0), v12))
                    } else {
                        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_ticks<T0, T1>(arg0), v12)
                    };
                    v7 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::liquidity_math::add_delta(v7, v20);
                };
                let v21 = if (arg2) {
                    0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::sub(v12, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from(1))
                } else {
                    v12
                };
                v6 = v21;
            } else if (v15 != v1) {
                v6 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::get_tick_at_sqrt_price(v15);
            };
            v1 = v15;
        };
        if (v8 != 0 || v9 > v5) {
            0
        } else {
            v9
        }
    }

    public fun swap_x2y<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        check_gate(arg3);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T1, T2>(arg1, arg2);
        let v1 = 0x2::balance::value<T1>(&arg5);
        assert!(v1 > 0, 2);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T1, T2>(v0, true, true, v1, limit<T1, T2>(v0, true), arg3, arg4, arg6);
        let v5 = v4;
        let v6 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let (v7, v8) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v5);
        assert!(v7 == v1 && v8 == 0, 1);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T1, T2>(v0, v5, 0x2::balance::split<T1>(&mut arg5, v7), 0x2::balance::zero<T2>(), arg3, arg6);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T1, T2>(v0), true, 0x2::balance::value<T2>(&v6));
        (v6, arg5)
    }

    public fun swap_x2y_limit<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T1>, arg6: u128, arg7: bool, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        check_gate(arg3);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T1, T2>(arg1, arg2);
        let v1 = 0x2::balance::value<T1>(&arg5);
        assert!(v1 > 0, 2);
        assert!(arg7, 1);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T1, T2>(v0, true, true, v1, arg6, arg3, arg4, arg8);
        let v5 = v4;
        let v6 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let (v7, v8) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v5);
        assert!(v7 == v1 && v8 == 0, 1);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T1, T2>(v0, v5, 0x2::balance::split<T1>(&mut arg5, v7), 0x2::balance::zero<T2>(), arg3, arg8);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T1, T2>(v0), true, 0x2::balance::value<T2>(&v6));
        (v6, arg5)
    }

    public fun swap_y2x<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T2>, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        check_gate(arg3);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T1, T2>(arg1, arg2);
        let v1 = 0x2::balance::value<T2>(&arg5);
        assert!(v1 > 0, 2);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T1, T2>(v0, false, true, v1, limit<T1, T2>(v0, false), arg3, arg4, arg6);
        let v5 = v4;
        let v6 = v2;
        0x2::balance::destroy_zero<T2>(v3);
        let (v7, v8) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v5);
        assert!(v8 == v1 && v7 == 0, 1);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T1, T2>(v0, v5, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut arg5, v8), arg3, arg6);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T1, T2>(v0), false, 0x2::balance::value<T1>(&v6));
        (v6, arg5)
    }

    public fun swap_y2x_limit<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T2>, arg6: u128, arg7: bool, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        check_gate(arg3);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T1, T2>(arg1, arg2);
        let v1 = 0x2::balance::value<T2>(&arg5);
        assert!(v1 > 0, 2);
        assert!(arg7, 1);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T1, T2>(v0, false, true, v1, arg6, arg3, arg4, arg8);
        let v5 = v4;
        let v6 = v2;
        0x2::balance::destroy_zero<T2>(v3);
        let (v7, v8) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v5);
        assert!(v8 == v1 && v7 == 0, 1);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T1, T2>(v0, v5, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut arg5, v8), arg3, arg8);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T1, T2>(v0), false, 0x2::balance::value<T1>(&v6));
        (v6, arg5)
    }

    // decompiled from Move bytecode v7
}

