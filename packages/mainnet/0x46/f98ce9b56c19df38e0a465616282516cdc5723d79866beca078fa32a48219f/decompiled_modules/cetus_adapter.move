module 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::cetus_adapter {
    public fun swap_in_vault<T0, T1>(arg0: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::TraderAccount, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T0>, arg4: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::assert_owner(arg0, arg11);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg1, arg5, arg6, arg7, arg9, arg10);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        if (arg6) {
            assert!(v6 <= arg7, 103);
            let v7 = if (arg5) {
                0x2::balance::value<T1>(&v4)
            } else {
                0x2::balance::value<T0>(&v5)
            };
            assert!(v7 >= arg8, 102);
        } else {
            assert!(v6 <= arg8, 101);
        };
        let (v8, v9) = if (arg5) {
            (0x2::balance::split<T0>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<T0>(arg3), v6), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<T1>(arg4), v6))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg1, v8, v9, v3);
        0x2::balance::join<T0>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<T0>(arg3), v5);
        0x2::balance::join<T1>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<T1>(arg4), v4);
    }

    // decompiled from Move bytecode v6
}

