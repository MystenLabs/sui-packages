module 0x955439d15723d3889a5db8088b655474015f85cf617f49380f59b15418f75249::swap {
    fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0), 0);
        let v0 = 0x2::coin::zero<T0>(arg1);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        v0
    }

    entry fun swap_entry<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: vector<0x2::coin::Coin<T0>>, arg4: vector<0x2::coin::Coin<T1>>, arg5: bool, arg6: bool, arg7: vector<u64>, arg8: vector<u64>, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg7) - 1;
        let v1 = merge_coins<T0>(arg3, arg11);
        let v2 = merge_coins<T1>(arg4, arg11);
        let v3;
        let v4;
        loop {
            let (_, v3) = 0x1::vector::index_of<u64>(&arg7, &v0);
            let (_, v4) = 0x1::vector::index_of<u64>(&arg8, &v0);
            let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, arg5, arg6, v3);
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v7) > v4) {
                break
            };
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, arg5, arg6, v3, arg9, arg10);
        let v11 = v10;
        let v12 = v9;
        let v13 = v8;
        let v14 = if (arg5) {
            0x2::balance::value<T1>(&v12)
        } else {
            0x2::balance::value<T0>(&v13)
        };
        assert!(v14 > v4, 1);
        let (v15, v16) = if (arg5) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v11), arg11)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v11), arg11)))
        };
        0x2::coin::join<T1>(&mut v2, 0x2::coin::from_balance<T1>(v12, arg11));
        0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v13, arg11));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, v15, v16, v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg11));
    }

    // decompiled from Move bytecode v6
}

