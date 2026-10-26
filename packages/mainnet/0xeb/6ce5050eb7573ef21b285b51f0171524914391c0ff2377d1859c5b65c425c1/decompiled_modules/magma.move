module 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::magma {
    fun swap<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price() + 1
        } else {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price() - 1
        };
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg0, arg4, true, arg5, v0, arg7);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = if (arg4) {
            0x2::balance::value<T1>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        assert!(v7 >= arg6, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::invalid_out_amount());
        let (v8, v9) = if (arg4) {
            (0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg3), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v4)))
        };
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg0, v8, v9, v4);
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg2), v6);
        0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(arg3), v5);
    }

    public(friend) fun calculate<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64) : (u64, u64, u64, bool) {
        assert!(arg3 > 0, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::zero_amount());
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0);
        let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = false;
        while (arg3 > 0) {
            if (0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_none(&v1)) {
                v7 = true;
                break
            };
            let (v8, v9) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(v0, 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v1), arg1);
            v1 = v9;
            let v10 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::sqrt_price(v8);
            let (v11, v12, v13, v14) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::compute_swap_step(v2, v10, v3, arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), arg1, arg2);
            let v15 = if (arg2) {
                arg3 - v11 - v14
            } else {
                arg3 - v12
            };
            arg3 = v15;
            assert!(v4 <= 18446744073709551615 - v11, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::swap_amount_overflow());
            assert!(v5 <= 18446744073709551615 - v12, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::swap_amount_overflow());
            assert!(v6 <= 18446744073709551615 - v14, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::swap_amount_overflow());
            v4 = v4 + v11;
            v5 = v5 + v12;
            v6 = v6 + v14;
            v2 = v13;
            if (v13 == v10) {
                let v16 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v8);
                let v17 = v16;
                if (arg1) {
                    v17 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::neg(v16);
                };
                let v18 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v17);
                if (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::is_neg(v17)) {
                    assert!(v3 >= v18, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::liquidity_overflow());
                    v3 = v3 - v18;
                    continue
                };
                assert!(v3 <= 340282366920938463463374607431768211455 - v18, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::liquidity_overflow());
                v3 = v3 + v18;
                continue
            };
        };
        (v4 + v6, v5, v6, v7)
    }

    public fun quote<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: bool, arg3: bool, arg4: u64) {
        assert!(arg4 > 0, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::zero_amount());
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg1, arg0, arg2, arg3, arg4);
        let (v1, v2, v3, v4) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_fees_amount(&v0);
        0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::events::emit_swap_quote(0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::events::source_magma(), 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg0), arg2, arg3, arg4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_in(&v0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v0), v1 + v2 + v3 + v4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_is_exceed(&v0));
    }

    public fun quote_v1<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64) {
        assert!(arg3 > 0, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::zero_amount());
        let (v0, v1, v2, v3) = calculate<T0, T1>(arg0, arg1, arg2, arg3);
        0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::events::emit_swap_quote(0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::events::source_magma(), 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg0), arg1, arg2, arg3, v0, v1, v2, v3);
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T1>(arg5);
        let v1 = &mut arg2;
        let v2 = &mut v0;
        swap<T0, T1>(arg0, arg1, v1, v2, true, 0x2::coin::value<T0>(&arg2), arg3, arg4, arg5);
        (arg2, v0)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T0>(arg5);
        let v1 = &mut v0;
        let v2 = &mut arg2;
        swap<T0, T1>(arg0, arg1, v1, v2, false, 0x2::coin::value<T1>(&arg2), arg3, arg4, arg5);
        (v0, arg2)
    }

    // decompiled from Move bytecode v7
}

