module 0xfa255daaddfc111a4ea631fbaf8c7ba74de2b6c73d183d679e2289cef9eb3c0c::atomic_arb {
    public fun cetus_turbos_arb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg6);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 4295048016, arg5);
        0x2::balance::destroy_zero<T0>(v1);
        let v4 = 0x2::coin::from_balance<T1>(v2, arg7);
        let v5 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v5, v4);
        let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T1, T0, T2>(arg3, v5, 0x2::coin::value<T1>(&v4), 0, 4295048016, true, 0x2::tx_context::sender(arg7), 18446744073709551615, arg5, arg4, arg7);
        let v8 = v7;
        let v9 = v6;
        if (0x2::coin::value<T1>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v8, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T1>(v8);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg6), 0x2::balance::zero<T1>(), v3);
        assert!(0x2::coin::value<T0>(&v9) > v0, 1337);
        v9
    }

    public fun turbos_cetus_arb<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg6);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, arg6);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v1, v0, 0, 4295048016, true, 0x2::tx_context::sender(arg7), 18446744073709551615, arg5, arg1, arg7);
        let v4 = v3;
        let v5 = v2;
        if (0x2::coin::value<T0>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(v4);
        };
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg2, arg3, true, true, 0x2::coin::value<T1>(&v5), 4295048016, arg5);
        0x2::balance::destroy_zero<T1>(v6);
        let v9 = 0x2::coin::from_balance<T0>(v7, arg7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg2, arg3, 0x2::coin::into_balance<T1>(v5), 0x2::balance::zero<T0>(), v8);
        assert!(0x2::coin::value<T0>(&v9) > v0, 1337);
        v9
    }

    // decompiled from Move bytecode v7
}

