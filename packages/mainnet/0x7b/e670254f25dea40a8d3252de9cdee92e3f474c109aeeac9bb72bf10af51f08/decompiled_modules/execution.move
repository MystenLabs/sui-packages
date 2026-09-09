module 0x7be670254f25dea40a8d3252de9cdee92e3f474c109aeeac9bb72bf10af51f08::execution {
    public fun maybe_x_to_y<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg2);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, v0);
        let (v2, v3) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg0, v1, 0x2::coin::value<T0>(&v0), arg1, arg3);
        0x2::coin::destroy_zero<T0>(v2);
        0x1::option::some<0x2::coin::Coin<T1>>(v3)
    }

    public fun maybe_y_to_x<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<0x2::coin::Coin<T1>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg2);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, v0);
        let (v2, v3) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg0, v1, 0x2::coin::value<T1>(&v0), arg1, arg3);
        0x2::coin::destroy_zero<T1>(v2);
        0x1::option::some<0x2::coin::Coin<T0>>(v3)
    }

    // decompiled from Move bytecode v7
}

