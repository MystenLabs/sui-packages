module 0x6dece35176084db8c0bca59197aa0ac5f7f9d0d18d410a1e232feedb6af280f5::sui_swap {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            0x2::balance::zero<T1>()
        } else {
            let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, 0x2::coin::from_balance<T0>(arg1, arg3));
            let (v2, v3) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg0, v1, 0x2::balance::value<T0>(&arg1), arg2, arg3);
            let v4 = v2;
            assert!(0x2::coin::value<T0>(&v4) == 0, 1);
            0x2::coin::destroy_zero<T0>(v4);
            0x2::coin::into_balance<T1>(v3)
        }
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg1) == 0) {
            0x2::balance::destroy_zero<T1>(arg1);
            0x2::balance::zero<T0>()
        } else {
            let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, 0x2::coin::from_balance<T1>(arg1, arg3));
            let (v2, v3) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg0, v1, 0x2::balance::value<T1>(&arg1), arg2, arg3);
            let v4 = v2;
            assert!(0x2::coin::value<T1>(&v4) == 0, 1);
            0x2::coin::destroy_zero<T1>(v4);
            0x2::coin::into_balance<T0>(v3)
        }
    }

    // decompiled from Move bytecode v7
}

