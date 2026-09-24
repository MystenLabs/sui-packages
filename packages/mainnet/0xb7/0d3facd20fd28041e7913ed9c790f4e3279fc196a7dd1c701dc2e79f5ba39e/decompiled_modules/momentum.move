module 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::momentum {
    fun swap<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let v0 = if (arg4) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price() + 1
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price() - 1
        };
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, arg4, true, arg5, v0, arg7, arg1, arg8);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let (v7, v8) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        let v9 = if (arg4) {
            0x2::balance::value<T1>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        assert!(v9 >= arg6, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::invalid_out_amount());
        let (v10, v11) = if (arg4) {
            (0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), v7), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg3), v8))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v4, v10, v11, arg1, arg8);
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg2), v6);
        0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(arg3), v5);
    }

    public fun quote<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64) {
        assert!(arg3 > 0, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::zero_amount());
        let v0 = if (arg1) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price() + 1
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price() - 1
        };
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, arg1, arg2, v0, arg3);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v1);
        let (v3, v4) = if (arg2) {
            (arg3 - v2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1))
        } else {
            (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1), arg3 - v2)
        };
        0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::events::emit_swap_quote(0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::events::source_momentum(), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg0), arg1, arg2, arg3, v3, v4, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_fee_amount(&v1), v2 > 0);
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T1>(arg5);
        let v1 = &mut arg2;
        let v2 = &mut v0;
        swap<T0, T1>(arg0, arg1, v1, v2, true, 0x2::coin::value<T0>(&arg2), arg3, arg4, arg5);
        (arg2, v0)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T0>(arg5);
        let v1 = &mut v0;
        let v2 = &mut arg2;
        swap<T0, T1>(arg0, arg1, v1, v2, false, 0x2::coin::value<T1>(&arg2), arg3, arg4, arg5);
        (v0, arg2)
    }

    // decompiled from Move bytecode v7
}

