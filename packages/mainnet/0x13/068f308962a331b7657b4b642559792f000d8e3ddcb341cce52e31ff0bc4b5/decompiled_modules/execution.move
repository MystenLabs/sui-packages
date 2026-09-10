module 0x13068f308962a331b7657b4b642559792f000d8e3ddcb341cce52e31ff0bc4b5::execution {
    public fun maybe_magmapmm_x_to_y<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_x_2_y<T0, T1>(arg0, 0, 0x2::coin::into_balance<T0>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg2)), arg1, arg3);
        0x2::balance::destroy_zero<T0>(v0);
        0x1::option::some<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg3))
    }

    public fun maybe_magmapmm_y_to_x<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<0x2::coin::Coin<T1>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_y_2_x<T0, T1>(arg0, 0, 0x2::coin::into_balance<T1>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg2)), arg1, arg3);
        0x2::balance::destroy_zero<T1>(v1);
        0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3))
    }

    // decompiled from Move bytecode v7
}

