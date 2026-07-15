module 0x86428eee3ad2d6ccb292c295e32d2b39b2657ee62b4393cd1ee9f9a5cf3970c4::mpa {
    public fun sxy<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_x_2_y<T0, T1>(arg0, 0, 0x2::coin::into_balance<T0>(arg1), arg2, arg3);
        0x86428eee3ad2d6ccb292c295e32d2b39b2657ee62b4393cd1ee9f9a5cf3970c4::u::tod<T0>(0x2::coin::from_balance<T0>(v0, arg3), 0x2::tx_context::sender(arg3));
        0x2::coin::from_balance<T1>(v1, arg3)
    }

    public fun syx<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_y_2_x<T0, T1>(arg0, 0, 0x2::coin::into_balance<T1>(arg1), arg2, arg3);
        0x86428eee3ad2d6ccb292c295e32d2b39b2657ee62b4393cd1ee9f9a5cf3970c4::u::tod<T1>(0x2::coin::from_balance<T1>(v1, arg3), 0x2::tx_context::sender(arg3));
        0x2::coin::from_balance<T0>(v0, arg3)
    }

    // decompiled from Move bytecode v7
}

