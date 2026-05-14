module 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::cetus_adapter {
    public fun swap_a_to_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::vault::LegEscrow, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::router_adapter::AdapterReceipt<T1> {
        let (v0, v1, v2, v3, v4, _, _, v7, v8, v9) = 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::vault::peek_escrow(arg2);
        assert!(0x2::coin::value<T0>(&arg3) == v7, 27);
        let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v7, arg4, arg5);
        let v13 = v11;
        0x2::balance::destroy_zero<T0>(v10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), v12);
        assert!(0x2::balance::value<T1>(&v13) >= v8, 4);
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::router_adapter::mint_receipt<T0, T1>(v0, v1, v2, v3, v4, v7, v8, v9, v13)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::vault::LegEscrow, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::router_adapter::AdapterReceipt<T0> {
        let (v0, v1, v2, v3, v4, _, _, v7, v8, v9) = 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::vault::peek_escrow(arg2);
        assert!(0x2::coin::value<T1>(&arg3) == v7, 27);
        let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v7, arg4, arg5);
        let v13 = v10;
        0x2::balance::destroy_zero<T1>(v11);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg3), v12);
        assert!(0x2::balance::value<T0>(&v13) >= v8, 4);
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::router_adapter::mint_receipt<T1, T0>(v0, v1, v2, v3, v4, v7, v8, v9, v13)
    }

    // decompiled from Move bytecode v7
}

