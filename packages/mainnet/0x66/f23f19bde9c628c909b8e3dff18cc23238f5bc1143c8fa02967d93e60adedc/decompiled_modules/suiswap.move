module 0x66f23f19bde9c628c909b8e3dff18cc23238f5bc1143c8fa02967d93e60adedc::suiswap {
    public fun a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg0);
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg1, v0, 0x2::coin::value<T0>(&arg0), arg2, arg3);
        0x66f23f19bde9c628c909b8e3dff18cc23238f5bc1143c8fa02967d93e60adedc::self::transfer_or_destroy_coin<T0>(v1, arg3);
        v2
    }

    public fun b2a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg0);
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg1, v0, 0x2::coin::value<T1>(&arg0), arg2, arg3);
        0x66f23f19bde9c628c909b8e3dff18cc23238f5bc1143c8fa02967d93e60adedc::self::transfer_or_destroy_coin<T1>(v1, arg3);
        v2
    }

    // decompiled from Move bytecode v7
}

