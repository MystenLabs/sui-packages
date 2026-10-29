module 0x127587fbd221c4a22a5cbfed339d65680d6b48be1f722df1d72e57beaa5e9e66::mmt {
    public fun cp<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: u128) {
        assert!(arg1 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0) >= arg2 || 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0) <= arg2, 1);
    }

    public fun fsxy<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, arg2, arg3, arg4, arg0, arg5);
        0x127587fbd221c4a22a5cbfed339d65680d6b48be1f722df1d72e57beaa5e9e66::u::tod<T0>(0x2::coin::from_balance<T0>(v0, arg5), 0x2::tx_context::sender(arg5));
        (0x2::coin::from_balance<T1>(v1, arg5), v2)
    }

    public fun fsyx<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, arg2, arg3, arg4, arg0, arg5);
        0x127587fbd221c4a22a5cbfed339d65680d6b48be1f722df1d72e57beaa5e9e66::u::tod<T1>(0x2::coin::from_balance<T1>(v1, arg5), 0x2::tx_context::sender(arg5));
        (0x2::coin::from_balance<T0>(v0, arg5), v2)
    }

    public fun rfsxy<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&arg3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v0, arg4)), 0x2::balance::zero<T1>(), arg0, arg4);
    }

    public fun rfsyx<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&arg3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v1, arg4)), arg0, arg4);
    }

    public fun sxy<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, 0x2::coin::value<T0>(&arg1), arg2, arg3, arg4, arg5);
        let v3 = v2;
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v4, arg5)), 0x2::balance::zero<T1>(), arg4, arg5);
        0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(v0, arg5));
        0x127587fbd221c4a22a5cbfed339d65680d6b48be1f722df1d72e57beaa5e9e66::u::tod<T0>(arg1, 0x2::tx_context::sender(arg5));
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public fun syx<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, 0x2::coin::value<T1>(&arg1), arg2, arg3, arg4, arg5);
        let v3 = v2;
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v5, arg5)), arg4, arg5);
        0x2::coin::join<T1>(&mut arg1, 0x2::coin::from_balance<T1>(v1, arg5));
        0x127587fbd221c4a22a5cbfed339d65680d6b48be1f722df1d72e57beaa5e9e66::u::tod<T1>(arg1, 0x2::tx_context::sender(arg5));
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    // decompiled from Move bytecode v7
}

