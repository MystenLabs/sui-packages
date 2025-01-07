module 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::cetus {
    public fun swap<T0, T1, T2, T3>(arg0: &mut 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>, arg1: &0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AdminCap<T1>, arg2: u64, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: bool, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock) {
        0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assert_locked_period<T0, T1>(arg0, arg8);
        if (!0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::is_token_exists<T0, T1, T2>(arg0)) {
            0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::add_new_token<T0, T1, T2>(arg0);
        };
        if (!0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::is_token_exists<T0, T1, T3>(arg0)) {
            0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::add_new_token<T0, T1, T3>(arg0);
        };
        let (v0, v1) = if (arg5) {
            let v2 = 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, T2>(arg0);
            assert!(0x2::balance::value<T2>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance<T2>(v2)) >= arg2, 101);
            (0x2::balance::split<T2>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<T2>(v2), arg2), 0x2::balance::zero<T3>())
        } else {
            let v3 = 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, T3>(arg0);
            assert!(0x2::balance::value<T3>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance<T3>(v3)) >= arg2, 101);
            (0x2::balance::zero<T2>(), 0x2::balance::split<T3>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<T3>(v3), arg2))
        };
        let v4 = v1;
        let v5 = v0;
        let v6 = &mut v5;
        let v7 = &mut v4;
        swap_<T2, T3>(v6, v7, arg3, arg4, arg5, arg6, arg8);
        if (arg5) {
            assert!(0x2::balance::value<T3>(&v4) >= arg7, 102);
            0x2::balance::join<T3>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::fee_mut<T3>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, T3>(arg0)), 0x2::balance::split<T3>(&mut v4, 0x2::balance::value<T3>(&v4) * 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::swap_fee_rate<T0, T1>(arg0) / 10000));
        } else {
            assert!(0x2::balance::value<T2>(&v5) >= arg7, 102);
            0x2::balance::join<T2>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::fee_mut<T2>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, T2>(arg0)), 0x2::balance::split<T2>(&mut v5, 0x2::balance::value<T2>(&v5) * 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::swap_fee_rate<T0, T1>(arg0) / 10000));
        };
        0x2::balance::join<T2>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<T2>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, T2>(arg0)), v5);
        0x2::balance::join<T3>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<T3>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, T3>(arg0)), v4);
    }

    fun swap_<T0, T1>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::balance::Balance<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: bool, arg6: &0x2::clock::Clock) {
        let v0 = if (arg5) {
            0x2::balance::value<T0>(arg0)
        } else {
            0x2::balance::value<T1>(arg1)
        };
        let v1 = if (arg4) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, arg4, arg5, v0, v1, arg6);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        if (arg4) {
        };
        let (v8, v9) = if (arg4) {
            (0x2::balance::split<T0>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg3, v8, v9, v5);
        0x2::balance::join<T0>(arg0, v7);
        0x2::balance::join<T1>(arg1, v6);
    }

    // decompiled from Move bytecode v6
}

