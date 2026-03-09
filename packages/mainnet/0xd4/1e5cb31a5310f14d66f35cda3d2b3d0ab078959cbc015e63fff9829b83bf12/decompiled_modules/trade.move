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
        let (v0, v1) = swap_returns<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
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
        let v0 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::is_hop_launch<T0, T1>(arg2);
        let v1 = 0x2::coin::into_balance<T0>(arg3);
        let v2 = 0x2::coin::into_balance<T1>(arg4);
        let v3 = 0;
        let (v4, v5) = if (arg5) {
            (0x2::balance::value<T0>(&v1), 0x2::balance::value<T0>(&v1))
        } else {
            if (v0) {
                let (v6, v7) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::get_creator_protocol_rate(arg1, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::market_cap_sui<T0, T1>(arg2));
                let v8 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::apply_fee(arg1, 0x2::balance::value<T1>(&v2), v6);
                v3 = v8;
                0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::add_creator_fees<T0, T1>(arg2, 0x2::balance::split<T1>(&mut v2, v8));
                0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::add_protocol_fee_y<T0, T1>(arg2, 0x2::balance::split<T1>(&mut v2, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::apply_fee(arg1, 0x2::balance::value<T1>(&v2), v7)));
            };
            (0x2::balance::value<T1>(&v2), 0x2::balance::value<T1>(&v2))
        };
        let v9 = if (arg5) {
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::fee_growth_global_x<T0, T1>(arg2)
        } else {
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::fee_growth_global_y<T0, T1>(arg2)
        };
        let v10 = SwapState{
            amount_remaining  : v4,
            amount_output     : 0,
            sqrt_price        : 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::sqrt_price<T0, T1>(arg2),
            tick_index        : 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::tick_index<T0, T1>(arg2),
            fee_amount        : 0,
            liquidity         : 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::liquidity<T0, T1>(arg2),
            protocol_fee      : 0,
            fee_growth_global : v9,
        };
        while (v10.amount_remaining > 0 && v10.sqrt_price != arg7) {
            let v11 = SwapStep{
                sqrt_price_start : v10.sqrt_price,
                tick_index_next  : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::zero(),
                initialized      : false,
                sqrt_price_next  : 0,
                amount_in        : 0,
                amount_out       : 0,
                fee_amount       : 0,
            };
            let (v12, v13) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_bitmap::next_initialized_tick_within_one_word(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::borrow_tick_bitmap<T0, T1>(arg2), v10.tick_index, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::tick_spacing<T0, T1>(arg2), arg5);
            v11.tick_index_next = v12;
            v11.initialized = v13;
            if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lt(v12, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::min_tick())) {
                v11.tick_index_next = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::min_tick();
            } else if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::gt(v12, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::max_tick())) {
                v11.tick_index_next = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::max_tick();
            };
            v11.sqrt_price_next = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::get_sqrt_price_at_tick(v11.tick_index_next);
            let v14 = if (arg5) {
                0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::max(v11.sqrt_price_next, arg7)
            } else {
                0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::min(v11.sqrt_price_next, arg7)
            };
            let (v15, v16, v17, v18) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::swap_math::compute_swap_step(v10.sqrt_price, v14, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::liquidity<T0, T1>(arg2), v10.amount_remaining, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::lp_fee<T0, T1>(arg2), arg5, arg6);
            v11.amount_in = v15;
            v11.amount_out = v16;
            v11.fee_amount = v18;
            let v19 = if (v15 == 0) {
                if (v16 == 0) {
                    v17 == v10.sqrt_price
                } else {
                    false
                }
            } else {
                false
            };
            if (v19) {
                break
            };
            v10.sqrt_price = v17;
            if (arg6) {
                v10.amount_remaining = v10.amount_remaining - v11.amount_in + v11.fee_amount;
                v10.amount_output = v10.amount_output + v11.amount_out;
            } else {
                v10.amount_remaining = v10.amount_remaining - v11.amount_out;
                v10.amount_output = v10.amount_output + v11.amount_in + v11.fee_amount;
            };
            if (!v0 && 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::protocol_fee_rate(arg0) > 0) {
                let v20 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u64::mul_div_floor(v11.fee_amount, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::protocol_fee_rate(arg0), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::swap_math::fee_rate_denominator());
                v11.fee_amount = v11.fee_amount - v20;
                v10.protocol_fee = v10.protocol_fee + v20;
            };
            if (v10.liquidity > 0) {
                v10.fee_growth_global = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_add(v10.fee_growth_global, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::mul_div_floor((v11.fee_amount as u128), (0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::constants::q64() as u128), v10.liquidity));
            };
            v10.fee_amount = v10.fee_amount + v11.fee_amount;
            if (v10.sqrt_price == v11.sqrt_price_next) {
                let (v21, v22) = if (arg5) {
                    (v10.fee_growth_global, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::fee_growth_global_y<T0, T1>(arg2))
                } else {
                    (0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::fee_growth_global_x<T0, T1>(arg2), v10.fee_growth_global)
                };
                if (v11.initialized) {
                    let v23 = if (arg5) {
                        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::neg(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::cross(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::borrow_tick_table_mut<T0, T1>(arg2), v11.tick_index_next, v21, v22))
                    } else {
                        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::cross(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::borrow_tick_table_mut<T0, T1>(arg2), v11.tick_index_next, v21, v22)
                    };
                    let v24 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v23);
                    if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::is_neg(v23)) {
                        assert!(v10.liquidity >= v24, 0);
                        v10.liquidity = v10.liquidity - v24;
                    } else {
                        v10.liquidity = v10.liquidity + v24;
                    };
                    0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::set_liquidity<T0, T1>(arg2, v10.liquidity);
                };
                let v25 = if (arg5) {
                    0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(v11.tick_index_next, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(1))
                } else {
                    v11.tick_index_next
                };
                v10.tick_index = v25;
                continue
            };
            if (v10.sqrt_price != v11.sqrt_price_start) {
                v10.tick_index = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::get_tick_at_sqrt_price(v10.sqrt_price);
            };
        };
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::set_sqrt_price<T0, T1>(arg2, v10.sqrt_price);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::set_tick_index<T0, T1>(arg2, v10.tick_index);
        if (arg5) {
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::set_fee_growth_global_x<T0, T1>(arg2, v10.fee_growth_global);
            if (v10.protocol_fee > 0) {
                0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::add_protocol_fee_x<T0, T1>(arg2, 0x2::balance::split<T0>(&mut v1, v10.protocol_fee));
            };
        } else {
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::set_fee_growth_global_y<T0, T1>(arg2, v10.fee_growth_global);
            if (v10.protocol_fee > 0) {
                0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::add_protocol_fee_y<T0, T1>(arg2, 0x2::balance::split<T1>(&mut v2, v10.protocol_fee));
            };
        };
        let (v26, v27) = if (arg5 == arg6) {
            (0x2::balance::value<T0>(&v1) - v10.amount_remaining, v10.amount_output)
        } else {
            (v10.amount_output, 0x2::balance::value<T1>(&v2) - v10.amount_remaining)
        };
        if (arg5) {
            let (v28, v29) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::decrease_reserves<T0, T1>(arg2, 0, v27);
            0x2::balance::destroy_zero<T0>(v28);
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::increase_reserves<T0, T1>(arg2, 0x2::balance::split<T0>(&mut v1, v26), 0x2::balance::zero<T1>());
            0x2::balance::join<T1>(&mut v2, v29);
        } else {
            let (v30, v31) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::decrease_reserves<T0, T1>(arg2, v26, 0);
            0x2::balance::destroy_zero<T1>(v31);
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::increase_reserves<T0, T1>(arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v2, v27));
            0x2::balance::join<T0>(&mut v1, v30);
        };
        if (arg5 && v0) {
            let (v32, v33) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::get_creator_protocol_rate(arg1, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::market_cap_sui<T0, T1>(arg2));
            let v34 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::apply_fee(arg1, 0x2::balance::value<T1>(&v2), v32);
            v3 = v34;
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::add_creator_fees<T0, T1>(arg2, 0x2::balance::split<T1>(&mut v2, v34));
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::add_protocol_fee_y<T0, T1>(arg2, 0x2::balance::split<T1>(&mut v2, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::apply_fee(arg1, 0x2::balance::value<T1>(&v2), v33)));
        };
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::events::emit_swap_event(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::id<T0, T1>(arg2), 0x2::tx_context::sender(arg8), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), arg5, v5, v10.amount_output, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::reserve_x<T0, T1>(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::reserve_y<T0, T1>(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::liquidity<T0, T1>(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::sqrt_price<T0, T1>(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::sqrt_price<T0, T1>(arg2), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::as_u32(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::tick_index<T0, T1>(arg2)), v3);
        (0x2::coin::from_balance<T0>(v1, arg8), 0x2::coin::from_balance<T1>(v2, arg8))
    }

    // decompiled from Move bytecode v6
}

