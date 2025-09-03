module 0x5474193310b76f655511b608989efe6acb5ce9ffd45342a7ad838d32861c3f1d::swap {
    public fun swap_a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::coin::value<T0>(&arg0), 4295128739, arg2, arg3, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, v4, arg5)), 0x2::coin::into_balance<T1>(0x2::coin::zero<T1>(arg5)), arg3, arg5);
        transfer_or_destroy_coin<T0>(arg0, 0x2::tx_context::sender(arg5), arg5);
        let v6 = 0x2::coin::from_balance<T1>(v1, arg5);
        if (0x2::coin::value<T1>(&v6) < arg4) {
            abort 404
        };
        v6
    }

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

