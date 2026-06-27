module 0xa8f7b7893fd8edb8510b98e0cf19e9ea27b714c861113c79ca062ef96b2b378d::momentum_router {
    struct MmtReceipt {
        inner: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt,
        pay_amount: u64,
    }

    public fun flash_a2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x2::tx_context::TxContext) : (MmtReceipt, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, arg1, 4295048016, arg2, arg3, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        let v3 = MmtReceipt{
            inner      : v2,
            pay_amount : arg1,
        };
        (v3, v1)
    }

    public fun flash_b2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x2::tx_context::TxContext) : (MmtReceipt, 0x2::balance::Balance<T0>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, arg1, 79226673515401279992447579055, arg2, arg3, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = MmtReceipt{
            inner      : v2,
            pay_amount : arg1,
        };
        (v3, v0)
    }

    public fun repay_a2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: MmtReceipt, arg2: 0x2::balance::Balance<T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let MmtReceipt {
            inner      : v0,
            pay_amount : v1,
        } = arg1;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v0, 0x2::balance::split<T0>(&mut arg2, v1), 0x2::balance::zero<T1>(), arg3, arg4);
        arg2
    }

    public fun repay_b2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: MmtReceipt, arg2: 0x2::balance::Balance<T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let MmtReceipt {
            inner      : v0,
            pay_amount : v1,
        } = arg1;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v1), arg3, arg4);
        arg2
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, 0x2::balance::value<T0>(&arg1), 4295048016, arg3, arg4, arg5);
        let v3 = v1;
        0x2::balance::destroy_zero<T0>(v0);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v2, arg1, 0x2::balance::zero<T1>(), arg4, arg5);
        assert!(0x2::balance::value<T1>(&v3) >= arg2, 2);
        v3
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, 0x2::balance::value<T1>(&arg1), 79226673515401279992447579055, arg3, arg4, arg5);
        let v3 = v0;
        0x2::balance::destroy_zero<T1>(v1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v2, 0x2::balance::zero<T0>(), arg1, arg4, arg5);
        assert!(0x2::balance::value<T0>(&v3) >= arg2, 2);
        v3
    }

    // decompiled from Move bytecode v7
}

