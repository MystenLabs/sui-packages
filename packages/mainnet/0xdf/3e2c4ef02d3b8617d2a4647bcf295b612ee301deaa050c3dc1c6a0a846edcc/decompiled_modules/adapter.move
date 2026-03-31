module 0xdf3e2c4ef02d3b8617d2a4647bcf295b612ee301deaa050c3dc1c6a0a846edcc::adapter {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::SwapContext, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::take_balance<T0>(arg0);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::balance::value<T0>(&v0), 4295048016, arg3, arg2, arg4);
        0x2::balance::destroy_zero<T0>(v1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, v0, 0x2::balance::zero<T1>(), arg2, arg4);
        0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::merge_balance<T1>(arg0, v2);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::SwapContext, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::take_balance<T1>(arg0);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, 0x2::balance::value<T1>(&v0), 79226673515401279992447579055, arg3, arg2, arg4);
        0x2::balance::destroy_zero<T1>(v2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::zero<T0>(), v0, arg2, arg4);
        0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::merge_balance<T0>(arg0, v1);
    }

    // decompiled from Move bytecode v6
}

