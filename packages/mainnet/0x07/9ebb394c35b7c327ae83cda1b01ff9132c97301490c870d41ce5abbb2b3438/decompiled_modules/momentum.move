module 0x8887a6fe57341fb519570f440bf4ef98d58d7aa1d26b626af5fedd087e891ce1::momentum {
    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(arg0, arg1);
        if (0x2::coin::value<T0>(&v0) == 0) {
            0x2::coin::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, true, true, 0x2::coin::value<T0>(&arg1), 4295048017, arg4, arg3, arg5);
        let v3 = v2;
        let v4 = v0;
        let (v5, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v7 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(&mut v7, v5));
        destroy_or_transfer_balance<T0>(v7, arg5);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v3, v4, 0x2::balance::zero<T1>(), arg3, arg5);
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public fun swap_b2a<T0, T1>(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, false, true, 0x2::coin::value<T1>(&arg1), 79226673515401279992447579054, arg4, arg3, arg5);
        let v3 = v2;
        let v4 = v1;
        let (_, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v7 = 0x2::coin::into_balance<T1>(arg1);
        0x2::balance::join<T1>(&mut v4, 0x2::balance::split<T1>(&mut v7, v6));
        destroy_or_transfer_balance<T1>(v7, arg5);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v3, 0x2::balance::zero<T0>(), v4, arg3, arg5);
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    // decompiled from Move bytecode v7
}

