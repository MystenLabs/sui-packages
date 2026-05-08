module 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::trade {
    struct SwapState has drop {
        amount_remaining: u64,
        amount_output: u64,
        sqrt_price: u128,
        tick_index: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32,
        fee_amount: u64,
        liquidity: u128,
        protocol_fee: u64,
        fee_growth_global: u128,
    }

    struct SwapStep has drop {
        sqrt_price_start: u128,
        tick_index_next: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32,
        initialized: bool,
        sqrt_price_next: u128,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
    }

    public fun swap<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg2: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = swap_returns<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, true, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg8);
        if (0x2::coin::value<T0>(&v3) == 0) {
            0x2::coin::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v4);
        };
        if (0x2::coin::value<T1>(&v2) == 0) {
            0x2::coin::destroy_zero<T1>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v4);
        };
    }

    public fun swap_returns<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg2: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_min_version(arg0);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_trading_enabled(arg0);
        if (arg5) {
            assert!(0x2::coin::value<T0>(&arg3) > 0, 1);
            assert!(0x2::coin::value<T1>(&arg4) == 0, 2);
        } else {
            assert!(0x2::coin::value<T1>(&arg4) > 0, 1);
            assert!(0x2::coin::value<T0>(&arg3) == 0, 2);
        };
        let v0 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::is_hop_launch<T0, T1>(arg2);
        let v1 = 0x2::coin::into_balance<T0>(arg3);
        let v2 = 0x2::coin::into_balance<T1>(arg4);
        let v3 = 0;
        let (v4, v5) = if (arg5) {
            (0x2::balance::value<T0>(&v1), 0x2::balance::value<T0>(&v1))
        } else {
            (0x2::balance::value<T1>(&v2), 0x2::balance::value<T1>(&v2))
        };
        let v6 = if (arg5) {
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::fee_growth_global_x<T0, T1>(arg2)
        } else {
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::fee_growth_global_y<T0, T1>(arg2)
        };
        let v7 = SwapState{
            amount_remaining  : v4,
            amount_output     : 0,
            sqrt_price        : 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::sqrt_price<T0, T1>(arg2),
            tick_index        : 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::tick_index<T0, T1>(arg2),
            fee_amount        : 0,
            liquidity         : 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::liquidity<T0, T1>(arg2),
            protocol_fee      : 0,
            fee_growth_global : v6,
        };
        while (v7.amount_remaining > 0 && v7.sqrt_price != arg7) {
            let v8 = SwapStep{
                sqrt_price_start : v7.sqrt_price,
                tick_index_next  : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::zero(),
                initialized      : false,
                sqrt_price_next  : 0,
                amount_in        : 0,
                amount_out       : 0,
                fee_amount       : 0,
            };
            let (v9, v10) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_bitmap::next_initialized_tick_within_one_word(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::borrow_tick_bitmap<T0, T1>(arg2), v7.tick_index, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::tick_spacing<T0, T1>(arg2), arg5);
            v8.tick_index_next = v9;
            v8.initialized = v10;
            if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lt(v9, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::min_tick())) {
                v8.tick_index_next = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::min_tick();
            } else if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::gt(v9, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::max_tick())) {
                v8.tick_index_next = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::max_tick();
            };
            v8.sqrt_price_next = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::get_sqrt_price_at_tick(v8.tick_index_next);
            let v11 = if (arg5) {
                0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::max(v8.sqrt_price_next, arg7)
            } else {
                0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::min(v8.sqrt_price_next, arg7)
            };
            let (v12, v13, v14, v15) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::swap_math::compute_swap_step(v7.sqrt_price, v11, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::liquidity<T0, T1>(arg2), v7.amount_remaining, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::lp_fee<T0, T1>(arg2), arg5, true);
            v8.amount_in = v12;
            v8.amount_out = v13;
            v8.fee_amount = v15;
            let v16 = if (v12 == 0) {
                if (v13 == 0) {
                    v14 == v7.sqrt_price
                } else {
                    false
                }
            } else {
                false
            };
            if (v16) {
                break
            };
            v7.sqrt_price = v14;
            v7.amount_remaining = v7.amount_remaining - v8.amount_in + v8.fee_amount;
            v7.amount_output = v7.amount_output + v8.amount_out;
            if (!v0 && 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::protocol_fee_rate(arg0) > 0) {
                let v17 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u64::mul_div_floor(v8.fee_amount, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::protocol_fee_rate(arg0), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::swap_math::fee_rate_denominator());
                v8.fee_amount = v8.fee_amount - v17;
                v7.protocol_fee = v7.protocol_fee + v17;
            };
            if (v7.liquidity > 0) {
                v7.fee_growth_global = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_add(v7.fee_growth_global, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::mul_div_floor((v8.fee_amount as u128), (0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::constants::q64() as u128), v7.liquidity));
            };
            v7.fee_amount = v7.fee_amount + v8.fee_amount;
            if (v7.sqrt_price == v8.sqrt_price_next) {
                let (v18, v19) = if (arg5) {
                    (v7.fee_growth_global, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::fee_growth_global_y<T0, T1>(arg2))
                } else {
                    (0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::fee_growth_global_x<T0, T1>(arg2), v7.fee_growth_global)
                };
                if (v8.initialized) {
                    let v20 = if (arg5) {
                        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::neg(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::cross(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::borrow_tick_table_mut<T0, T1>(arg2), v8.tick_index_next, v18, v19))
                    } else {
                        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::cross(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::borrow_tick_table_mut<T0, T1>(arg2), v8.tick_index_next, v18, v19)
                    };
                    let v21 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v20);
                    if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::is_neg(v20)) {
                        assert!(v7.liquidity >= v21, 0);
                        v7.liquidity = v7.liquidity - v21;
                    } else {
                        v7.liquidity = v7.liquidity + v21;
                    };
                    0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::set_liquidity<T0, T1>(arg2, v7.liquidity);
                };
                let v22 = if (arg5) {
                    0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(v8.tick_index_next, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(1))
                } else {
                    v8.tick_index_next
                };
                v7.tick_index = v22;
                continue
            };
            if (v7.sqrt_price != v8.sqrt_price_start) {
                v7.tick_index = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::get_tick_at_sqrt_price(v7.sqrt_price);
            };
        };
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::set_sqrt_price<T0, T1>(arg2, v7.sqrt_price);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::set_tick_index<T0, T1>(arg2, v7.tick_index);
        if (arg5) {
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::set_fee_growth_global_x<T0, T1>(arg2, v7.fee_growth_global);
            if (v7.protocol_fee > 0) {
                0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::add_protocol_fee_x<T0, T1>(arg2, 0x2::balance::split<T0>(&mut v1, v7.protocol_fee));
            };
        } else {
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::set_fee_growth_global_y<T0, T1>(arg2, v7.fee_growth_global);
            if (v7.protocol_fee > 0) {
                0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::add_protocol_fee_y<T0, T1>(arg2, 0x2::balance::split<T1>(&mut v2, v7.protocol_fee));
            };
        };
        let (v23, v24) = if (arg5 == true) {
            (0x2::balance::value<T0>(&v1) - v7.amount_remaining, v7.amount_output)
        } else {
            (v7.amount_output, 0x2::balance::value<T1>(&v2) - v7.amount_remaining)
        };
        if (arg5) {
            let (v25, v26) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::decrease_reserves<T0, T1>(arg2, 0, v24);
            0x2::balance::destroy_zero<T0>(v25);
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::increase_reserves<T0, T1>(arg2, 0x2::balance::split<T0>(&mut v1, v23), 0x2::balance::zero<T1>());
            0x2::balance::join<T1>(&mut v2, v26);
        } else {
            let (v27, v28) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::decrease_reserves<T0, T1>(arg2, v23, 0);
            0x2::balance::destroy_zero<T1>(v28);
            let v29 = v24;
            if (v0) {
                let (v30, v31) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::get_creator_protocol_rate(arg1, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::market_cap_sui<T0, T1>(arg2));
                let v32 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::apply_fee(arg1, v24, v30);
                v3 = v32;
                let v33 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::apply_fee(arg1, v24, v31);
                v29 = v24 - v32 - v33;
                0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::add_creator_fees<T0, T1>(arg2, 0x2::balance::split<T1>(&mut v2, v32));
                0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::add_protocol_fee_y<T0, T1>(arg2, 0x2::balance::split<T1>(&mut v2, v33));
            };
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::increase_reserves<T0, T1>(arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v2, v29));
            0x2::balance::join<T0>(&mut v1, v27);
        };
        if (arg5 && v0) {
            let (v34, v35) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::get_creator_protocol_rate(arg1, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::market_cap_sui<T0, T1>(arg2));
            let v36 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::apply_fee(arg1, 0x2::balance::value<T1>(&v2), v34);
            v3 = v36;
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::add_creator_fees<T0, T1>(arg2, 0x2::balance::split<T1>(&mut v2, v36));
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::add_protocol_fee_y<T0, T1>(arg2, 0x2::balance::split<T1>(&mut v2, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::apply_fee(arg1, 0x2::balance::value<T1>(&v2), v35)));
        };
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::events::emit_swap_event(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::id<T0, T1>(arg2), 0x2::tx_context::sender(arg8), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), arg5, v5, v7.amount_output, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::reserve_x<T0, T1>(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::reserve_y<T0, T1>(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::liquidity<T0, T1>(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::sqrt_price<T0, T1>(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::sqrt_price<T0, T1>(arg2), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::as_u32(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::tick_index<T0, T1>(arg2)), v3);
        (0x2::coin::from_balance<T0>(v1, arg8), 0x2::coin::from_balance<T1>(v2, arg8))
    }

    // decompiled from Move bytecode v7
}

