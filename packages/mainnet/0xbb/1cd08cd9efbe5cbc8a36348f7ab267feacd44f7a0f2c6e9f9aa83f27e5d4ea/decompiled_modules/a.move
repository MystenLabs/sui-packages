module 0xbb1cd08cd9efbe5cbc8a36348f7ab267feacd44f7a0f2c6e9f9aa83f27e5d4ea::a {
    public fun xm<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 101);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, true, true, v0, arg3, arg4, arg1, arg5);
        let v4 = v3;
        let v5 = v1;
        if (0x2::balance::value<T0>(&v5) == 0) {
            0x2::balance::destroy_zero<T0>(v5);
        } else {
            0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(v5, arg5), arg5);
        };
        let (v6, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        if (v0 > v6) {
            0x2::pay::keep<T0>(0x2::coin::split<T0>(&mut arg0, v0 - v6, arg5), arg5);
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v4, 0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>(), arg1, arg5);
        0x2::coin::from_balance<T1>(v2, arg5)
    }

    public fun ym<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg0);
        assert!(v0 > 0, 101);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, false, true, v0, arg3, arg4, arg1, arg5);
        let v4 = v3;
        let v5 = v2;
        if (0x2::balance::value<T1>(&v5) == 0) {
            0x2::balance::destroy_zero<T1>(v5);
        } else {
            0x2::pay::keep<T1>(0x2::coin::from_balance<T1>(v5, arg5), arg5);
        };
        let (_, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        if (v0 > v7) {
            0x2::pay::keep<T1>(0x2::coin::split<T1>(&mut arg0, v0 - v7, arg5), arg5);
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v4, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), arg1, arg5);
        0x2::coin::from_balance<T0>(v1, arg5)
    }

    // decompiled from Move bytecode v6
}

