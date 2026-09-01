module 0x3882e0dbdc12dfb49bc508c5e21188a90746c8c12a5231ff5ae257771813658::swap {
    fun collect_balance<T0, T1>(arg0: &0x8d1aee27f8537c06d19c16641f27008caafc42affd2d2fb7adb96919470481ec::bucketus::CetusLpVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, 0x8d1aee27f8537c06d19c16641f27008caafc42affd2d2fb7adb96919470481ec::bucketus::borrow_cetus_position(arg0), true)
    }

    fun fee_adjusted_input<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, false, true, arg1);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v0);
        assert!(arg1 > v1, 0);
        arg1 - v1
    }

    public entry fun realize_usdc<T0, T1, T2>(arg0: &0x3882e0dbdc12dfb49bc508c5e21188a90746c8c12a5231ff5ae257771813658::owner::OwnerCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T2>, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T1>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T2>(arg4);
        0x2::balance::join<T2>(&mut v0, 0x2::coin::into_balance<T2>(arg5));
        let (v1, v2) = swap_b_to_a<T1, T2>(arg1, arg2, v0, arg9);
        let v3 = 0x2::coin::into_balance<T1>(arg6);
        0x2::balance::join<T1>(&mut v3, 0x2::coin::into_balance<T1>(arg7));
        0x2::balance::join<T1>(&mut v3, 0x2::coin::into_balance<T1>(arg8));
        0x2::balance::join<T1>(&mut v3, v1);
        let (v4, v5) = swap_b_to_a<T0, T1>(arg1, arg3, v3, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg10), 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg10), 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v2, arg10), 0x2::tx_context::sender(arg10));
    }

    public entry fun settle_sui<T0, T1, T2, T3>(arg0: &0x3882e0dbdc12dfb49bc508c5e21188a90746c8c12a5231ff5ae257771813658::owner::OwnerCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &0x8d1aee27f8537c06d19c16641f27008caafc42affd2d2fb7adb96919470481ec::bucketus::CetusLpVault, arg8: &0x8d1aee27f8537c06d19c16641f27008caafc42affd2d2fb7adb96919470481ec::bucketus::CetusLpVault, arg9: &0x8d1aee27f8537c06d19c16641f27008caafc42affd2d2fb7adb96919470481ec::bucketus::CetusLpVault, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg2, arg10, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg2, v0, v1);
        let (v2, v3) = collect_balance<T1, T2>(arg7, arg1, arg3);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = collect_balance<T2, T3>(arg8, arg1, arg4);
        let v8 = v7;
        let (v9, v10) = collect_balance<T2, T3>(arg9, arg1, arg5);
        0x2::balance::join<T3>(&mut v8, v10);
        let (v11, v12) = swap_b_to_a<T2, T3>(arg1, arg4, v8, arg11);
        let v13 = v12;
        0x2::balance::join<T2>(&mut v4, v6);
        0x2::balance::join<T2>(&mut v4, v9);
        0x2::balance::join<T2>(&mut v4, v11);
        let (v14, v15) = swap_b_to_a<T1, T2>(arg1, arg3, v4, arg11);
        let v16 = v15;
        0x2::balance::join<T1>(&mut v5, v14);
        let (v17, v18) = swap_a_to_b<T1, T0>(arg1, arg6, v5, arg11);
        let v19 = v18;
        let v20 = v17;
        let (v21, v22) = if (0x2::balance::value<T3>(&v13) > 0) {
            swap_b_to_a<T2, T3>(arg1, arg4, v13, arg11)
        } else {
            0x2::balance::destroy_zero<T3>(v13);
            (0x2::balance::zero<T2>(), 0x2::balance::zero<T3>())
        };
        0x2::balance::join<T2>(&mut v16, v21);
        let (v23, v24) = if (0x2::balance::value<T2>(&v16) > 0) {
            swap_b_to_a<T1, T2>(arg1, arg3, v16, arg11)
        } else {
            0x2::balance::destroy_zero<T2>(v16);
            (0x2::balance::zero<T1>(), 0x2::balance::zero<T2>())
        };
        0x2::balance::join<T1>(&mut v20, v23);
        let (v25, v26) = if (0x2::balance::value<T1>(&v20) > 0) {
            swap_a_to_b<T1, T0>(arg1, arg6, v20, arg11)
        } else {
            0x2::balance::destroy_zero<T1>(v20);
            (0x2::balance::zero<T1>(), 0x2::balance::zero<T0>())
        };
        0x2::balance::join<T0>(&mut v19, v26);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v19, arg12), @0x4f619e30f398a502d12ea0f10f29d44a89d4639909c5b0ad15126ac5feaea48e);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v25, arg12), @0x4f619e30f398a502d12ea0f10f29d44a89d4639909c5b0ad15126ac5feaea48e);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v24, arg12), @0x4f619e30f398a502d12ea0f10f29d44a89d4639909c5b0ad15126ac5feaea48e);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v22, arg12), @0x4f619e30f398a502d12ea0f10f29d44a89d4639909c5b0ad15126ac5feaea48e);
    }

    fun swap_a_to_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, true, true, v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v1);
        assert!(v0 > v2, 2);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0 - v2, 4295048016, arg3);
        let v6 = v5;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6);
        assert!(v7 <= v0, 3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, v7), 0x2::balance::zero<T1>(), v6);
        0x2::balance::destroy_zero<T0>(v3);
        (arg2, v4)
    }

    fun swap_b_to_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, fee_adjusted_input<T0, T1>(arg1, v0), 79226673515401279992447579055, arg3);
        let v4 = v3;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        assert!(v5 <= v0, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v5), v4);
        0x2::balance::destroy_zero<T1>(v2);
        (v1, arg2)
    }

    public entry fun swap_b_to_a_only<T0, T1>(arg0: &0x3882e0dbdc12dfb49bc508c5e21188a90746c8c12a5231ff5ae257771813658::owner::OwnerCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = swap_b_to_a<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(arg3), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg5), 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v7
}

