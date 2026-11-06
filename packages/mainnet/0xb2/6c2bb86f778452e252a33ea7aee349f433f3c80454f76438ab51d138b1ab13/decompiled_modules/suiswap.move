module 0xb26c2bb86f778452e252a33ea7aee349f433f3c80454f76438ab51d138b1ab13::suiswap {
    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T1, T2>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, 0x2::coin::from_balance<T1>(arg2, arg4));
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T1, T2>(arg1, v0, 0x2::balance::value<T1>(&arg2), arg3, arg4);
        let v3 = v2;
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T1, T2>>(arg1), true, 0x2::coin::value<T2>(&v3));
        (0x2::coin::into_balance<T2>(v3), 0x2::coin::into_balance<T1>(v1))
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T1, T2>, arg2: 0x2::balance::Balance<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v0, 0x2::coin::from_balance<T2>(arg2, arg4));
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T1, T2>(arg1, v0, 0x2::balance::value<T2>(&arg2), arg3, arg4);
        let v3 = v2;
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T1, T2>>(arg1), false, 0x2::coin::value<T1>(&v3));
        (0x2::coin::into_balance<T1>(v3), 0x2::coin::into_balance<T2>(v1))
    }

    // decompiled from Move bytecode v7
}

