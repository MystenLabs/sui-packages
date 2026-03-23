module 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::suiswap {
    public fun swap_x_to_y<T0, T1>(arg0: &mut 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::SwapContext, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::take_balance<T0>(arg0);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, 0x2::coin::from_balance<T0>(v0, arg3));
        let (v2, v3) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg1, v1, 0x2::balance::value<T0>(&v0), arg2, arg3);
        0x2::coin::destroy_zero<T0>(v2);
        0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v3));
    }

    public fun swap_y_to_x<T0, T1>(arg0: &mut 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::SwapContext, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::take_balance<T1>(arg0);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, 0x2::coin::from_balance<T1>(v0, arg3));
        let (v2, v3) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg1, v1, 0x2::balance::value<T1>(&v0), arg2, arg3);
        0x2::coin::destroy_zero<T1>(v2);
        0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v3));
    }

    // decompiled from Move bytecode v6
}

