module 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::cetus {
    fun swap<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        assert!(arg6 > 0, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::zero_amount());
        let v0 = if (arg4) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg0, arg4, arg5, arg6, v0, arg8);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        if (arg5) {
            assert!(v7 <= arg6, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::invalid_pay_amount());
            let v8 = if (arg4) {
                0x2::balance::value<T1>(&v5)
            } else {
                0x2::balance::value<T0>(&v6)
            };
            assert!(v8 >= arg7, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::invalid_out_amount());
        } else {
            assert!(v7 <= arg7, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::invalid_pay_amount());
        };
        let (v9, v10) = if (arg4) {
            (0x2::balance::split<T0>(arg2, v7), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg3, v7))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg0, v9, v10, v4);
        0x2::balance::join<T0>(arg2, v6);
        0x2::balance::join<T1>(arg3, v5);
    }

    public fun quote<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64) {
        assert!(arg3 > 0, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::zero_amount());
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v0);
        0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::events::emit_swap_quote(0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::events::source_cetus(), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0), arg1, arg2, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0) + v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0), v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0));
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T1>(arg5);
        let v1 = 0x2::coin::balance_mut<T0>(&mut arg2);
        let v2 = 0x2::coin::balance_mut<T1>(&mut v0);
        swap<T0, T1>(arg0, arg1, v1, v2, true, true, 0x2::coin::value<T0>(&arg2), arg3, arg4);
        (arg2, v0)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T0>(arg5);
        let v1 = 0x2::coin::balance_mut<T0>(&mut v0);
        let v2 = 0x2::coin::balance_mut<T1>(&mut arg2);
        swap<T0, T1>(arg0, arg1, v1, v2, false, true, 0x2::coin::value<T1>(&arg2), arg3, arg4);
        (v0, arg2)
    }

    // decompiled from Move bytecode v7
}

