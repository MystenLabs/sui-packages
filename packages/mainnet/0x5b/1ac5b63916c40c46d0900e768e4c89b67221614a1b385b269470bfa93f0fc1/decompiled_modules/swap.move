module 0x5b1ac5b63916c40c46d0900e768e4c89b67221614a1b385b269470bfa93f0fc1::swap {
    struct SwapCap has key {
        id: 0x2::object::UID,
    }

    fun cetus_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = merge_coins<T0>(arg2, arg10);
        let v1 = merge_coins<T1>(arg3, arg10);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        if (arg4) {
        };
        let (v8, v9) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg10)))
        };
        0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(v6, arg10));
        0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(v7, arg10));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v5);
        (v0, v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SwapCap>(v0, 0x2::tx_context::sender(arg0));
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

    public entry fun swap_a2b<T0, T1>(arg0: &SwapCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T0>>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = cetus_swap<T0, T1>(arg1, arg2, arg3, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg9));
    }

    // decompiled from Move bytecode v6
}

