module 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::utils {
    struct SwapIfZeroEvent has copy, drop {
        vault_id: 0x2::object::ID,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        is_a: bool,
        amount_in: u64,
        amount_out: u64,
        timestamp_ms: u64,
    }

    public fun swap<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v2;
        let (v4, v5) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v3);
        if (arg3) {
            0x2::coin::join<T1>(&mut arg2, 0x2::coin::from_balance<T1>(v1, arg9));
            0x2::balance::destroy_zero<T0>(v0);
            0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v4, arg9)), 0x2::balance::zero<T1>(), arg8, arg9);
        } else {
            0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(v0, arg9));
            0x2::balance::destroy_zero<T1>(v1);
            0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v5, arg9)), arg8, arg9);
        };
        (arg1, arg2)
    }

    public fun check_is_fix_coin_a(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : (bool, u64, u64) {
        let (v0, v1) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity_math::get_amounts_for_liquidity(arg2, arg0, arg1, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity_math::get_liquidity_for_amounts(arg2, arg0, arg1, arg3, arg4), true);
        let v2 = v0 == arg3 || v0 == arg3 + 1 || v0 + 1 == arg3;
        (v2, v0, v1)
    }

    public(friend) fun close_position<T0, T1, T2>(arg0: &mut 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::Vault<T0, T1, T2>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::version::Version, arg4: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::remove_liquidity<T0, T1>(arg1, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::position_borrow_mut<T0, T1, T2>(arg0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::liquidity(0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::position_borrow<T0, T1, T2>(arg0)), 0, 0, arg2, arg4, arg5);
        0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::collect::fees<T0, T1, T2>(arg0, arg1, arg3, arg4, arg2, arg5);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::close_position(0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::remove_position<T0, T1, T2>(arg0), arg4, arg5);
        (0x2::coin::into_balance<T0>(v0), 0x2::coin::into_balance<T1>(v1))
    }

    public(friend) fun create_position<T0, T1, T2>(arg0: &mut 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::Vault<T0, T1, T2>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &mut 0x2::tx_context::TxContext) : (u32, u32, u128, u128) {
        swap_if_zero<T0, T1>(arg1, arg2, arg3, 0x2::object::id<0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::Vault<T0, T1, T2>>(arg0), arg4, arg5, arg6);
        let v0 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1);
        let v1 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_tick_at_sqrt_price(scale(v0, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::upper_price_scalling<T0, T1, T2>(arg0)));
        let v2 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_tick_at_sqrt_price(scale(v0, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::lower_price_scalling<T0, T1, T2>(arg0)));
        let v3 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::tick_spacing<T0, T1>(arg1));
        let v4 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::sub(v1, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::mod(v1, v3));
        let v5 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::sub(v2, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::mod(v2, v3));
        let v6 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::open_position<T0, T1>(arg1, v5, v4, arg5, arg6);
        let (_, v8, v9) = check_is_fix_coin_a(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v5), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v4), v0, 0x2::balance::value<T0>(arg2), 0x2::balance::value<T1>(arg3));
        let (v10, v11) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::add_liquidity<T0, T1>(arg1, &mut v6, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg2, v8), arg6), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg3, v9), arg6), 0, 0, arg4, arg5, arg6);
        0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::add_free_balance_a<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(v10));
        0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::add_free_balance_b<T0, T1, T2>(arg0, 0x2::coin::into_balance<T1>(v11));
        0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::update_last_rebalance_sqrt_price<T0, T1, T2>(arg0, v0);
        0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::insert_position<T0, T1, T2>(arg0, v6);
        (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v2), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v1), scale(v0, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::lower_trigger_price_scalling<T0, T1, T2>(arg0)), scale(v0, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::upper_trigger_price_scalling<T0, T1, T2>(arg0)))
    }

    public fun scale(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::scalling_factor() as u256)) as u128)
    }

    public fun slippage_adjusted_sqrt_price(arg0: bool, arg1: u128, arg2: u128, arg3: u128) : u128 {
        if (arg1 == 0 && arg2 == 0) {
            if (arg0) {
                4295048017
            } else {
                79226673515401279992447579054
            }
        } else if (arg0) {
            scale(arg3, arg2)
        } else {
            scale(arg3, arg1)
        }
    }

    fun swap_if_zero<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::balance::Balance<T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg0);
        if (0x2::balance::value<T0>(arg1) == 0 && 0x2::balance::value<T1>(arg2) / 2 > 0) {
            let v1 = 0x2::balance::value<T1>(arg2) / 2;
            let v2 = 0x2::coin::zero<T0>(arg6);
            let v3 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg2, v1), arg6);
            let (v4, v5) = swap<T0, T1>(arg0, v2, v3, false, true, v1, 79226673515401279992447579054, arg4, arg5, arg6);
            let v6 = v4;
            0x2::coin::destroy_zero<T1>(v5);
            let v7 = SwapIfZeroEvent{
                vault_id          : arg3,
                before_sqrt_price : v0,
                after_sqrt_price  : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg0),
                is_a              : false,
                amount_in         : v1,
                amount_out        : 0x2::coin::value<T0>(&v6),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::event::emit<SwapIfZeroEvent>(v7);
            0x2::balance::join<T0>(arg1, 0x2::coin::into_balance<T0>(v6));
        };
        if (0x2::balance::value<T1>(arg2) == 0 && 0x2::balance::value<T0>(arg1) / 2 > 0) {
            let v8 = 0x2::balance::value<T0>(arg1) / 2;
            let v9 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg1, v8), arg6);
            let v10 = 0x2::coin::zero<T1>(arg6);
            let (v11, v12) = swap<T0, T1>(arg0, v9, v10, true, true, v8, 4295048017, arg4, arg5, arg6);
            let v13 = v12;
            0x2::coin::destroy_zero<T0>(v11);
            let v14 = SwapIfZeroEvent{
                vault_id          : arg3,
                before_sqrt_price : v0,
                after_sqrt_price  : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg0),
                is_a              : true,
                amount_in         : v8,
                amount_out        : 0x2::coin::value<T1>(&v13),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::event::emit<SwapIfZeroEvent>(v14);
            0x2::balance::join<T1>(arg2, 0x2::coin::into_balance<T1>(v13));
        };
    }

    // decompiled from Move bytecode v6
}

