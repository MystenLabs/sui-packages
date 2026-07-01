module 0x66f23f19bde9c628c909b8e3dff18cc23238f5bc1143c8fa02967d93e60adedc::kriya {
    public fun a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::coin::value<T0>(&arg0), 0x66f23f19bde9c628c909b8e3dff18cc23238f5bc1143c8fa02967d93e60adedc::self::min_sqrt_price(), arg3, arg2, arg4);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v2, 0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>(), arg2, arg4);
        0x66f23f19bde9c628c909b8e3dff18cc23238f5bc1143c8fa02967d93e60adedc::self::transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v0, arg4), arg4);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun b2a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, false, true, 0x2::coin::value<T1>(&arg0), 0x66f23f19bde9c628c909b8e3dff18cc23238f5bc1143c8fa02967d93e60adedc::self::max_sqrt_price(), arg3, arg2, arg4);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), arg2, arg4);
        0x66f23f19bde9c628c909b8e3dff18cc23238f5bc1143c8fa02967d93e60adedc::self::transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v1, arg4), arg4);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    // decompiled from Move bytecode v7
}

