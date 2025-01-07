module 0x806c71f257021f0f70f2096a49bb3ca3ec6e6afa735935877c9fa01f97a91de4::router {
    public fun do_swap_x_to_y_direct<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg0, 0x1::vector::singleton<0x2::coin::Coin<T0>>(arg1), 0x2::coin::value<T0>(&arg1), arg3, arg4);
        let v2 = v1;
        0x2::coin::destroy_zero<T0>(v0);
        assert!(0x2::coin::value<T1>(&v2) >= arg2, 0);
        v2
    }

    public fun do_swap_y_to_x_direct<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg0, 0x1::vector::singleton<0x2::coin::Coin<T1>>(arg1), 0x2::coin::value<T1>(&arg1), arg3, arg4);
        let v2 = v1;
        0x2::coin::destroy_zero<T1>(v0);
        assert!(0x2::coin::value<T0>(&v2) >= arg2, 0);
        v2
    }

    // decompiled from Move bytecode v6
}

