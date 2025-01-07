module 0x9c587b8386c4d15303d74c3f5a3d9fdfafbc0ed0544b5169e1ad22c38e530a3e::suiswap {
    public fun swap_ab<T0, T1>(arg0: &0x9c587b8386c4d15303d74c3f5a3d9fdfafbc0ed0544b5169e1ad22c38e530a3e::control::Permits, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        0x9c587b8386c4d15303d74c3f5a3d9fdfafbc0ed0544b5169e1ad22c38e530a3e::control::valid(arg0, 0x2::tx_context::sender(arg5));
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        let v2 = v1;
        0x9c587b8386c4d15303d74c3f5a3d9fdfafbc0ed0544b5169e1ad22c38e530a3e::help::transfer<T0>(v0, 0x2::tx_context::sender(arg5));
        (v2, 0x2::coin::value<T1>(&v2))
    }

    public fun swap_ab1<T0, T1>(arg0: &0x9c587b8386c4d15303d74c3f5a3d9fdfafbc0ed0544b5169e1ad22c38e530a3e::control::Permits, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T1>>, u64) {
        let (v0, v1) = swap_ab<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v0);
        (v2, v1)
    }

    public fun swap_ba<T0, T1>(arg0: &0x9c587b8386c4d15303d74c3f5a3d9fdfafbc0ed0544b5169e1ad22c38e530a3e::control::Permits, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        0x9c587b8386c4d15303d74c3f5a3d9fdfafbc0ed0544b5169e1ad22c38e530a3e::control::valid(arg0, 0x2::tx_context::sender(arg5));
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        let v2 = v1;
        0x9c587b8386c4d15303d74c3f5a3d9fdfafbc0ed0544b5169e1ad22c38e530a3e::help::transfer<T1>(v0, 0x2::tx_context::sender(arg5));
        (v2, 0x2::coin::value<T0>(&v2))
    }

    public fun swap_ba1<T0, T1>(arg0: &0x9c587b8386c4d15303d74c3f5a3d9fdfafbc0ed0544b5169e1ad22c38e530a3e::control::Permits, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, u64) {
        let (v0, v1) = swap_ba<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

