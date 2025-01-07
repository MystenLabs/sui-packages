module 0xc71943195f8b4d331296d6e53ae6ece9f4e27a4749c19859bf8b1a58e5c41a47::cetus_invest {
    public(friend) fun arbitrage<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::balance::Balance<T0>>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = merge_balance<T0>(arg2);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg3, arg4, arg5);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::value<T1>(&v5);
        0x2::balance::join<T0>(&mut v0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg7), arg6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        v5
    }

    public(friend) fun invest<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::balance::Balance<T1>>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = merge_balance<T1>(arg2);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg3, arg4, arg5);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::value<T0>(&v5);
        0x2::balance::join<T1>(&mut v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg7), arg6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4)), v4);
        v5
    }

    fun merge_balance<T0>(arg0: vector<0x2::balance::Balance<T0>>) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::vector::pop_back<0x2::balance::Balance<T0>>(&mut arg0);
        while (0x1::vector::length<0x2::balance::Balance<T0>>(&arg0) > 0) {
            0x2::balance::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::balance::Balance<T0>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::balance::Balance<T0>>(arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

