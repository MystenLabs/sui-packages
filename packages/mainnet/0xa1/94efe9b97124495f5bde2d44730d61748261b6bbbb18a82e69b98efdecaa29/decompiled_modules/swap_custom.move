module 0xa194efe9b97124495f5bde2d44730d61748261b6bbbb18a82e69b98efdecaa29::swap_custom {
    fun assert_only_owner(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x3ec451dd47ed33b65c8dbfc426d1b0db6d6734335ddc16b66a60a66b7547eee9, 9001);
    }

    fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg1)
        } else {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            0x2::pay::join_vec<T0>(&mut v1, arg0);
            v1
        }
    }

    fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public entry fun swap_a2b_exact_in_partial<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        swap_partial<T0, T1>(arg0, arg1, arg2, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, true, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun swap_b2a_exact_in_partial<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        swap_partial<T0, T1>(arg0, arg1, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg2, false, true, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun swap_partial<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_only_owner(arg11);
        let v0 = merge_coins<T0>(arg2, arg11);
        let v1 = merge_coins<T1>(arg3, arg11);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg10);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        let v9 = if (arg4) {
            0x2::balance::value<T1>(&v6)
        } else {
            0x2::balance::value<T0>(&v7)
        };
        if (arg5) {
            assert!(v8 <= arg6, 1002);
        } else {
            assert!(v9 <= arg6, 1001);
            assert!(v8 <= arg7, 1002);
        };
        let (v10, v11) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, v8, arg11)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, v8, arg11)))
        };
        0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(v6, arg11));
        0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(v7, arg11));
        let (v12, v13) = if (arg4) {
            (0x2::coin::value<T0>(&v0) - 0x2::coin::value<T0>(&v0), 0x2::coin::value<T1>(&v1) - 0x2::coin::value<T1>(&v1))
        } else {
            (0x2::coin::value<T1>(&v1) - 0x2::coin::value<T1>(&v1), 0x2::coin::value<T0>(&v0) - 0x2::coin::value<T0>(&v0))
        };
        if (arg5) {
            assert!(v12 <= arg6, 1002);
        } else {
            assert!(v13 <= arg6, 1001);
        };
        assert!(v13 >= (((v12 as u128) * (arg9 as u128) / (1000000000000 as u128)) as u64), 2003);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v10, v11, v5);
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        if (arg4) {
            assert!(v14 <= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 2001);
            assert!(v14 >= arg8, 2002);
        } else {
            assert!(v14 >= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 2001);
            assert!(v14 <= arg8, 2002);
        };
        send_coin<T0>(v0, 0x2::tx_context::sender(arg11));
        send_coin<T1>(v1, 0x2::tx_context::sender(arg11));
    }

    // decompiled from Move bytecode v6
}

