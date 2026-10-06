module 0xf03a52516f6b2bc13898998b57e591691211df0b29c86073f45225f9a8916531::turbos {
    fun check_gate(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned) {
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::version(arg0) == 18, 3);
    }

    fun computed<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool_fetcher::compute_swap_result<T0, T1, T2>(arg0, arg4, (arg3 as u128), true, limit(arg4), arg2, arg1, arg5);
        let v1 = 0x2::bcs::new(0x2::bcs::to_bytes<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState>(&v0));
        0x2::bcs::peel_u128(&mut v1);
        0x2::bcs::peel_u128(&mut v1);
        let v2 = 0x2::bcs::peel_u128(&mut v1);
        0x2::bcs::peel_u128(&mut v1);
        0x2::bcs::peel_u32(&mut v1);
        0x2::bcs::peel_u128(&mut v1);
        0x2::bcs::peel_u128(&mut v1);
        0x2::bcs::peel_u128(&mut v1);
        let v3 = 0x2::bcs::into_remainder_bytes(v1);
        assert!(0x1::vector::is_empty<u8>(&v3), 2);
        let v4 = if (0x2::bcs::peel_u128(&mut v1) != 0) {
            true
        } else if (0x2::bcs::peel_u128(&mut v1) == 0) {
            true
        } else {
            v2 > 18446744073709551615
        };
        if (v4) {
            return 0
        };
        (v2 as u64)
    }

    fun first_step<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool) : (u128, u128, u128, u32) {
        let (v0, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::next_initialized_tick_within_one_word<T0, T1, T2>(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0), arg1);
        let v2 = v0;
        if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::neg_from(443636))) {
            v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::neg_from(443636);
        } else if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gt(v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(443636))) {
            v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(443636);
        };
        let v3 = if (arg1) {
            0x1::u128::max(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v2), limit(arg1))
        } else {
            0x1::u128::min(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v2), limit(arg1))
        };
        (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), v3, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg0))
    }

    public fun flash_a2b<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>) {
        check_gate(arg2);
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg1, 0x2::tx_context::sender(arg4), true, (0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::open_loan<T0>(arg0) as u128), true, limit(true), arg3, arg2, arg4);
        0x2::coin::destroy_zero<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), true, 0x2::balance::value<T1>(&v3));
        (v3, v2)
    }

    public fun flash_b2a<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>) {
        check_gate(arg2);
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg1, 0x2::tx_context::sender(arg4), false, (0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::open_loan<T1>(arg0) as u128), true, limit(false), arg3, arg2, arg4);
        0x2::coin::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::into_balance<T0>(v0);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T1>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), false, 0x2::balance::value<T0>(&v3));
        (v3, v2)
    }

    fun limit(arg0: bool) : u128 {
        if (arg0) {
            4295048017
        } else {
            79226673515401279992447579054
        }
    }

    public fun quote<T0, T1, T2, T3>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        check_gate(arg2);
        let v0 = vector[];
        if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_unlocked<T1, T2, T3>(arg1)) {
            let (v1, v2, v3, v4) = first_step<T1, T2, T3>(arg1, arg4);
            let v5 = v3 > 0 && (arg4 && v2 < v1 || v2 > v1);
            let v6 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::quote_inputs<T0>(arg0);
            0x1::vector::reverse<u64>(&mut v6);
            let v7 = 0;
            while (v7 < 0x1::vector::length<u64>(&v6)) {
                let v8 = 0x1::vector::pop_back<u64>(&mut v6);
                let v9 = if (v8 == 0) {
                    0
                } else if (v5) {
                    let (v10, _, v12, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_swap::compute_swap(v1, v2, v3, (v8 as u128), true, v4);
                    if (v10 == v2) {
                        computed<T1, T2, T3>(arg1, arg2, arg3, v8, arg4, arg5)
                    } else if (v12 > 18446744073709551615) {
                        0
                    } else {
                        (v12 as u64)
                    }
                } else {
                    computed<T1, T2, T3>(arg1, arg2, arg3, v8, arg4, arg5)
                };
                0x1::vector::push_back<u64>(&mut v0, v9);
                v7 = v7 + 1;
            };
            0x1::vector::destroy_empty<u64>(v6);
        } else {
            let v6 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::quote_inputs<T0>(arg0);
            0x1::vector::reverse<u64>(&mut v6);
            let v14 = 0;
            while (v14 < 0x1::vector::length<u64>(&v6)) {
                0x1::vector::pop_back<u64>(&mut v6);
                0x1::vector::push_back<u64>(&mut v0, 0);
                v14 = v14 + 1;
            };
            0x1::vector::destroy_empty<u64>(v6);
        };
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_quote<T0>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>>(arg1), arg4, v0, vector[], vector[]);
    }

    public fun repay_a2b<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x2::balance::Balance<T0>, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        check_gate(arg2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3, 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::close_loan<T0>(arg0, &mut arg3)), arg5), 0x2::coin::zero<T1>(arg5), arg4, arg2);
        arg3
    }

    public fun repay_b2a<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x2::balance::Balance<T1>, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        check_gate(arg2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::zero<T0>(arg5), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg3, 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::close_loan<T1>(arg0, &mut arg3)), arg5), arg4, arg2);
        arg3
    }

    public fun swap_a2b<T0, T1, T2, T3>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        check_gate(arg2);
        let v0 = 0x2::balance::value<T1>(&arg4);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T1, T2, T3>(arg1, 0x2::tx_context::sender(arg5), true, (v0 as u128), true, limit(true), arg3, arg2, arg5);
        0x2::coin::destroy_zero<T1>(v1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T1, T2, T3>(arg1, 0x2::coin::from_balance<T1>(arg4, arg5), 0x2::coin::zero<T2>(arg5), v3, arg2);
        let v4 = 0x2::coin::into_balance<T2>(v2);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>>(arg1), true, 0x2::balance::value<T2>(&v4));
        (v4, 0x2::balance::zero<T1>())
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T2>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        check_gate(arg2);
        let v0 = 0x2::balance::value<T2>(&arg4);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T1, T2, T3>(arg1, 0x2::tx_context::sender(arg5), false, (v0 as u128), true, limit(false), arg3, arg2, arg5);
        0x2::coin::destroy_zero<T2>(v2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T1, T2, T3>(arg1, 0x2::coin::zero<T1>(arg5), 0x2::coin::from_balance<T2>(arg4, arg5), v3, arg2);
        let v4 = 0x2::coin::into_balance<T1>(v1);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>>(arg1), false, 0x2::balance::value<T1>(&v4));
        (v4, 0x2::balance::zero<T2>())
    }

    // decompiled from Move bytecode v7
}

